defmodule ThumbnailServer.Worker do
  require Logger
  alias ThumbnailServer.Store

  def submit(thumbnail_path, store) do
    {:ok, min_task} =
      Task.Supervisor.start_child(ThumbnailServer.WorkerSupervisor, fn ->
        execute(thumbnail_path, store, :min)
      end)

    {:ok, mid_task} =
      Task.Supervisor.start_child(ThumbnailServer.WorkerSupervisor, fn ->
        execute(thumbnail_path, store, :mid)
      end)

    {:ok, max_task} =
      Task.Supervisor.start_child(ThumbnailServer.WorkerSupervisor, fn ->
        execute(thumbnail_path, store, :max)
      end)

    {:ok, min_task, mid_task, max_task}
  end

  def execute(thumbnail_path, store, format) when is_binary(thumbnail_path) and is_atom(format) do
    case create_thumbnail(thumbnail_path, to_size(format)) do
      {:ok, created_thumbnail_path} -> Store.add_thumbnail(store, format, created_thumbnail_path)
      _other -> Logger.warn("error while creating thumbnail for #{thumbnail_path}")
    end
  end

  defp create_thumbnail(thumbnail_path, size) when is_integer(size) do
    Logger.info("convert #{thumbnail_path} to #{size}%")
    storage_directory = Application.get_env(:thumbnail_server, :thumbnail_storage_directory)
    thumbnail_filename = "#{size}_" <> Path.basename(thumbnail_path)
    created_thumbnail_path = storage_directory <> "/" <> thumbnail_filename
    exposed_thumbnail_path = "/thumbnails/" <> thumbnail_filename

    Port.open({:spawn_executable, "/usr/bin/convert"},
      args: [thumbnail_path, "-resize", "#{size}%", created_thumbnail_path]
    )

    {:ok, exposed_thumbnail_path}
  end

  defp to_size(:min), do: 25
  defp to_size(:mid), do: 50
  defp to_size(:max), do: 200
end

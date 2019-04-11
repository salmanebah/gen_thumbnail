defmodule ThumbnailServer.Worker do

  def submit(thumbnail_path, store) do
    {:ok, min_task} = Task.Supervisor.start_child(ThumbnailServer.WorkerSupervisor, fn -> execute(thumbnail_path, store, :min) end)
    {:ok, mid_task} = Task.Supervisor.start_child(ThumbnailServer.WorkerSupervisor, fn -> execute(thumbnail_path, store, :mid) end)
    {:ok, max_task} = Task.Supervisor.start_child(ThumbnailServer.WorkerSupervisor, fn -> execute(thumbnail_path, store, :max) end)
    {:ok, min_task, mid_task, max_task}
  end
  
  def execute(thumbnail_path, store, :min) when is_binary(thumbnail_path) do
    
  end

  def execute({thumbnail_path, store, :mid}) when is_binary(thumbnail_path) do
  end

  def execute({thumbnail_path, store, :max}) when is_binary(thumbnail_path) do
  end

  # use private method with Port to call convert file_path -resize :size output_path
  # output_directory is passed from the config: see mix related
  
end

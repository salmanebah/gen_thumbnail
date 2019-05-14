defmodule ThumbnailHTTP.Handler do
  alias ThumbnailServer.Store
  alias ThumbnailServer.Receptor
  alias Plug.Conn

  def get_thumbnails(conn, thumbnail_job_id) do
    case Receptor.retrieve(ThumbnailServer.Receptor, thumbnail_job_id) do
      {:ok, store} ->
        thumbnail_info = Store.get(store)

        conn
        |> Conn.put_resp_content_type("application/json")
        |> Conn.send_resp(:ok, Poison.encode!(thumbnail_info))

      :error ->
        conn |> Conn.put_resp_content_type("application/json") |> Conn.send_resp(:not_found, "")
    end
  end

  def submit_image(conn, filename, path) do
    image_path =
      Application.get_env(:thumbnail_server, :thumbnail_storage_directory) <> "/" <> filename

    File.copy!(path, image_path)

    case Receptor.submit(ThumbnailServer.Receptor, image_path) do
      {:ok, thumbnail_job_id} ->
        conn
        |> Conn.put_resp_content_type("application/json")
        |> Conn.send_resp(:created, Poison.encode!(%{"thumbnail_job_id" => thumbnail_job_id}))

      _ ->
        conn |> Conn.put_resp_content_type("application/json") |> Conn.send_resp(:bad_request, "")
    end
  end
end

defmodule ThumbnailHTTP.Router do
  use Plug.Router
  alias ThumbnailHTTP.Handler

  plug(Plug.Logger)
  plug(:match)
  plug(Plug.Static, at: "/thumbnails", from: "/tmp/thumbnails")
  plug(Plug.Parsers, parsers: [:urlencoded, :multipart], pass: ["*/*"])
  plug(:dispatch)

  post "/thumbnails" do
    %Plug.Upload{filename: filename, path: path} = conn.body_params["image"]
    Handler.submit_image(conn, filename, path)
  end

  get "/thumbnails/:thumbnail_job_id" do
    Handler.get_thumbnails(conn, thumbnail_job_id)
  end

  match _ do
    Plug.Conn.send_resp(conn, 404, "Error")
  end
end

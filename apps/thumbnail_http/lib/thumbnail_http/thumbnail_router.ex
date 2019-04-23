defmodule ThumbnailHTTP.Router do
  use Plug.Router
  alias ThumbnailHTTP.Handler

  plug Plug.Logger
  plug :match
  plug Plug.Static, at: "/thumbnails", from: "/tmp/thumbnail"
  plug :dispatch


  post "/thumbnails" do
    
  end

  get "/thumbnails/:thumbnail_job_id" do
    Handler.get_thumbnails(conn, thumbnail_job_id)
  end

  match _ do
    Plug.Conn.send_resp(conn, 404, "Error")
  end
end

defmodule ThumbnailHTTP.Router do
  use Plug.Router

  plug :match
  plug :dispatch
  plug Plug.Logger

  
end

defmodule ThumbnailServerTest do
  use ExUnit.Case
  doctest ThumbnailServer

  test "greets the world" do
    assert ThumbnailServer.hello() == :world
  end
end

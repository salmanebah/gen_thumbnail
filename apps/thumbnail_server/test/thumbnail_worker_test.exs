defmodule ThumbnailServer.WorkerTest do
  use ExUnit.Case, async: false
  alias ThumbnailServer.{Worker, Store}

  
  setup do
    {:ok, store} = Store.start_link
    %{store: store}

    on_exit fn -> Agent.stop(store) end
  end
  
  test "execute must create thumbnail with min format", %{store: store} do
    {:ok, created_thumbnail_path} = Worker.execute("/tmp/thumbnail/me.jpeg", store, :min)
    assert created_thumbnail_path == "/tmp/thumbnail/25_me.jpeg"
    assert File.exists?("/tmp/thumbnail/25_me.jpeg")
  end
end

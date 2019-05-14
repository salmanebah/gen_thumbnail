defmodule ThumbnailServer.Store do
  use Agent

  def start_link(opts \\ []), do: Agent.start_link(fn -> %ThumbnailInfo{} end, opts)

  def get(store) do
    Agent.get(store, & &1)
  end

  def add_thumbnail(store, :min, url) do
    Agent.update(store, fn current_state -> %{current_state | min_thumbnail_url: url} end)
  end

  def add_thumbnail(store, :mid, url) do
    Agent.update(store, fn current_state -> %{current_state | mid_thumbnail_url: url} end)
  end

  def add_thumbnail(store, :max, url) do
    Agent.update(store, fn current_state -> %{current_state | max_thumbnail_url: url} end)
  end
end

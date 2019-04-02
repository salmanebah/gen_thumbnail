defmodule ThumbnailServer.Receptor do
  use GenServer

  def start_link(opts \\ []) do
    receptor_name = Keyword.fetch!(opts, :name)
    GenServer.start_link(__MODULE__, receptor_name, opts)
  end

  def submit(thumbnail_path) do
  end

  def init(receptor_name) do
  end

  def stop(receptor) do
  end

  def handle_call({:submit, thumbnail_path}, from, receptor_state) do
  end
end

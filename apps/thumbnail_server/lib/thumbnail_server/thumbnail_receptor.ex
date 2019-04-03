defmodule ThumbnailServer.Receptor do
  use GenServer

  def start_link(opts \\ []) do
    receptor_name = Keyword.fetch!(opts, :name)
    GenServer.start_link(__MODULE__, receptor_name, opts)
  end

  def submit(receptor, thumbnail_path) do
    
  end

  def retrieve(receptor, job_id) do
    
  end

  def init(_receptor_name) do
    {:ok, %{}}
  end

  def stop(receptor) do
  end

  def handle_call({:submit, thumbnail_path}, from, receptor_state) do
  end
end

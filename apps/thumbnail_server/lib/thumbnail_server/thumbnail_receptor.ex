defmodule ThumbnailServer.Receptor do
  use GenServer
  require Logger
  

  def start_link(opts \\ []) do
    receptor_name = Keyword.fetch!(opts, :name)
    GenServer.start_link(__MODULE__, receptor_name, opts)
  end

  def submit(receptor, thumbnail_path) do
    GenServer.call(receptor, {:submit, thumbnail_path})
  end

  def retrieve(receptor, job_id) do
    GenServer.call(receptor, {:retrieve, job_id})
  end

  def init(_receptor_name) do
    {:ok, %{}}
  end

  def stop(receptor) do
    GenServer.stop(receptor)
  end

  def handle_call({:submit, thumbnail_path}, _from, receptor_state) do
    job_id = UUID.uuid1()
    {:ok, store} = DynamicSupervisor.start_child(ThumbnailServer.StoreSupervisor, ThumbnailServer.Store)
    # add child monitoring here, create worker
    {:ok, _min_task, _mid_task, _max_task} = ThumbnailServer.Worker.submit(thumbnail_path, store)
    {:reply, {:ok, job_id}, Map.put(receptor_state, job_id, store)}
  end

  def handle_call({:retrieve, job_id}, _from, receptor_state) do
    {:reply, Map.fetch(receptor_state, job_id), receptor_state}
  end
end

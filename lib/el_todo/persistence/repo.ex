defmodule ElTodo.Persistence.Repo do
  use GenServer
  alias ElTodo.Tasks.Task

  @spec start_link(any()) :: {:ok, pid()} | {:error, any()}
  def start_link(_opt) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  @spec add(String.t()) :: {:ok, Task.t()}
  def add(title) do
    task = Task.new(title)
    GenServer.call(__MODULE__, {:add, task})
  end

  @spec list() :: list(Task.t())
  def list do
    GenServer.call(__MODULE__, {:list})
  end

  @spec remove(String.t()) :: {:ok, Task.t()}
  def remove(id) do
    GenServer.call(__MODULE__, {:remove, id})
  end

  @spec update(String.t(), atom()) :: {:ok, Task.t()}
  def update(id, new_status) do
    GenServer.call(__MODULE__, {:update, id, new_status})
  end

  ## === GEN_SERVER CALLBACKS ===
  def init(init_arg), do: {:ok, init_arg}

  @spec handle_call({:add, Task.t()}, {pid(), any()}, list(Task.t())) :: {:reply, {:ok, Task.t()}, list(Task.t())}
  def handle_call({:add, task}, _from, state) do
    {:reply, {:ok, task}, [task | state]}
  end

  @spec handle_call({:list}, {pid(), any()}, list(Task.t())) :: {:reply, {:ok, list(Task.t())}, list(Task.t())}
  def handle_call({:list}, _from, state) do
    {:reply, state, state}
  end

  @spec handle_call({:remove, String.t()}, {pid(), any()}, list(Task.t())) :: {:reply, {:ok, list(Task.t())} | {:error, String.t()}, list(Task.t())}
  def handle_call({:remove, id}, _from, state) do
    if Enum.any?(state, fn task -> task.id == id end) do
      new_state = Enum.reject(state, &(&1.id == id))
      {:reply, {:ok, new_state}, new_state}
    else
      {:reply, {:error, "This task doesn't exist :("}, state}
    end
  end

  @spec handle_call({:update, String.t(), atom()}, {pid(), any()}, list(Task.t())) :: {:reply, {:ok, Task.t()} | {:error, String.t()}, list(Task.t())}
  def handle_call({:update, id, new_status}, _from, state) do
    case Enum.find(state, fn task -> task.id == id end) do
      nil -> {:reply, {:error, "This task doesn't exist :("}, state}
      task ->
        updated_task = %{task | status: new_status}
        updated_state = Enum.map(state, fn task -> if task.id == id, do: updated_task, else: task end)
        {:reply, {:ok, updated_task}, updated_state}
    end
  end
end

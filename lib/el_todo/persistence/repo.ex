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

  @spec handle_call({:remove, String.t()}, {pid(), any()}, list(Task.t())) :: {:reply, :ok | :error, list(Task.t())}
  def handle_call({:remove, id}, _from, state) do
    if Enum.any?(state, fn task -> task.id == id end) do
      new_state = Enum.reject(state, &(&1.id == id))
      {:reply, :ok, new_state}
    else
      IO.puts("This task doesn't exist :(")
      {:reply, :error, state}
    end
  end
end

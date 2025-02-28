defmodule ElTodo.Manager do
  alias ElTodo.Persistence.Repo

  @spec add_task(String.t()) :: {:ok, ElTodo.Tasks.Task.t()}
  def add_task(title) do
    Repo.add(title)
  end

  @spec list_tasks() :: [ElTodo.Tasks.Task.t()]
  def list_tasks() do
    Repo.list()
  end

  @spec delete_task(String.t()) :: {:ok, [ElTodo.Tasks.Task.t()]} | {:error, String.t()}
  def delete_task(id) do
    Repo.remove(id)
  end

  @spec update_task(String.t(), atom()) :: {:ok, ElTodo.Tasks.Task.t()} | {:error, String.t()}
  def update_task(id, new_status) do
    Repo.update(id, new_status)
  end
end

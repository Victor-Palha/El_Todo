defmodule ElTodo.Application do
  use Application

  def start(_type, _args) do
    children = [
      {ElTodo.Persistence.Repo, []}
    ]

    opts = [strategy: :one_for_one, name: ElTodo.Application]
    Supervisor.start_link(children, opts)
  end
end

defmodule ElTodo.Tasks.Task do
  alias Utils.Uuid
  defstruct [:id, :title, :status]
  @type t :: %__MODULE__{
    id: String.t(),
    title: String.t(),
    status: atom()
  }


  @spec new(String.t()) :: %ElTodo.Tasks.Task{id: String.t(), status: :pending, title: String.t()}
  def new(title) do
    id = Uuid.generate_uuid()
    %__MODULE__{
      id: id,
      title: title,
      status: :pending
    }
  end
end

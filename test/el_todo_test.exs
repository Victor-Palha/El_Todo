defmodule ElTodoTest do
  use ExUnit.Case
  doctest ElTodo

  test "greets the world" do
    assert ElTodo.hello() == :world
  end
end

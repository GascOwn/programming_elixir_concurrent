defmodule ProgrammingElixirConcurrentTest do
  use ExUnit.Case
  doctest ProgrammingElixirConcurrent

  test "greets the world" do
    assert ProgrammingElixirConcurrent.hello() == :world
  end
end

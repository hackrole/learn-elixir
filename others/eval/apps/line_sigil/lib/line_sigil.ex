defmodule LineSigil do
  @moduledoc """
  实现 ~l magic symbol, it accept multi-line string
  and return the list of these strings

  ## example
    iex> import LineSigil
    nil
    iex> ~l"
    ...> one
    ...> two
    ...> three
    ...> "
    ["one", "two", "three"]
  """
  def sigil_l(lines, _opts) do
    lines |> String.rstrip |> String.split("\n")
  end
end

defmodule Test do
  import LineSigil
  def run do
    a = ~l"""
    line 1
    line 2
    line 3
    and other line in #{__MODULE__}
    """
    IO.inspect a
  end
end

Test.run

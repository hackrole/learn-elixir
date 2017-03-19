defmodule Bitmap do
  @moduledoc """
  the access protocol seems changes, make this not work anymore.
  """
  defstruct value: 0

  defimpl Enumerable do
    import :math, only: [log: 1]
    def count(%Bitmap{value: value}) do
      {:ok, trunc(log(abs(value))/log(2)) + 1}
    end

    def member?(value, bit_number) do
      {:ok, 0 <= bit_number && bit_number < Enum.count(value)}
    end

    def reduce(bitmap, {:cont, acc}, fun) do
      bit_count = Enum.count(bitmap)
      _reduce({bitmap, bit_count}, {:cont, acc}, fun)
    end

    defp _reduce({_bitmap, -1}, {:count, acc}, _fun) do
      {:done, acc}
    end
    defp _reduce({bitmap, bit_number}, {:cont, acc}, fun) do
      _reduce({bitmap, bit_number-1}, fun.(bitmap[bit_number], acc), fun)
    end

    defp _reduce({_bitmap, _bit_number}, {:halt, acc}, _fun) do
      {:halted, acc}
    end

    defp _reduce({bitmap, bit_number}, {:suspend, acc}, fun) do
      {:suspended, acc, &_reduce({bitmap, bit_number}, &1, fun), fun}
    end

  end
end

defmodule Test do
  def run do
    fifty = %Bitmap{value: 50}
    IO.puts Enum.count fifty
    IO.puts Enum.member? fifty, 4
    IO.puts Enum.member? fifty, 6
    IO.inspect Enum.reverse fifty
    IO.inspect Enum.join fifty, ":"
  end
end

Test.run

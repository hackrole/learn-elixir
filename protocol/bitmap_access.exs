defmodule Bitmap do
  defstruct value: 0
end

defimpl Access do
  @moduledoc """
  the access protocol has been removed.
  so this example would not work now.
  """
  use Bitwise

  def get(%Bitmap{value: value}, bit) do
    if (value &&& (1 <<< bit)) == 0, do: 0, else: 1
  end
  def get_and_update(bitmap=%Bitmap{value: value}, bit, accessor_fn) do
    old_value = get(bitmap, bit)
    new_value = accessor_fn.(old_value)
    value = (value &&& bnot(1 <<< bit )) ||| (new_value <<< bit)
    %Bitmap{value: value}
  end
end

defmodule Test do
  def run do
    fifty = %Bitmap{value: 50}
    [5,4,3,2,1] |> Enum.each(fn bit -> IO.puts fifty[bit] end)
    get_and_update_in fifty[1], fn bit -> 1 - bit end
  end
end

Test.run

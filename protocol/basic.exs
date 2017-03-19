defmodule Blob do
  defstruct content: nil
end

defmodule Test do
  def run do
    b = %Blob{content: 123}
    IO.inspect b
    IO.inspect b, structs: false
  end
end

Test.run

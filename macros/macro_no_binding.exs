defmodule My do
  defmacro mydef(name) do
    quote do
      def unquote(name)(), do: unquote(name)
    end
  end
end

defmodule Test do
  require My
  # this raise syntax error
  [:fred, :bert] |> Enum.each(&My.mydef(&1))
end

IO.puts Test.fred

defprotocol Colletion do
  @fallback_to_any true
  def is_collection?(value)
end

defimpl Colletion, for: [List, Tuple, BitString] do
  def is_collection?(_), do: true
end

defimpl Colletion, for: Any do
  def is_collection?(_), do: false
end

Enum.each [1, 1.0, [1,2], {1,2}, HashDict.new, "cat"], fn value ->
  IO.puts "#{inspect value}: #{Colletion.is_collection?(value)}"
end

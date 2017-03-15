defmodule SpawnBasic do
  def greet do
    IO.puts "hello"
  end
end

SpawnBasic.greet
pid = spawn(SpawnBasic, :greet, [])
IO.inspect pid

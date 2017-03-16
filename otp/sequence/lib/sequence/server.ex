defmodule Sequence.Server do
  use GenServer

  def init(stash_pid) do
    current_number = Sequence.Stash.get_value stash_pid
    {:ok, {current_number, stash_pid}}
  end
  def handle_call(:next_number, _from, current_number) do
    {:reply, current_number, current_number+1}
  end

  def handle_call({:set_number, new_number}, _from, _current_number) do
    {:reply, new_number, new_number}
  end

  def handle_call({:factors, number}, _form, _current_numbner) do
    {:reply, {:factors_of, number, number}, []}
  end

  def handle_cast({:increment_number, delta}, current_number) do
    {:noreply, current_number + delta}
  end

  def format_status(_reason, [_pdict, state]) do
    [data: [{'State', "My current state is '#{inspect state}', and I'm happy"}]]
  end

  def terminate(_reason, {current_number, stash_pid}) do
    Sequence.Stash.save_value stash_pid, current_number
  end

  # client api
  def start_link(stash_pid) do
    GenServer.start_link(__MODULE__, stash_pid, name: __MODULE__)
  end

  def next_number do
    GenServer.call __MODULE__, :next_number
  end

  def increment_number(delta) do
    GenServer.cast __MODULE__, {:increment_number, delta}
  end
end

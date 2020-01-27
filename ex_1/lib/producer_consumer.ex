defmodule AdventOfCode.ProducerConsumer do
  use GenStage

  require Integer

  def start_link do
    GenStage.start_link(__MODULE__, :state_doesnt_matter, name: __MODULE__)
  end

  def init(state) do
    {:producer_consumer, state, subscribe_to: [AdventOfCode.Producer]}
  end

  def handle_events(inputValues, _from, state) do
    events = [Enum.map(inputValues, fn x -> Integer.floor_div(x, 3) - 2 end) |> Enum.sum]
    {:noreply, events, state}
  end
end

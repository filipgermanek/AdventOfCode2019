defmodule AdventOfCode.ProducerConsumer do
  use GenStage

  require Integer

  def start_link do
    GenStage.start_link(__MODULE__, :state_doesnt_matter, name: __MODULE__)
  end

  def init(state) do
    {:producer_consumer, state, subscribe_to: [AdventOfCode.Producer]}
  end

  def calculateFuel(mass) do
    result = Integer.floor_div(mass, 3) - 2
    if (result < 0) do
      0
    else
      result + calculateFuel(result)
    end
  end

  def handle_events(inputValues, _from, state) do
    events = [Enum.map(inputValues, &calculateFuel/1) |> Enum.sum]
    {:noreply, events, state}
  end
end

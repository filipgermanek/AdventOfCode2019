defmodule SimpleQueue do
  use GenServer

  ### GenServer API

  @doc """
  GenServer.init/1 callback
  """
  def init(state), do: {:ok, state}

  @doc """
  GenServer.handle_call/3 callback
  """
  def handle_call(:dequeue, _from, [value | state]) do
    {:reply, value, state}
  end

  def handle_call(:dequeue, _from, []), do: {:reply, nil, []}

  def handle_call(:queue, _from, state), do: {:reply, state, state}

  @doc """
  GenServer.handle_cast/2 callback
  """
  def handle_cast({:enqueue, value}, state) do
    {:noreply, state ++ [value]}
  end

  ### Client API / Helper functions

  def start_link(state \\ []) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  def queue, do: GenServer.call(__MODULE__, :queue)
  def enqueue(value), do: GenServer.cast(__MODULE__, {:enqueue, value})
  def dequeue, do: GenServer.call(__MODULE__, :dequeue)

  def processElement(inputArray, opcodeIndex) do
    opcode = Enum.at(inputArray, opcodeIndex)
    if opcode == 99 || opcode == nil do
      Enum.at(inputArray, 0)
    else
      indexOne = Enum.at(inputArray, opcodeIndex + 1)
      indexTwo = Enum.at(inputArray, opcodeIndex + 2)
      resultIndex = Enum.at(inputArray, opcodeIndex + 3)
      modifiedArray = inputArray |> Enum.with_index |> Enum.map(fn {el, index} ->
          if index == resultIndex do
            if opcode == 1 do
              Enum.at(inputArray, indexOne) + Enum.at(inputArray, indexTwo)
            else
             Enum.at(inputArray, indexOne) * Enum.at(inputArray, indexTwo)
            end
          else
            el
          end
        end)
      processElement(modifiedArray, opcodeIndex + 4)
    end
  end

  def loadDataToQueue do
    input =[1,12,2,3,1,1,2,3,1,3,4,3,1,5,0,3,2,13,1,19,1,5,19,23,2,10,23,27,1,27,5,31,2,9,31,35,1,35,5,39,2,6,39,43,1,43,5,47,2,47,10,51,2,51,6,55,1,5,55,59,2,10,59,63,1,63,6,67,2,67,6,71,1,71,5,75,1,13,75,79,1,6,79,83,2,83,13,87,1,87,6,91,1,10,91,95,1,95,9,99,2,99,13,103,1,103,6,107,2,107,6,111,1,111,2,115,1,115,13,0,99,2,0,14,0]
    SimpleQueue.start_link(input)
    processElement(input, 0)
  end
end

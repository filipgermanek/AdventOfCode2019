defmodule Ex4 do
  def hasSameNumNextToEachOther(numDigits, index) do
    cond do
      Enum.count(numDigits) == index + 1 -> false
      Enum.at(numDigits, index) == Enum.at(numDigits, index + 1)
      && Enum.at(numDigits, index) != Enum.at(numDigits, index - 1)
      && Enum.at(numDigits, index) != Enum.at(numDigits, index + 2)-> true
      true -> hasSameNumNextToEachOther(numDigits, index + 1)
    end
  end
  def validateNumber(num) do
    numDigits = Integer.digits(num)
    Enum.sort(numDigits) == numDigits && hasSameNumNextToEachOther(numDigits, 0)
  end
  def processNum(num, rangeEnd, answer) do
    cond do
      num == rangeEnd -> answer
      validateNumber(num) -> processNum(num + 1, rangeEnd, answer + 1)
      true -> processNum(num + 1, rangeEnd, answer)
    end
  end

  def calculateAnswer do
    #vars below need to be modified to match input u get from exercise
    rangeStart = 136760
    rangeEnd = 595730
    processNum(rangeStart, rangeEnd, 0)
  end
end

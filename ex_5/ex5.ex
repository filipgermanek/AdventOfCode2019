defmodule Ex5 do
  def getOpcode(number) do
    splitNum= Integer.digits(number)
    firstNumber= append(Enum.count(splitNum), splitNum)
    if(Enum.at(firstNumber, 3)== 0) do
      opcode= Enum.at(firstNumber,4)
    else
      opcode= String.to_integer(Integer.to_string(Enum.at(firstNumber, 3)) <> "" <> Integer.to_string(Enum.at(firstNumber, 4)))
    end
  end

  def getMode(number, paramNumber) do
    splitNum= Integer.digits(number)
    firstNumber= append(Enum.count(splitNum), splitNum)
    # for which parameter we need the opcode
    cond do
      paramNumber === 1 -> Enum.at(firstNumber, 2)
      paramNumber === 2 -> Enum.at(firstNumber, 1)
      paramNumber === 3 -> Enum.at(firstNumber, 0)
    end
  end

  def getValue(param, mode, inputArray) do
    if mode == 0 do
      Enum.at(inputArray, param)
    else
      param
    end
  end

  def processInput(param1, param2, param3, opcode, param1Mode, param2Mode, param3Mode, inputArray) do
    IO.inspect "opcode is #{opcode}"
    cond do
      opcode==99 ->
        inputArray
      opcode==1 ->
        value1 = getValue(param1, param1Mode, inputArray)
        value2 = getValue(param2, param2Mode, inputArray)
        List.replace_at(inputArray, param3, value1 + value2)
      opcode==2 ->
        value1 = getValue(param1, param1Mode, inputArray)
        value2 = getValue(param2, param2Mode, inputArray)
        List.replace_at(inputArray, param3, value1 * value2)
      opcode==3 ->
        value = readInput
        List.replace_at(inputArray, param1, value)
      opcode==4 ->
        IO.inspect "param1 #{param1} param1Mode #{param1Mode}"
        value = getValue(param1, param1Mode, inputArray)
        IO.puts value
        inputArray
      opcode == 5 ->

        #if param1 is NOT 0 go to index = getValue(param2) else just skip to next instruction
        value1 = getValue(param1, param1Mode, inputArray)
        if value1 != 0 do
          value2 = getValue(param2, param2Mode, inputArray)
          #TODO this is wrong because after this is done processing index is back to previous value
          processInstruction(value2, inputArray)
        else
          IO.inspect "should be printed"
          inputArray
        end
      opcode == 6 ->
        #if param1 is 0 go to index = getValue(param2) else just skip to next instruction
        value1 = getValue(param1, param1Mode, inputArray)
        if value1 == 0 do
          value2 = getValue(param2, param2Mode, inputArray)
            #TODO this is wrong because after this is done processing index is back to previous value
          processInstruction(value2, inputArray)
        else
          inputArray
        end
      opcode == 7 ->
        # if param1 < param2 store 1 in the position given by param3 else store 0 in the position given by param3
        if  getValue(param1, param1Mode, inputArray) < getValue(param2, param2Mode, inputArray) do
          List.replace_at(inputArray, param3, 1)
        else
          List.replace_at(inputArray, param3, 0)
        end
      opcode == 8 ->
        # if param1 == param2 store 1 in the position given by param3 else store 0 in the position given by param3
        if  getValue(param1, param1Mode, inputArray) == getValue(param2, param2Mode, inputArray) do
          List.replace_at(inputArray, param3, 1)
        else
          List.replace_at(inputArray, param3, 0)
        end
    end
  end

  def readInput  do
    tempInput = IO.gets("enter number" )
    input = String.to_integer(String.slice(tempInput, 0..String.length(tempInput)-2))
  end

  def append(currentIteration, collection) do
    cond do
      currentIteration < 5 -> append(currentIteration+1, [0]++collection)
      true -> collection
    end
  end

  def processInstruction(startIndex, inputArray) do
  #  IO.inspect "loop at index #{startIndex}"
    instruction = Enum.at(inputArray, startIndex)
    opcode = getOpcode(instruction)
    if opcode == 99 do
      nil
    else
      param1 = Enum.at(inputArray, startIndex + 1)
      param2 = Enum.at(inputArray, startIndex + 2)
      param3 = Enum.at(inputArray, startIndex + 3)
      param1Mode = getMode(instruction, 1)
      param2Mode = getMode(instruction, 2)
      param3Mode = getMode(instruction, 3)
      # TODO you have to process opcode 5 and 6 here because if its processed in processInstruction function after index is back to previous value
      if opcode == 5 || opcode == 6 do

      end
      modifiedInputArray = processInput(param1, param2, param3, opcode, param1Mode, param2Mode, param3Mode, inputArray)
      isThreeParamOpcode = opcode == 1 || opcode == 2 || opcode == 7 || opcode == 8
      isOneParamOpcode = opcode == 3 || opcode == 4
      isTwoParamOpcode = opcode == 5 || opcode == 6
      IO.inspect modifiedInputArray
      IO.inspect "opcode dd is #{opcode} startIndex #{startIndex}"
      if (isThreeParamOpcode && Enum.at(modifiedInputArray, startIndex + 4) != nil)
        || (isOneParamOpcode && Enum.at(modifiedInputArray, startIndex + 2) != nil)
        || (isTwoParamOpcode && Enum.at(modifiedInputArray, startIndex + 3) != nil) do
        cond do
          isOneParamOpcode -> processInstruction(startIndex + 2, modifiedInputArray)
          isTwoParamOpcode -> processInstruction(startIndex + 3, modifiedInputArray)
          isThreeParamOpcode -> processInstruction(startIndex + 4, modifiedInputArray)
        end
      end
    end
  end

  def start do
   # inputArray = [3,225,1,225,6,6,1100,1,238,225,104,0,1101,91,67,225,1102,67,36,225,1102,21,90,225,2,13,48,224,101,-819,224,224,4,224,1002,223,8,223,101,7,224,224,1,223,224,223,1101,62,9,225,1,139,22,224,101,-166,224,224,4,224,1002,223,8,223,101,3,224,224,1,223,224,223,102,41,195,224,101,-2870,224,224,4,224,1002,223,8,223,101,1,224,224,1,224,223,223,1101,46,60,224,101,-106,224,224,4,224,1002,223,8,223,1001,224,2,224,1,224,223,223,1001,191,32,224,101,-87,224,224,4,224,102,8,223,223,1001,224,1,224,1,223,224,223,1101,76,90,225,1101,15,58,225,1102,45,42,224,101,-1890,224,224,4,224,1002,223,8,223,1001,224,5,224,1,224,223,223,101,62,143,224,101,-77,224,224,4,224,1002,223,8,223,1001,224,4,224,1,224,223,223,1101,55,54,225,1102,70,58,225,1002,17,80,224,101,-5360,224,224,4,224,102,8,223,223,1001,224,3,224,1,223,224,223,4,223,99,0,0,0,677,0,0,0,0,0,0,0,0,0,0,0,1105,0,99999,1105,227,247,1105,1,99999,1005,227,99999,1005,0,256,1105,1,99999,1106,227,99999,1106,0,265,1105,1,99999,1006,0,99999,1006,227,274,1105,1,99999,1105,1,280,1105,1,99999,1,225,225,225,1101,294,0,0,105,1,0,1105,1,99999,1106,0,300,1105,1,99999,1,225,225,225,1101,314,0,0,106,0,0,1105,1,99999,1008,677,677,224,102,2,223,223,1005,224,329,1001,223,1,223,1108,677,226,224,1002,223,2,223,1006,224,344,101,1,223,223,107,677,226,224,1002,223,2,223,1006,224,359,101,1,223,223,108,677,677,224,1002,223,2,223,1006,224,374,1001,223,1,223,108,226,677,224,1002,223,2,223,1006,224,389,101,1,223,223,7,226,677,224,102,2,223,223,1006,224,404,1001,223,1,223,1108,677,677,224,1002,223,2,223,1005,224,419,101,1,223,223,1008,226,677,224,102,2,223,223,1006,224,434,101,1,223,223,107,226,226,224,102,2,223,223,1005,224,449,1001,223,1,223,1007,677,677,224,1002,223,2,223,1006,224,464,1001,223,1,223,1007,226,226,224,1002,223,2,223,1005,224,479,101,1,223,223,1008,226,226,224,102,2,223,223,1006,224,494,1001,223,1,223,8,226,226,224,102,2,223,223,1006,224,509,101,1,223,223,1107,677,677,224,102,2,223,223,1005,224,524,1001,223,1,223,1108,226,677,224,1002,223,2,223,1006,224,539,101,1,223,223,1107,677,226,224,1002,223,2,223,1006,224,554,101,1,223,223,1007,677,226,224,1002,223,2,223,1005,224,569,101,1,223,223,7,677,226,224,1002,223,2,223,1006,224,584,101,1,223,223,107,677,677,224,1002,223,2,223,1005,224,599,1001,223,1,223,8,226,677,224,1002,223,2,223,1005,224,614,101,1,223,223,7,677,677,224,1002,223,2,223,1006,224,629,1001,223,1,223,1107,226,677,224,1002,223,2,223,1006,224,644,101,1,223,223,108,226,226,224,102,2,223,223,1005,224,659,1001,223,1,223,8,677,226,224,1002,223,2,223,1005,224,674,101,1,223,223,4,223,99,226]
   inputArray = [3,3,1105,-1,9,1101,0,0,12,4,12,99,1]
   processInstruction(0, inputArray)
  end

end

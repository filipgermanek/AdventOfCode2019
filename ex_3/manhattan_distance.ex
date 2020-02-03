defmodule ManhattanDistance do
  def recogniseDirection(direction, x, y, value, finalValue, elements) do
    cond do
      direction == "R" -> createPoint(direction, x + 1, y, value + 1, finalValue, elements)
      direction == "L" -> createPoint(direction, x - 1 , y, value + 1, finalValue, elements)
      direction == "U" -> createPoint(direction, x, y + 1 , value + 1, finalValue, elements)
      direction == "D" -> createPoint(direction, x, y - 1, value + 1, finalValue, elements)
    end
  end

  def createPoint(direction, x, y, value, finalValue, elements) do
    cond do
      value < finalValue -> recogniseDirection(direction, x, y, value, finalValue, elements ++ [[x, y]])
      value == finalValue -> elements ++ [[x, y]]
    end
  end

  def addGridPointToMap(instructionsArray, index, x, y, elements) do
    atomElement = Enum.at(instructionsArray, index)
    instruction = Atom.to_string(atomElement)
    direction = String.slice(instruction, 7..7)
    value = String.to_integer(String.slice(instruction, 8..String.length(instruction)))
  #  IO.inspect(elements)
    newElements = recogniseDirection(direction, x, y, 0, value, elements)
  # IO.inspect(newElements)
    if Enum.at(instructionsArray, index + 1) != nil do
      coords = Enum.at(newElements, Enum.count(newElements) - 1)
      addGridPointToMap(instructionsArray, index + 1, Enum.at(coords, 0), Enum.at(coords, 1), newElements)
    else
      newElements
    end

  end

  def getWireCoordinates(instructionsArray) do
    addGridPointToMap(instructionsArray, 0, 0, 0, [])
  end

  def init do
    inputOne =[R990,U796,R784,U604,R6,U437,L96,U285,L361,U285,L339,D512,L389,D840,L425,U444,L485,D528,L262,U178,L80,U2,R952,U459,L361,D985,R56,U135,R953,D913,L361,U120,L329,U965,L294,U890,L126,U214,R232,D444,L714,U791,R888,U923,R378,U233,L654,D703,R902,D715,R469,D60,R990,U238,R755,U413,L409,D601,R452,U504,R472,D874,L766,D594,R696,U398,R593,D889,R609,D405,L962,U176,L237,U642,L393,D91,L463,U936,R199,D136,R601,D8,R359,D863,L410,U598,L444,D34,R664,D323,R72,D98,L565,D476,L197,D132,R510,U665,R936,U3,R385,U144,L284,D713,L605,U106,R543,D112,R528,D117,R762,U330,R722,U459,L229,U375,L870,D81,R623,U95,L148,D530,L622,D62,R644,D365,L214,U847,R31,D832,L648,D293,R79,D748,L270,U159,L8,U83,R195,U912,L409,D649,L750,D286,L623,D956,R81,U775,R44,D437,L199,U698,L42,U419,L883,U636,L323,U89,L246,D269,L992,U739,R62,U47,R63,U17,L234,U135,R126,D208,L69,U550,L123,D66,R463,U992,R411,D276,L851,U520,R805,D300,L894,U171,L922,D901,R637,U907,R328,U433,L316,D644,L398,U10,L648,D190,R884,U474,R397,D718,L925,D578,R249,U959,L697,D836,R231,U806,R982,U827,R579,U830,L135,D666,R818,D502,L898,D585,R91,D190,L255,U535,R56,U390,R619,D815,L300,D81,R432,D70,L940,D587,L259,D196,R241,U4,R440,U678,R185,U451,R733,D984,R464,D298,L738,U600,R353,D44,L458,U559,L726,D786,L307,D333,L226,D463,R138,D142,L521,D201,R51,D202,L204,U130,L333,U597,R298,U42,L951,U66,R312,U707,L555,D225,L360,D12,L956,D361,L989,D625,L944,D398,L171,D982,L377,U114,L339,U164,R39,D793,R992,U834,R675,U958,R334,D697,L734,D40,L149,U394,R976]
    t(inputOne, 0, [])
    #Enum.map(inputOne, fn el -> createPath() end)
  end

  def t(inputArray, index, result) do
    if Enum.at(result, index - 1) != nil do
      startPoint = Enum.at(result, index - 1)
      line = createPath(startPoint, Enum.at(inputArray, index))
      if Enum.at(inputArray, index + 1) == nil do
        result ++ [line]
      else
        t(inputArray, index + 1, result ++ [line])
      end
    else
      startPoint =[0,0]
      line = createPath(startPoint, Enum.at(inputArray, index))
       if Enum.at(inputArray, index + 1) == nil do
      result ++ [line]
    else
      t(inputArray, index + 1, result ++ [line])
    end
    end


  end

  def createPath(startPoint, command) do
    instruction = Atom.to_string(command)
    direction = String.slice(instruction, 7..7)
    value = String.to_integer(String.slice(instruction, 8..String.length(instruction)))
    cond do
      direction == "R" -> [Enum.at(startPoint, 0) + value, Enum.at(startPoint, 1)]
      direction == "L" -> [Enum.at(startPoint, 0) - value, Enum.at(startPoint, 1)]
      direction == "U" -> [Enum.at(startPoint, 0), Enum.at(startPoint, 1) + value]
      direction == "D" -> [Enum.at(startPoint, 0), Enum.at(startPoint, 1) - value]
    end

  end
end

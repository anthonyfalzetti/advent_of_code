defmodule AdventOfCode.Y2018.Day1Test do
  use ExUnit.Case
  alias AdventOfCode.Y2019.Day1

  test "calculates the weight of equipment and weight of fuel" do
    assert Day1.calculate_fuel(1969) == 966
  end
end

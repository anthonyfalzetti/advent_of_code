defmodule AdventOfCode.Y2019.Day2Test do
  use ExUnit.Case
  alias AdventOfCode.Y2019.Day2

  describe "#calulcate (part 1)" do
    test "does addition" do
      assert Day2.calculate([1,0,0,0,99]) == [2,0,0,0,99]
    end

    test "does multiplication" do
      assert Day2.calculate([2,3,0,3,99]) == [2,3,0,6,99]
    end

    test "stops on 99" do
      assert Day2.calculate([2,4,4,5,99,0]) == [2,4,4,5,99,9801]
    end

    test "chunks every 4" do
      assert Day2.calculate([1,1,1,4,99,5,6,0,99]) == [30,1,1,4,2,5,6,0,99]
    end
  end

  test "Can do 3 chunks" do
    assert Day2.calculate([1,9,10,3,2,3,11,0,99,30,40,50]) == [3500,9,10,70,2,3,11,0,99,30,40,50]
  end
end

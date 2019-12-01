defmodule AdventOfCode.Y2019.Day1 do

  def calculate_fuel_for_spacecraft do
    equipment_list()
    |> Enum.map(&calculate_fuel(&1))
    |> Enum.sum
  end

  def calculate_fuel(mass) do
    calculate_fuel_for_equipment(mass, [])
    |> Enum.sum
  end

  defp calculate_fuel_for_equipment(mass, values) do
    fuel_for_mass = calc_fuel_for_mass(mass)

    case fuel_for_mass > 0 do
      true ->
        updated_values = [fuel_for_mass | values]

        calculate_fuel_for_equipment(fuel_for_mass, updated_values)
      false ->
        values
    end
  end

  defp calc_fuel_for_mass(mass), do: div(mass, 3) - 2

  defp equipment_list do
    File.stream!("./support/2019/day_1_weights.txt", [], :line)
    |> Stream.map(fn(line) ->
      line
      |> String.trim()
      |> Integer.parse()
      |> elem(0)
    end)
  end
end

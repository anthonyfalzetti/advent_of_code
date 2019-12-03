defmodule AdventOfCode.Y2019.Day2 do

  def calculate(input \\ raw_input) do
    maybe_step_forward(0, input)
    |> do_calculation(input, 0)
  end

  def calculate_part_two do
    for noun <- 0..99, verb <- 0..99 do
      output = do_calculation_part_two(noun, verb)
      |> List.first

      if output == 19690720 do
        IO.puts inspect """
        noun: #{noun}
        verb: #{verb}
        Calculation: #{100 * noun + verb}
        """
      end
    end
  end

  defp do_calculation_part_two(noun, verb) do
    input = raw_input
    |> List.update_at(1, fn(x) -> noun end)
    |> List.update_at(2, fn(x) -> verb end)

    maybe_step_forward(0, input)
    |> do_calculation(input, 0)
  end

  defp maybe_step_forward(counter, whole_input) do
    total_times = div(length(whole_input), 4)
    continue? = total_times >= counter

    # IO.puts """
    # Run #{counter}/#{total_times}
    # continue? #{continue?}
    # """

    case continue? do
      true ->
        sublist = whole_input
        |> Enum.chunk_every(4)
        |> Enum.fetch!(counter)
        # |> IO.inspect(label: "sublist")

        {:ok, sublist}
      false ->
        {:stop, whole_input}
    end
  end

  defp do_calculation({:stop, _whole_input}, whole_input, _counter) do
    whole_input
  end

  defp do_calculation({:ok, sublist}, whole_input, counter) do
    case do_calculation(sublist, whole_input) do
      {:ok, updated_values} ->
        maybe_step_forward((counter + 1), updated_values)
        |> do_calculation(updated_values, (counter + 1))
      {:stop, whole_input} ->
        whole_input
    end
  end

  defp do_calculation([1, first_position, second_position, target | tail], whole_input) do
    value1 = Enum.fetch!(whole_input, first_position)
    value2 = Enum.fetch!(whole_input, second_position)
    updated_input = List.update_at(whole_input, target, fn(x) ->
      value1 + value2
    end)

    # IO.puts """
    # do_calculation addition
    # value1: #{value1}
    # value2: #{value2}
    # target: #{target}
    # whole_input: #{inspect(whole_input)}
    # updated_input: #{inspect(updated_input)}
    # """

    {:ok, updated_input}
  end

  defp do_calculation([2, first_position, second_position, target | tail], whole_input) do
    value1 = Enum.fetch!(whole_input, first_position)
    value2 = Enum.fetch!(whole_input, second_position)
    updated_input = List.update_at(whole_input, target, fn(x) ->
      value1 * value2
    end)

    # IO.puts """
    # do_calculation multiplication
    # value1: #{value1}
    # value2: #{value2}
    # target: #{target}
    # whole_input: #{inspect(whole_input)}
    # updated_input: #{inspect(updated_input)}
    # """

    {:ok, updated_input}
  end
  defp do_calculation([99|tail], whole_input) do
    {:stop, whole_input}
  end

  defp raw_input do
    File.stream!("./support/2019/day_2.txt", [], :line)
    |> Stream.map(fn(line) ->
      line
      |> String.trim()
      |> String.split(",")
      |> Enum.map(fn(int) ->
        int
        |> Integer.parse()
        |> elem(0)
      end)
    end)
    |> Enum.to_list
    |> List.last
  end

end

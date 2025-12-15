defmodule Euler6 do
  @moduledoc """
  Project Euler #6: Sum square difference.
  Compute (sum(1..n))^2 - sum(i^2 for i in 1..n).
  """

  @n 100

  # 1) Tail recursion
  def solve_tail(n \\ @n) do
    sum = sum_tr(n, 0)
    sum * sum - sum_squares_tr(n, 0)
  end

  defp sum_tr(0, acc), do: acc
  defp sum_tr(k, acc), do: sum_tr(k - 1, acc + k)

  defp sum_squares_tr(0, acc), do: acc
  defp sum_squares_tr(k, acc), do: sum_squares_tr(k - 1, acc + k * k)

  # 2) Non-tail recursion
  def solve_rec(n \\ @n) do
    s = sum_rec(n)
    s * s - sum_squares_rec(n)
  end

  defp sum_rec(0), do: 0
  defp sum_rec(k), do: k + sum_rec(k - 1)

  defp sum_squares_rec(0), do: 0
  defp sum_squares_rec(k), do: k * k + sum_squares_rec(k - 1)

  # 3) Modular: generate -> filter -> reduce
  def solve_modular(n \\ @n) do
    seq = 1..n

    filtered =
      seq
      |> Enum.filter(fn x -> x <= n end)

    sum = Enum.reduce(filtered, 0, &+/2)
    sum_sq = Enum.reduce(filtered, 0, fn x, acc -> acc + x * x end)

    sum * sum - sum_sq
  end

  # 4) Map
  def solve_map(n \\ @n) do
    xs = Enum.to_list(1..n)
    sum = Enum.sum(xs)

    sum_sq =
      xs
      |> Enum.map(fn x -> x * x end)
      |> Enum.sum()

    sum * sum - sum_sq
  end

  # 5) for-comprehension
  def solve_for(n \\ @n) do
    sum = for i <- 1..n, reduce: 0, do: (acc -> acc + i)
    sum_sq = for i <- 1..n, reduce: 0, do: (acc -> acc + i * i)
    sum * sum - sum_sq
  end

  # 6) Lazy stream ("infinite list" style)
  def solve_stream(n \\ @n) do
    nums = Stream.iterate(1, &(&1 + 1)) |> Stream.take(n)
    sum = Enum.reduce(nums, 0, &+/2)

    sum_sq =
      Stream.iterate(1, &(&1 + 1))
      |> Stream.take(n)
      |> Stream.map(fn x -> x * x end)
      |> Enum.reduce(0, &+/2)

    sum * sum - sum_sq
  end
end

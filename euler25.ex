defmodule Euler25 do
  @moduledoc """
  Project Euler #25: 1000-digit Fibonacci number.
  Find the index of the first Fibonacci number with given digits.
  Indexing: F1 = 1, F2 = 1.
  """

  @digits 1000

  defp digit_count(n), do: n |> Integer.digits() |> length()

  # ---------------------------
  # 1) Tail recursion (monolithic)
  # ---------------------------
  def solve_tail(target_digits \\ @digits) do
    # a=F1, b=F2, idx(b)=2
    find_tail(1, 1, 2, target_digits)
  end

  defp find_tail(a, b, idx, target) do
      if digit_count(b) >= target do
          idx
      else
          find_tail(b, a + b, idx + 1, target)
      end
  end


  # ---------------------------
  # 2) Non-tail recursion (monolithic)
  # ---------------------------
  def solve_rec(target_digits \\ @digits) do
    find_rec(1, 1, 2, target_digits)
  end

  defp find_rec(a, b, idx, target) do
    if digit_count(b) >= target do
      idx
    else
      # not tail: still adds work after recursive call
      0 + find_rec(b, a + b, idx + 1, target)
    end
  end

  # ---------------------------
  # 3) Modular: generate -> filter -> reduce (reduce_while)
  # ---------------------------
  def solve_modular(target_digits \\ @digits) do
    fib_stream()
    |> Stream.filter(fn {f, _i} -> digit_count(f) >= target_digits end)
    |> Enum.reduce_while(nil, fn {_f, i}, _acc -> {:halt, i} end)
  end

  # ---------------------------
  # 4) Map: map to digit lengths then find index
  # ---------------------------
  def solve_map(target_digits \\ @digits) do
    fib_stream()
    |> Stream.map(fn {f, i} -> {digit_count(f), i} end)
    |> Enum.reduce_while(nil, fn {len, i}, _acc ->
      if len >= target_digits, do: {:halt, i}, else: {:cont, nil}
    end)
  end

  # ---------------------------
  # 5) for-comprehension (special syntax)
  # ---------------------------
  def solve_for(target_digits \\ @digits) do
    for {f, i} <- fib_stream(), reduce: nil do
      _acc ->
        if digit_count(f) >= target_digits, do: throw({:found, i}), else: nil
    end
  catch
    {:found, i} -> i
  end

  # ---------------------------
  # 6) Lazy / "infinite list": Stream.unfold
  # ---------------------------
  def solve_stream(target_digits \\ @digits) do
    fib_stream()
    |> Enum.reduce_while(nil, fn {f, i}, _acc ->
      if digit_count(f) >= target_digits, do: {:halt, i}, else: {:cont, nil}
    end)
  end

  # Infinite stream of {F_n, n}, starting at {1,1}, {1,2}, ...
  defp fib_stream do
    Stream.unfold({1, 1, 1}, fn {a, b, i} ->
      {{a, i}, {b, a + b, i + 1}}
    end)
  end
end

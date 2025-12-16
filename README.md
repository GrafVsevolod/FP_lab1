# Лабораторная работа: функциональное программирование (Elixir)

**Проект:** Project Euler  
**Задачи (вариант):** 6, 25  
**Язык:** Elixir (+ сравнение на Python)

## Цель работы
Освоить базовые приёмы и абстракции функционального программирования:
функции, сопоставление с образцом, рекурсия, хвостовая рекурсия, свёртка (reduce/fold),
отображение (map), фильтрация (filter), работа с функциями как с данными,
ленивые последовательности (Stream).

## Структура репозитория
- `euler6.ex` — задача 6, несколько реализаций (tail recursion, recursion, filter+reduce, map, for, Stream)
- `euler25.ex` — задача 25, несколько реализаций (включая бесконечный Stream.unfold)
- `comparison.py` — императивная реализация для сравнения
- `report.md` — отчёт по лабораторной работе

## Запуск и проверка

### Elixir (через iex)

В терминале в папке репозитория выполнил:
```bash
iex

# Далее в интерактивной консоли Elixir:
c("euler6.ex")
Euler6.solve_tail()
Euler6.solve_rec()
Euler6.solve_modular()
Euler6.solve_map()
Euler6.solve_for()
Euler6.solve_stream()

c("euler25.ex")
Euler25.solve_tail()
Euler25.solve_rec()
Euler25.solve_modular()
Euler25.solve_map()
Euler25.solve_for()
Euler25.solve_stream()

# Ожидаемые результаты:
Euler 6: 25164150
Euler 25: 4782
Выход из iex: Ctrl + C, затем ещё раз Ctrl + C.

Python (сравнение)
python3 comparison.py

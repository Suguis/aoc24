import gleam/int
import gleam/list
import gleam/result
import gleam/string
import glutils

pub type Report =
  List(Int)

pub fn parse(input: String) -> List(Report) {
  let lines = glutils.lines(input)
  let reports_string = list.map(lines, fn(line) { string.split(line, " ") })
  let assert Ok(reports) =
    list.map(reports_string, fn(report) {
      list.map(report, int.parse) |> result.all
    })
    |> result.all
  reports
}

pub fn pt_1(reports: List(Report)) -> Int {
  list.count(reports, is_report_safe)
}

fn is_report_safe(report: Report) -> Bool {
  let adjacents = list.window_by_2(report)
  let increases = list.map(adjacents, glutils.apply2_pair(_, int.subtract))
  let all_increasing = list.all(increases, fn(l) { l < 0 })
  let all_decreasing = list.all(increases, fn(l) { l > 0 })
  let are_safe_increases =
    list.all(list.map(increases, int.absolute_value), fn(l) { l >= 1 && l <= 3 })

  { { all_increasing || all_decreasing } && are_safe_increases }
}

fn is_report_tolerable_by_single_level(report: Report) -> Bool {
  let assert Ok(reports_without_level) =
    list.map(list.range(0, list.length(report) - 1), fn(i) {
      glutils.remove(i, report)
    })
    |> result.all
  list.any(reports_without_level, is_report_safe)
}

pub fn pt_2(reports: List(Report)) -> Int {
  list.count(reports, fn(report) {
    is_report_safe(report) || is_report_tolerable_by_single_level(report)
  })
}

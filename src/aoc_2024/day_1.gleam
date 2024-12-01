import gleam/int
import gleam/list
import gleam/string
import glutils

pub fn parse(input: String) -> #(List(Int), List(Int)) {
  let lines = string.split(input, "\n")
  list.map(lines, parse_line)
  |> list.unzip
}

pub fn pt_1(input: #(List(Int), List(Int))) -> Int {
  let left = list.sort(input.0, int.compare)
  let right = list.sort(input.1, int.compare)
  let pairs = list.zip(left, right)
  list.map(pairs, fn(ids) {
    let difference = glutils.apply2_pair(ids, int.subtract)
    int.absolute_value(difference)
  })
  |> int.sum
}

pub fn pt_2(input: #(List(Int), List(Int))) -> Int {
  let #(left, right) = input
  list.map(left, fn(n) { list.count(right, fn(x) { x == n }) * n })
  |> int.sum
}

fn parse_line(line: String) -> #(Int, Int) {
  let assert Ok(splitted_ids) = string.split_once(line, "   ")
  let assert #(Ok(id_1), Ok(id_2)) = glutils.map_pair(splitted_ids, int.parse)
  #(id_1, id_2)
}

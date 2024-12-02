import gleam/int
import gleeunit/should
import glutils

pub fn map_pair_test() {
  glutils.map_pair(#(4, 2), with: int.subtract(_, 2)) |> should.equal(#(2, 0))
}

pub fn apply2_pair_test() {
  glutils.apply2_pair(#(4, 2), with: int.subtract) |> should.equal(2)
}

pub fn remove_test() {
  glutils.remove(1, [1, 2, 3]) |> should.equal(Ok([1, 3]))
}

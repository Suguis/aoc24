//// A module containing utility functions for the Advent of Code challenges

pub fn map_pair(of pair: #(a, a), with fun: fn(a) -> b) -> #(b, b) {
  #(fun(pair.0), fun(pair.1))
}

pub fn apply2_pair(of pair: #(a, b), with fun: fn(a, b) -> c) -> c {
  fun(pair.0, pair.1)
}

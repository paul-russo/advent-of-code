import sequtils, strutils, strformat

# get a sequence of integers in the input file
proc getEntries(): seq[int] =
  let input = open("input.txt")
  defer: input.close()

  return map(toSeq(input.lines), proc(line: string): int = line.parseInt())

# given a desired value, find two values in the given sequence that sum to the desired value
proc findAddends(xs: seq[int], sum: int): (int, int) =
  for x in xs:
    let y = sum - x

    if xs.contains(y):
      return (x, y)

# given a desired value, find three values in the given sequence that sum to the desired value
proc findAddends3(xs: seq[int], sum: int): (int, int, int) =
  for x in xs:
    let (y, z) = xs.findAddends(sum - x)

    if y > 0 and z > 0:
      return (x, y, z)

let (x, y, z) = getEntries().findAddends3(2020)
let product = x * y * z
echo &"Result: {product}"
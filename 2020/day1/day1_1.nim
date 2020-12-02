import sequtils, strutils, strformat

proc main() =
  let input = open("input.txt")
  defer: input.close()

  var xs: seq[int]
  xs = map(toSeq(input.lines), proc(line: string): int = line.parseInt())

  for x in xs:
    let y = 2020 - x

    if xs.contains(y):
      let result = x * y
      echo &"Result: {result}"
      break

main()
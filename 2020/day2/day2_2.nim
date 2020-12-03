import sequtils, strutils, strformat

type
  Record = (int, int, char, string) ## (pos1, pos2, letter, password)

proc getRecords(): seq[Record] =
  ## get a sequence containing Records
  let input = open("input.txt")
  defer: input.close()

  return toSeq(input.lines).map(
    proc(line: string): Record =
      let parts = line.split(" ")
      let policyPositions = parts[0].split("-")
      let policyLetter = parts[1][0]
      let password = parts[2]

      return (policyPositions[0].parseInt(), policyPositions[1].parseInt(), policyLetter, password)
  )

let validRecords = getRecords().filter(
  proc(record: Record): bool =
    let (pos1, pos2, letter, password) = record

    return password[pos1 - 1] == letter xor password[pos2 - 1] == letter
)

echo &"Valid passwords: {validRecords.len()}"

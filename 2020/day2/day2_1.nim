import sequtils, strutils, strformat

type
  Record = (int, int, char, string) ## (low, high, letter, password)

proc getRecords(): seq[Record] =
  ## get a sequence containing Records
  let input = open("input.txt")
  defer: input.close()

  return toSeq(input.lines).map(
    proc(line: string): Record =
      let parts = line.split(" ")
      let policyRange = parts[0].split("-")
      let policyLetter = parts[1][0]
      let password = parts[2]

      return (policyRange[0].parseInt(), policyRange[1].parseInt(), policyLetter, password)
  )

let validRecords = getRecords().filter(
  proc(record: Record): bool =
    let (low, high, letter, password) = record

    let letterCount = password
    .filter(proc(l: char): bool = return l == letter)
    .len()

    return letterCount >= low and letterCount <= high
)

echo &"Valid passwords: {validRecords.len()}"

import sequtils, strutils, strformat

type Rows = seq[seq[bool]]

proc getRows(): Rows =
    ## get a sequence containing Records
    let input = open("input.txt")
    defer: input.close()

    return toSeq(input.lines).map(
        proc(line: string): seq[bool] =
            result = newSeq[bool]()

            for space in line:
                result.add(if space == '#': true else: false)
    )

proc getSpaceIsTree(rows: Rows, x: int, y: int): bool =
    let width = rows[0].len()

    rows[y][x mod width]


let rows = getRows()

var x = 0
var y = 0
var treesEncountered = 0

while y < rows.len():
    if rows.getSpaceIsTree(x, y) == true:
        treesEncountered += 1

    x += 3
    y += 1


echo &"trees encountered: {treesEncountered}"

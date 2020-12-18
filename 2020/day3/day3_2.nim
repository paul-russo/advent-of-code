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

proc countTrees(rows: Rows, dx: int, dy: int): int =
    var x = 0
    var y = 0
    var treesEncountered = 0

    while y < rows.len():
        if rows.getSpaceIsTree(x, y) == true:
            treesEncountered += 1

        x += dx
        y += dy
    
    echo &"trees encountered for slope {dx},{dy}: {treesEncountered}"

    return treesEncountered

let rows = getRows()

let trees11 = rows.countTrees(1, 1)
let trees31 = rows.countTrees(3, 1)
let trees51 = rows.countTrees(5, 1)
let trees71 = rows.countTrees(7, 1)
let trees12 = rows.countTrees(1, 2)

let product = trees11 * trees31 * trees51 * trees71 * trees12

echo &"product of all trees encountered: {product}"

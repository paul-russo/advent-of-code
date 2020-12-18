import sequtils, algorithm, math, strformat

type 
  Pass = tuple
    row, col: int

proc decodeBSP(bsp: string): Pass =
  var rowMin = 0
  var rowMax = 127
  for rowHalf in bsp[0..5]:
    if rowHalf == 'F':
      rowMax = int(floor((rowMin + rowMax) / 2))
    if rowHalf == 'B':
      rowMin = int(ceil((rowMin + rowMax) / 2))

  let row = if bsp[6] == 'F': rowMin else: rowMax

  var colMin = 0
  var colMax = 7
  for colHalf in bsp[7..8]:
    if colHalf == 'L':
      colMax = int(floor((colMin + colMax) / 2))
    if colHalf == 'R':
      colMin = int(ceil((colMin + colMax) / 2))

  let col = if bsp[9] == 'L': colMin else: colMax

  return (row, col)

proc computeSeatID(pass: Pass): int =
  pass.row * 8 + pass.col

proc getPasses(): seq[Pass] =
  let input = open("input.txt")
  defer: input.close()

  return toSeq(input.lines).map(decodeBSP)

var passes = getPasses()
passes.sort()

var seatIDs = passes.map(computeSeatID)
seatIDs.sort()

var highestSeatID = seatIDs[^1]
echo &"highest seat ID: {highestSeatID}"
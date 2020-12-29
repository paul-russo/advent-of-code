import sequtils, algorithm, math, strformat, sets

proc getGroups(): seq[HashSet[char]] =
  let input = open("input.txt")
  defer: input.close()

  var groups = @[initHashSet[char]()]
  var isNewGroup = true

  for line in input.lines:
    if line == "":
      groups.add(initHashSet[char]())
      isNewGroup = true
      continue

    if isNewGroup:
      groups[^1] = toHashSet(line)
      isNewGroup = false
      continue

    groups[^1] = groups[^1].intersection(toHashSet(line))

  return groups

let groups = getGroups()

var total = 0
for group in groups:
  total += group.len()

echo &"total: {total}"
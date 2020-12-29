import strformat, sets

proc getGroups(): seq[HashSet[char]] =
  let input = open("input.txt")
  defer: input.close()

  var groups = @[initHashSet[char]()]

  for line in input.lines:
    if line == "":
      groups.add(initHashSet[char]())
    else:
      groups[^1] = toHashSet(line) + groups[^1]

  return groups

let groups = getGroups()

var total = 0
for group in groups:
  total += group.len()

echo &"total: {total}"
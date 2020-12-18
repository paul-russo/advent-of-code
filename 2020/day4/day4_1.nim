import sequtils, strutils, strformat

type 
  Passport* = object
    byr*, iyr*, eyr*, hgt*, hcl*, ecl*, pid*, cid*: string

proc getPassports(): seq[Passport] =
  let input = open("input.txt")
  defer: input.close()

  var i = 0
  var passports = newSeq[Passport]()
  passports.add(Passport())

  for line in input.lines:
    if line == "":
      i += 1
      passports.add(Passport())
      continue

    let pairs = line.split(' ').map(proc (x: string): seq[string] = x.split(':'))

    for pair in pairs:
      let key = pair[0]
      let value = pair[1]

      case key
      of "byr": passports[i].byr = value
      of "iyr": passports[i].iyr = value
      of "eyr": passports[i].eyr = value
      of "hgt": passports[i].hgt = value
      of "hcl": passports[i].hcl = value
      of "ecl": passports[i].ecl = value
      of "pid": passports[i].pid = value
      of "cid": passports[i].cid = value
      else: discard

  return passports

proc validatePassport(passport: Passport): bool =
  passport.byr != "" and
  passport.iyr != "" and
  passport.eyr != "" and
  passport.hgt != "" and
  passport.hcl != "" and
  passport.ecl != "" and
  passport.pid != ""

let validPassports = getPassports().filter(validatePassport)

echo &"valid passport count: {validPassports.len()}"

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

const validEyeColors = ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"]

proc validatePassport(passport: Passport): bool =
  try:
    # birth year
    let birthYear = passport.byr.parseInt()
    if birthYear < 1920 or birthYear > 2002: return false

    # issue year
    let issueYear = passport.iyr.parseInt()
    if issueYear < 2010 or issueYear > 2020: return false

    # expiration year
    let expirationYear = passport.eyr.parseInt()
    if expirationYear < 2020 or expirationYear > 2030: return false

    # height
    let heightUnit = passport.hgt[^2..^1]
    if heightUnit != "cm" and heightUnit != "in": return false

    let heightValue = passport.hgt[0..^3].parseInt()
    if heightUnit == "cm" and (heightValue < 150 or heightValue > 193): return false
    if heightUnit == "in" and (heightValue < 59 or heightValue > 76): return false

    # hair color
    if passport.hcl[0] != '#': return false
    discard passport.hcl[1..^1].parseHexInt()

    # eye color
    if validEyeColors.contains(passport.ecl) != true: return false

    # passport ID
    discard passport.pid.parseInt()
    if passport.pid.len() != 9: return false
  except:
    echo getCurrentExceptionMsg()
    return false

  return true

let validPassports = getPassports().filter(validatePassport)

echo &"valid passport count: {validPassports.len()}"


from os import sleep
import src/progressbar

proc testpb() =
  var pb = initPB(total = 100)
  var p = 0

  while p <= 100:
    pb.updatePB(current = p)
    inc p
    sleep(100)

  pb = initPB(
    delimChars = ["|", "|"],
    progressChars = ["#", "."],
    progressCharsNbr = 50,
    total = 100
  )
  p = 0
  while p < 10:
    pb.updatePB(step = 10)
    inc p
    sleep(500)

  pb = initPB(total = 100)
  p = 0
  while p <= 100:
    pb.updatePB(current = p, percent_only = true)
    inc p
    sleep(100)

when isMainModule:

  testpb()

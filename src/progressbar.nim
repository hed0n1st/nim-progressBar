
import
  strutils,
  strformat

const
  CR = "\r"
  LF = "\n"

type
  ProgressBar* = object
    delimChars*: array[0..1, string]
    progressChars*: array[0..1, string]
    progressCharsNbr*: int
    bar*: string
    total*: int
    current*: int

proc initPb*(delimChars: array[0..1, string] = ["[", "]"],
              progressChars: array[0..1, string] = ["\u275a", "-"],
              progressCharsNbr: int = 100,
              total: int): ProgressBar =

  result.delimChars = delimChars
  result.progressChars = progressChars
  result.progressCharsNbr = progressCharsNbr
  result.total = total
  result.bar = fmt"{delimChars[0]}$1{delimChars[1]}"

proc updatePb*(pb: var ProgressBar,
                current: int = -1,
                step: int = -1,
                percent_only: bool = false,
                prefix: string = "",
                suffix: string = "") =

  if step >= 0:
    pb.current = pb.total - (pb.total - (pb.current + step))
  if current >= 0:
    pb.current = current

  let progress = ((pb.current * 100) / pb.total).int
  var bar = pb.progressChars[0].repeat((progress / (100 / pb.progressCharsNbr).int).int)
  let remain = pb.progressCharsNbr - (bar.len / pb.progressChars[0].len).int
  bar = bar & pb.progressChars[1].repeat(remain)

  var progressBar: string
  var endBar = case remain:
    of 0: CR & LF
    else: ""

  if not percent_only:
    progressBar = join([
      CR,
      fmt"{prefix}",
      pb.bar % [bar],
      fmt" {progress}%",
      fmt"{suffix}",
      endBar
    ])
  else:
    progressBar = join([
      CR,
      fmt"{prefix}",
      fmt"{progress}%",
      fmt"{suffix}",
      endBar
    ])

  stdout.write(progressBar)

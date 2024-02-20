--PRIMARY FUCTIONS--
LOG_LEVELS = {
  [1] = "i",
  [2] = "w",
  [3] = "e"
}

LOG_LEVELS.INFO   = LOG_LEVELS[1]
LOG_LEVELS.WARN   = LOG_LEVELS[2]
LOG_LEVELS.ERROR  = LOG_LEVELS[3]
LOG_LEVELS.NONE   = ""


function Log(msg, level)
  local lvl = LOG_LEVELS.INFO

  if type(level) == "number" then
    lvl = LOG_LEVELS[level]
  end

  if level == LOG_LEVELS.NONE then
    print(string.format("%s", msg))
  elseif level == LOG_LEVELS.ERROR then
    error(string.format("[%s] %s", lvl, msg))
  else
    print(string.format("[%s] %s", lvl, msg))
  end
end

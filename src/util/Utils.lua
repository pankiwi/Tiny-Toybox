Utils = {}

Utils.REGEX_NAME_PATH = "[^/\\]+$"

Utils.NILFUNCTION = function() end

Utils.recursiveEnumerate = function(dir, file_list)
  local items = love.filesystem.getDirectoryItems(dir)

  for i = 1, #items, 1 do
    local file = dir .. '/' .. items[i]
    local typeFile = love.filesystem.getInfo(file)

    if typeFile.type == "file" then
      table.insert(file_list, file)
    elseif typeFile.type == "directory" then
      Utils.recursiveEnumerate(file, file_list)
    end
  end

  return file_list
end

Utils.requireFiles = function(files)
  local len = #files
  local out = {}

  for i = 1, len, 1 do
    local path = files[i]:sub(1, -5)
    local file = string.sub(path, string.find(path, Utils.REGEX_NAME_PATH))
    out[file] = require(path)
  end

  return out
end

Utils.requireFolder = function(path)
  return Utils.requireFiles(Utils.recursiveEnumerate(path:gsub("%.", "/"), {}))
end

Utils.UUID = function()
  local template = 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'
  return string.gsub(template, '[xy]', function(c)
    local v = (c == 'x') and math.random(0, 0xf) or math.random(8, 0xb)
    return string.format('%x', v)
  end)
end

Utils.generate2d = function(w, h, default)
  local map = {}

  for j = 1, h, 1 do
    table.insert(map, {})

    for i = 1, w, 1 do
      if default then
        map[j][i] = default
      end
    end
  end

  return map
end

local clear = require "table.clear"

local EntityPool = class({
  name = "EntityPool"
})

function EntityPool:new(limit)
  self.pool         = {}
  self.pool_removed = {}
  self.limit        = limit or math.huge
end

function EntityPool:getPool()
  return self.pool
end

function EntityPool:findTarget(f)
  local len = #self.pool

  for i = 1, len, 1 do
    if f(self.pool[i]) then
      return i
    end
  end

  return nil
end

function EntityPool:get(index)
  return self.pool[index]
end

function EntityPool:add(entity)
  if not entity or #self.pool > self.limit then
    return nil
  end
  
  entity._id = Utils.UUID()

  table.insert(self.pool, entity)

  return self.pool[#self.pool]
end

function EntityPool:remove(index)
  table.insert(self.pool_removed, index)
end

function EntityPool:removeEntity(entity)
  local i = tablex.index_of(entity)

  if i then
    self:remove(i)
  end
end

function EntityPool:call(f)
  if type(f) ~= "function" then
    Log("Invalid call EntityPool", LOG_LEVELS.ERROR)
  end

  local len = #self.pool

  for i = 1, len, 1 do
    f(self, self.pool[i], i)
  end
end

function EntityPool:flush(poo)
  local len = #self.pool_removed

  if len == 0 then
    return
  end

  for i = 1, len, 1 do
    table.remove(self.pool, self.pool_removed[i])
    table.remove(self.pool_removed, i)
  end
end


function EntityPool:clear()
  clear(self.pool)
  clear(self.pool_removed)
end

return EntityPool
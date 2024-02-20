local EntityPool = require "src.type.EntityPool"

EntityManager = {
  Objects = EntityPool(Globals.MAX_ENTITIES),
  Effects = EntityPool(Globals.MAX_EFFECTS),
  _onDestroyObject = Utils.NILFUNCTION,
  _onAddObject = Utils.NILFUNCTION,
}


function EntityManager:addObject(entity)
  if type(entity) == "table" then
    entity = self.Objects:add(entity)
    self._onAddObject(self, entity, self.Objects, #self.Objects:getPool())

    return entity
  end
end

function EntityManager:addEffect(entity)
  if type(entity) == "table" then
    self.Effects:add(entity)
  end
end

function EntityManager:draw()
  self.Objects:call(self.drawEntity)
  self.Effects:call(self.drawEntity)
end

function EntityManager:update(dt)
  self.Objects:call(function(pool, entity, index)
    self.updateEntity(pool, entity, index, dt)
  end)

  self.Effects:call(function(pool, entity, index)
    self.updateEntity(pool, entity, index, dt)
  end)
end

function EntityManager:callObject(f)
  self.Objects:call(f)
end

function EntityManager:callEffect(f)
  self.Effects:call(f)
end

function EntityManager:flush()

  self.Objects:flush()
  self.Effects:flush()
end

function EntityManager:onDestroyObject(f)
  if type(f) == "function" then
    self._onDestroyObject = f
  end
end

function EntityManager:onAddObject(f)
  if type(f) == "function" then
    self._onAddObject = f
  end
end

function EntityManager.drawEntity(pool, entity, index)
  if entity:canDraw() then entity:draw() end
end

function EntityManager.updateEntity(pool, entity, index, dt)
  if entity:canUpdate() and not entity:canRemove() then
    entity:update(dt)

    local w, h = Globals.GAME_WIDTH, Globals.GAME_HEIGHT
    local wmin, hmin = w * 0.4, h * 0.4

    if entity:canLimit() and ((entity.x > w + wmin or entity.x < -wmin) or (entity.y > h + hmin or entity.y < -hmin)) then
      entity:Remove()
    end
  end

  if entity:canRemove() then
    EntityManager._onDestroyObject(entity, index)

    if entity.collicion and not entity.collicion:isDestroyed( ) then
      entity.collicion:destroy()
    end
    entity:Destroyed()

    pool:remove(index)
  end
end

local Entity = require "src.type.Entity"

local Test = class({
  name = "Test",
  extends = Entity
})

function Test:new(x, y)
  self:super()
  self.x = x
  self.y = y

  self.collicion = Physics:newCircleCollider(self.x, self.y, 10)
  self.collicion:setType("dynamic")
  self.collicion:setCollisionClass("Object")
  self.collicion:setMass(500)
  
  self._drawing = true
  self._update = true
  self._limit = true
end

function Test:draw()
  lg.setColor(1,1,1)
  lg.circle("fill", self.x, self.y, 10 + math.sin(love.timer.getTime()))
end

function Test:update(dt)
  self.x, self.y = self.collicion:getPosition()
end

function Test:setX(x)
  self.collicion:setX(x)
end

function Test:setY(x)
  self.collicion:setY(x)
end

return Test
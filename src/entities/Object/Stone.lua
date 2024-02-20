local Entity = require "src.type.Entity"

local Stone = class({
  name = "Ball",
  extends = Entity
})

function Stone:new(x, y)
  self:super()
  self.x = x
  self.y = y
  self.r = 5
  self.color = { 0.2,0.2,0.2, 1 }
  self.hit = 0

  self.collicion = Physics:newCircleCollider(self.x, self.y, self.r)
  self.collicion:setType("dynamic")
  self.collicion:setCollisionClass("Object")
  self.collicion:setMass(500)
  self.collicion:setLinearDamping(10)
  self.collicion:setInertia(5)

  self._drawing = true
  self._update = true
  self._limit = true
end

function Stone:draw()
  lg.setColor(self.color)
  lg.circle("fill", self.x, self.y, self.r + 0.5 * math.sin(love.timer.getTime()))

  lg.setColor(0, 0, 0)
  lg.circle("line", self.x, self.y, self.r + 0.5 * math.sin(love.timer.getTime()))
end

function Stone:update(dt)
  self.x, self.y = self.collicion:getPosition()


  if self.collicion:enter("Solid") then
    EntityManager:addEffect(Entities:Effect("Bong")(self.x, self.y, self.color))
    self.hit = self.hit + 1

    if self.hit > 10 then
      self:Remove()
    end
  end

end

function Stone:setX(x)
  self.collicion:setX(x)
end

function Stone:setY(x)
  self.collicion:setY(x)
end

return Stone

local Entity = require "src.type.Entity"

local Ball = class({
  name = "Ball",
  extends = Entity
})

function Ball:new(x, y)
  self:super()
  self.x = x
  self.y = y
  self.r = 10
  self.color = { colour.hsl_to_rgb(math.random(0, 360) / 360, Globals.HSL_COLOR[2], Globals.HSL_COLOR[3]) }
  self.bong = 0

  self.collicion = Physics:newCircleCollider(self.x, self.y, self.r)
  self.collicion:setType("dynamic")
  self.collicion:setCollisionClass("Object")
  self.collicion:setMass(250)
  self.collicion:setLinearDamping(-2)
  self.collicion:setInertia(5)

  self._drawing = true
  self._update = true
  self._limit = true
end

function Ball:draw()
  lg.setColor(self.color)
  lg.circle("fill", self.x, self.y, self.r + 0.5 * math.sin(love.timer.getTime()))

  lg.setColor(0, 0, 0)
  lg.circle("line", self.x, self.y, self.r + 0.5 * math.sin(love.timer.getTime()))
end

function Ball:update(dt)
  self.x, self.y = self.collicion:getPosition()

  local mass = self.collicion:getMass()

  if self.bong > 1 and self.collicion:enter("Solid") then
    self.collicion:applyLinearImpulse(-(Globals.GRAVITY.x * mass * self.bong), -(Globals.GRAVITY.y * mass * self.bong))
    EntityManager:addEffect(Entities:Effect("Bong")(self.x, self.y, { self.color[1], self.color[2], self.color[3], 1 }))

    self.bong  = self.bong / 2
  end

  self.bong = self.bong + dt
end

function Ball:setX(x)
  self.collicion:setX(x)
end

function Ball:setY(x)
  self.collicion:setY(x)
end

return Ball

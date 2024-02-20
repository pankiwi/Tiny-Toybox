local Entity = require "src.type.Entity"

local Balloon = class({
  name = "Balloon",
  extends = Entity
})

function Balloon:new(x, y)
  self:super()
  self.x = x
  self.y = y
  self.r = 15
  self.color = { colour.hsl_to_rgb(math.random(0, 360) / 360, Globals.HSL_COLOR[2], Globals.HSL_COLOR[3]) }

  self.collicion = Physics:newCircleCollider(self.x, self.y, self.r)
  self.collicion:setType("dynamic")
  self.collicion:setCollisionClass("Object")
  self.collicion:setMass(0)
  self.collicion:setLinearDamping(-2)
  self.collicion:setInertia(5)
  self.collicion:setGravityScale(0)

  self.trails = {}
  self.joins = {}

  for i = 1, 3, 1 do
    local trail = Physics:newCircleCollider(self.x, self.y + self.r * i, 1)
    self.collicion:setCollisionClass("Ignored")
    self.collicion:setMass(10)

    table.insert(self.trails, trail)
  end

  for i = 1, 2, 1 do
    local c1 = self.trails[i]
    local c2 = self.trails[i + 1]

    local join = Physics:addJoint("RopeJoint", c1, c2, c1:getX(), c1:getY(), c2:getX(), c2:getY(), 20, true)

    table.insert(self.joins, join)
  end

  local join = Physics:addJoint("RopeJoint", self.collicion, self.trails[1], self.collicion:getX(), self.collicion:getY(),
    self.trails[1]:getX(), self.trails[1]:getY(), 20, true)

  table.insert(self.joins, join)

  self._drawing = true
  self._update = true
  self._limit = true
end

function Balloon:draw()
  if self:canRemove() then
    return
  end

  lg.setColor(0, 0, 0)

  for i = 1, #self.trails - 1, 1 do
    local c1 = self.trails[i]
    local c2 = self.trails[i + 1]
    lg.line(c1:getX(), c1:getY(), c2:getX(), c2:getY())
  end
  lg.line(self.trails[1]:getX(), self.trails[1]:getY(), self.x, self.y)

  local x, y = vec2():polar(5, Globals.GRAVITY:angle()):scalar_add_inplace(self.x, self.y):unpack()

  lg.setColor(self.color)
  lg.circle("fill", self.x, self.y, self.r + 0.5 * math.sin(love.timer.getTime()))

  lg.setColor(0, 0, 0)
  lg.circle("line", self.x, self.y, self.r + 0.5 * math.sin(love.timer.getTime()))

  lg.setColor(1,1,1, 0.5)
  lg.circle("fill", x, y, self.r * 0.6 + 0.5 * math.sin(love.timer.getTime()))
end

function Balloon:update(dt)
  self.x, self.y = self.collicion:getPosition()

  if self.collicion:enter("Solid") then
    EntityManager:addEffect(Entities:Effect("Explosion")(self.x, self.y,
      { self.color[1], self.color[2], self.color[3], 1 }))
    self:Remove()
  end
end

function Balloon:setX(x)
  self.collicion:setX(x)
end

function Balloon:setY(x)
  self.collicion:setY(x)
end

function Balloon:Destroyed()
  if #self.trails > 0 then
    for key, value in pairs(self.trails) do
      value:destroy()
    end

    self.trails = {}
  end
end

return Balloon

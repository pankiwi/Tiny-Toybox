local Entity = require "src.type.Entity"

local Test = class({
  name = "Ball",
  extends = Entity
})

function Test:new(x, y)
  self:super()
  self.x = x
  self.y = y
  self.w = 20
  self.h = 20
  self.color = { 140 / 255, 98 / 255, 1 / 255, 1 }
  self.color2 = {237/255, 168/255, 6/255, 1}
  self.color3 = {183/255, 128/255, 0/255, 1}
  self.fallTime = 0

  self.collicion = Physics:newRectangleCollider(self.x, self.y, self.w, self.h)
  self.collicion:setType("dynamic")
  self.collicion:setCollisionClass("Object")
  self.collicion:setMass(250)
  self.collicion:setFixedRotation(true)

  self._drawing = true
  self._update = true
  self._limit = true
end

function Test:draw()
  local w, h = self.w + 0.5 * math.sin(love.timer.getTime()), self.h + 0.5 * math.sin(love.timer.getTime())


  lg.setColor(self.color2)
  lg.rectangle("fill", self.x - w/2, self.y - h/2, w, h)

  lg.setColor(self.color)
  lg.rectangle("fill", self.x - w * 0.7/2, self.y - h * 0.7/2, w * 0.7, h *0.7)

  lg.setColor(self.color3)
  lg.line(self.x - w/2 + 2, self.y - h/2 + 2, self.x + w/2 - 2, self.y + h/2 - 2)
  lg.line(self.x - w/2 + 2, self.y + h/2 - 2, self.x + w/2 - 2, self.y - h/2 + 2)


  lg.setColor(0, 0, 0)
  lg.rectangle("line", self.x - w/2, self.y - h/2, w, h)
end

function Test:update(dt)
  self.x, self.y = self.collicion:getPosition()

  if Globals.GRAVITY.x ~= 0 or Globals.GRAVITY.y ~= 0 then
    if self.collicion:enter("Solid") then

      if self.fallTime > 5  then
        EntityManager:addEffect(Entities:Effect("Explosion")(self.x, self.y, self.color3))
        self:Remove()
      end
      self.fallTime = 0
    else
      self.fallTime = self.fallTime + dt
    end
  end
  
end

function Test:setX(x)
  self.collicion:setX(x)
end

function Test:setY(x)
  self.collicion:setY(x)
end

return Test

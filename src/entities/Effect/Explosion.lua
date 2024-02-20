local Entity = require "src.type.Entity"

local particle = function(img, x, y, color)
  local ps = love.graphics.newParticleSystem(img, 60)
  ps:setColors(unpack(color))
  ps:setDirection(-1.5707963705063)
  ps:setEmitterLifetime(-1)
  ps:setInsertMode("top")
  ps:setLinearAcceleration(-69.869041442871, -49.046127319336, 215.62944030762, 189.90701293945)
  ps:setLinearDamping(0.4901550412178, 2.1657872200012)
  ps:setParticleLifetime(1.7999999523163, 2.2000000476837)
  ps:setSizes(1)
  ps:setSizeVariation(1)
  ps:setSpeed(27.947616577148, 329.26742553711)
  ps:setSpread(6.2831854820251)
  ps:setPosition(x, y)

  ps:emit(60)
  ps:setLinearAcceleration(Globals.GRAVITY.x, Globals.GRAVITY.y)

  return ps
end

local Explocion = class({
  name = "Explocion",
  extends = Entity
})

function Explocion:new(x, y, color)
  self:super()
  self.particle = particle(Assets:Sprite("particle_0"), x, y, color)

  self._drawing = true
  self._update = true
  self._limit = false
end

function Explocion:draw()
  lg.setColor(1,1,1)
  lg.draw(self.particle, 0, 0)
end

function Explocion:update(dt)
  self.particle:update(dt)
end

return Explocion

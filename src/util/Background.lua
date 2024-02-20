local timer = require "lib.hump.timer"

Background = {
  state = 2,
  particle = nil,
  x = 0,
  y = 0,
  data = 0,
  alpha = 0,
  timer = nil,
  image = nil,
  color = nil
}

function Background:Load()
  self.timer = timer()
  self.particle = self.setParticle()

  self:setColor( { colour.hsl_to_rgb(Globals.HSL_COLOR[1], Globals.HSL_COLOR[2], Globals.HSL_COLOR[3] - 0.2) })
  self:setImage(Assets:Sprite("particle_0"))
  self:setState(0)
end

function Background:setState(n)
  self.state = n

  if n == 1 then
    self.particle:start()
  else
    self.particle:stop()
  end

  if n == 2 then
    self.timer:tween(1, self, {alpha = 1})
  else
    self.timer:tween(1, self, {alpha = 0})
  end
end

function Background:setColor(col)
  self.color = col
  self.particle:setColors(col[1], col[2], col[3], 1)
end

function Background:setImage(img)
  pretty.print(img)
  self.image = img

  self.particle:setTexture(img)
end

function Background:draw()
  lg.draw(self.particle, Globals.WINDOW_WIDTH / 2, -30)

  lg.setColor(self.color[1], self.color[2], self.color[3], self.alpha)
  
  local iw, ih = self.image:getWidth() * 1.5, self.image:getHeight() * 1.5
  local w, h = Globals.GAME_WIDTH/iw, Globals.GAME_HEIGHT/ih
  
  for i = -h, h, 1 do
    for j = -w, w, 1 do
      local x, y = iw  * j, ih * i

      lg.draw(self.image, x + self.data, y + self.data, 0, 1, 1, self.image:getWidth()/2, self.image:getHeight()/2)
    end
  end
end

function Background:update(dt)
  self.particle:update(dt)
  self.timer:update(dt)

  self.data = (self.data + dt * 40) % Globals.GAME_WIDTH
end

function Background.setParticle()
  local ps = love.graphics.newParticleSystem(Assets:Sprite("particle_0"), 500)
  ps:setColors(1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 0.5, 1, 1, 1, 0)
  ps:setDirection(1.5413930416107)
  ps:setEmissionArea("uniform", Globals.WINDOW_WIDTH, 10, 0, false)
  ps:setEmissionRate(20)
  ps:setEmitterLifetime(-1)
  ps:setInsertMode("top")
  ps:setLinearAcceleration(-0.45932897925377, 0, -0.45932897925377, 0)
  ps:setParticleLifetime(2.3127315044403, 10.289132118225)
  ps:setSizes(2)
  ps:setSizeVariation(1)
  ps:setSpeed(102.91010284424, 279.45574951172)
  ps:stop()

  return ps
end

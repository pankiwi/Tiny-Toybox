Cursor = {
  _x = love.mouse.getX(),
  _y = love.mouse.getY(),
  _radius = 6,
  _speed = 20,
  _color = { 87 / 255, 224 / 255, 1 },
  _color_out = { 12 / 255, 12 / 255, 12 / 255 },
  _d = 0
}

function Cursor:draw()
  lg.setColor(self._color)
  lg.circle("fill", self._x, self._y, self._radius + self._d)
  lg.setColor(self._color_out)
  lg.setLineWidth(1)
  lg.circle("line", self._x, self._y, self._radius + self._d)
  lg.setColor(1, 1, 1)
end

function Cursor:update(dt)
  local x, y = love.mouse.getPosition()
  x, y = Push:toGame(x, y)

  local dx, dy = x - self._x, y - self._y
  local d  = - self._d

  if math.abs(dx) > 1 or math.abs(dy) > 1 then

    self._x = self._x + (dx * self._speed) * dt
    self._y = self._y + (dy * self._speed) * dt

    if self._d > -2 then
      self._d = self._d - (2 - self._d) * dt
    end
  end

  if math.abs(d) > 0.2 then
    self._d = self._d + d * dt
  end
end


function Cursor:click()
  self._d = -5
end
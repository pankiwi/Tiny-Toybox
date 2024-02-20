local Panel = require "src.ui.elements.Panel"

return Inky.defineElement(function(self, scene)
  self.props.sprite = self.props.sprite or ""
  self.props.color  = self.props.color or { 1, 1, 1 }
  self.props.offset = self.props.offset or vec2(0, 0)

  return function(_, x, y, w, h)
    if Globals.DEBUG_UI then
      lg.rectangle("line", x, y, w, h)
    end

    if self.props.sprite ~= "" then
      local sprite = Assets:Sprite(self.props.sprite)
      local _w, _h = sprite:getDimensions()

      lg.setColor(self.props.color)
      lg.draw(sprite, x + self.props.offset.x, y + self.props.offset.y, 0, 1, 1, _w / 2, _h / 2)

      lg.setColor(1, 1, 1)
    end
  end
end)

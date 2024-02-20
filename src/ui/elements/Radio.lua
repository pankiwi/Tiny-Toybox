local Panel = require "src.ui.elements.Panel"

return Inky.defineElement(function(self, scene)
  self.props.color        = self.props.color or { 1, 1, 1 }
  self.props.borderRadius = self.props.borderRadius or 0
  self.props.borderSize   = self.props.borderSize or 1
  self.props.borderColor  = self.props.borderColor or { 1, 1, 1 }

  self.props.selectRadio  = self.props.selectRadio or Utils.NILFUNCTION
  self.props.isSelected   = self.props.isSelected or Utils.NILFUNCTION
  self.props.data         = self.props.data or nil

  self.props.d = 0
  self:onPointer("release", function(...)
    self.props.selectRadio(self)

    Assets:Sound("button"):play {
      pitch = math.random(1, 5)
    }

    local x, _, w, _ = self:getView()

    self.props.d = w * 0.5

    Globals.Timer:tween(1, self.props, {d = 0}, "out-back")
  end)


  return function(_, x, y, w, h)
    if Globals.DEBUG_UI then
      lg.rectangle("line", x, y, w, h)
    end

    if self.props.isSelected(self) then
      lg.setColor(self.props.color)
      lg.rectangle("fill", x + self.props.d/2, y + self.props.d/2, w - self.props.d, h - self.props.d, self.props.borderRadius, self.props.borderRadius)
    end

    local _len = lg.getLineWidth()
    lg.setColor(self.props.borderColor)
    lg.setLineWidth(self.props.borderSize)
    lg.rectangle("line", x + self.props.d/2, y + self.props.d/2,w - self.props.d, h - self.props.d, self.props.borderRadius, self.props.borderRadius)
    lg.setLineWidth(_len)

    lg.setColor(1, 1, 1)
  end
end)

local Panel = require "src.ui.elements.Panel"

return Inky.defineElement(function(self, scene)
  self.props.color        = self.props.color or { 1, 1, 1 }
  self.props.borderRadius = self.props.borderRadius or 0
  self.props.borderSize   = self.props.borderSize or 1
  self.props.borderColor  = self.props.borderColor or { 1, 1, 1 }

  self.props.checked = self.props.checked or false
  self.props.onChange = self.props.onChange or Utils.NILFUNCTION

  self.props.d = 0

  self:onPointer("release", function(...)
    local x, _, w, _ = self:getView()

    self.props.checked = not self.props.checked
    self.props.onChange(self.props.checked)

    Assets:Sound("check_box"):play {
      pitch = math.random(0.8, 5)
    }

    self.props.d = w * 0.3

    Globals.Timer:tween(1, self.props, {d  = 0}, "out-back")
  end) 

  return function(_, x, y, w, h)
    if Globals.DEBUG_UI then
      lg.rectangle("line", x, y, w, h)
    end

    if self.props.checked then
      lg.setColor(self.props.color)
      lg.rectangle("fill", x + self.props.d/2, y + self.props.d/2, w - self.props.d , h - self.props.d, self.props.borderRadius, self.props.borderRadius)
    end

    local _len = lg.getLineWidth()
    lg.setColor(self.props.borderColor)
    lg.setLineWidth(self.props.borderSize)
    lg.rectangle("line", x + self.props.d/2, y + self.props.d/2, w - self.props.d, h - self.props.d, self.props.borderRadius, self.props.borderRadius)
    lg.setLineWidth(_len)

    lg.setColor(1, 1, 1)
  end
end)

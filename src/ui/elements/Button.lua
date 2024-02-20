local Panel = require "src.ui.elements.Panel"

return Inky.defineElement(function(self, scene)
  self.props.icon          = self.props.icon or ""
  self.props.colorIcon     = self.props.colorIcon or { 1, 1, 1 }
  self.props.offsetIcon    = self.props.offsetIcon or vec2(0, 0)

  self.props.panel         = self.props.panel or Panel(scene)

  self.props.onClick      = self.props.onClick or Utils.NILFUNCTION
  self.props.customRender = self.props.customRender or nil
  self.props.data         = self.props.data or nil

  self.props.d = 0


  self:onPointer("release", function(...)
    self.props.onClick(...)

    local x, _, w, _ = self:getView()

    self.props.d  = w * 0.5

    Globals.Timer:tween(1, self.props, {d = 0}, "out-back")
  end)


  return function(_, x, y, w, h)
    if Globals.DEBUG_UI then
      lg.rectangle("line", x, y, w, h)
    end

    if self.props.customRender then
      self.props.customRender(x, y, w, h)

      return
    end

    self.props.panel:render(x, y, w, h)

    if self.props.icon ~= "" then
      local icon           = Assets:Sprite(self.props.icon)
      local icon_w, icon_h = icon:getDimensions()

      lg.setColor(self.props.colorIcon)
      lg.draw(icon, x + self.props.offsetIcon.x + self.props.d/2, y + self.props.offsetIcon.y + self.props.d/2, 0,1 - self.props.d/icon_w, 1 - self.props.d/icon_h, icon_w / 2 + self.props.d/2, icon_h / 2 + self.props.d / 2)

      lg.setColor(1, 1, 1)
    end
  end
end)

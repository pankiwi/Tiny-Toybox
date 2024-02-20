return Inky.defineElement(function(self)
  self.props.pad          = self.props.pad or nil
  self.props.color        = self.props.color or { 1, 1, 1 }
  self.props.borderRadius = self.props.borderRadius or 0
  self.props.borderSize   = self.props.borderSize or 0
  self.props.borderColor  = self.props.borderColor or { 1, 1, 1 }

  return function(_, x, y, w, h)
    if self.props.pad then
      lg.setColor(1, 1, 1)
      self.props.pad:draw(x, y, w, h)
      return
    end

    lg.setColor(self.props.color)
    lg.rectangle("fill", x, y, w, h, self.props.borderRadius, self.props.borderRadius)

    if self.props.borderSize > 0 then
      local _len = lg.getLineWidth()

      lg.setColor(self.props.borderColor)
      lg.setLineWidth(self.props.borderSize)
      lg.rectangle("line", x, y, w, h, self.props.borderRadius, self.props.borderRadius)
      lg.setLineWidth(_len)
    end

    lg.setColor(1,1,1)
  end
end)
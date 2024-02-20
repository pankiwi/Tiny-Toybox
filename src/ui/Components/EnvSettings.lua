local Panel = require "src.ui.elements.Panel"
local Radio = require "src.ui.elements.Radio"
local Slider = require "src.ui.elements.Slider"
local Sprite = require "src.ui.elements.Sprite"
local CheckBox = require "src.ui.elements.CheckBox"

return Inky.defineElement(function(self, scene)
  self.props.selected = self.props.selected or 0
  self.props.selectedImage = self.props.selectedImage or 0
  self.props.selectedBackground = self.props.selectedBackground or 0



  self.props.progressX = self.props.progressX or 0
  self.props.progressY = self.props.progressY or 0
  self.props.progressHue = self.props.progressHue or 0


  self.props.top = self.props.top or true
  self.props.bottom = self.props.bottom or true
  self.props.left = self.props.left or true
  self.props.right = self.props.right or true

  self.props.onProgressX = self.props.onProgressX or Utils.NILFUNCTION
  self.props.onProgressY = self.props.onProgressY or Utils.NILFUNCTION
  self.props.onProgressHue = self.props.onProgressHue or Utils.NILFUNCTION

  self.props.onSelect = self.props.onSelect or Utils.NILFUNCTION
  self.props.onSelectImage = self.props.onSelectImage or Utils.NILFUNCTION
  self.props.onSelectBackground = self.props.onSelectBackground or Utils.NILFUNCTION

  self.props.onChangeCheckBox = self.props.onChangeCheckBox or Utils.NILFUNCTION

  local onSelect = function(radio)
    if radio.props.data == self.props.selected then
      return
    end

    self.props.selected = radio.props.data
  end

  local isSelect = function(radio)
    return self.props.selected == radio.props.data
  end

  local onSelectImage = function(radio)
    if radio.props.data == self.props.selectedImage then
      return
    end

    self.props.selectedImage = radio.props.data
  end

  local isSelectImage = function(radio)
    return self.props.selectedImage == radio.props.data
  end

  local onSelectBackground = function(radio)
    if radio.props.data == self.props.selectedBackground then
      return
    end

    self.props.selectedBackground = radio.props.data
  end

  local isSelectBackground = function(radio)
    return self.props.selectedBackground == radio.props.data
  end

  local panel = Panel(scene)
  panel.props.pad = Assets:Sprite("panel_1")

  local up_arrow = Sprite(scene)
  up_arrow.props.sprite = "icon_0"
  up_arrow.props.offset = vec2(8, 8)

  local down_arrow = Sprite(scene)
  down_arrow.props.sprite = "icon_1"
  down_arrow.props.offset = vec2(8, 8)

  local sld_gravity_x = Slider(scene)
  sld_gravity_x.props.color = { 182 / 255, 158 / 255, 1 }
  sld_gravity_x.props.progress = self.props.progressX
  sld_gravity_x.props.onProgress = function(prog)
    self.props.progressX = prog
  end

  local sld_gravity_y = Slider(scene)
  sld_gravity_y.props.color = { 1, 158 / 255, 182 / 255 }
  sld_gravity_y.props.progress = self.props.progressY
  sld_gravity_y.props.onProgress = function(prog)
    self.props.progressY = prog
  end



  local top_sprite = Sprite(scene)
  top_sprite.props.sprite = "icon_4"
  top_sprite.props.offset = vec2(8, 8)

  local check_top = CheckBox(scene)
  check_top.props.borderColor = { 1, 1, 1, 1 }
  check_top.props.color = { 0.5, 0.5, 0.5, 1 }
  check_top.props.checked = self.props.top
  check_top.props.onChange = function(check)
    self.props.top = check
  end


  local bottom_sprite = Sprite(scene)
  bottom_sprite.props.sprite = "icon_5"
  bottom_sprite.props.offset = vec2(8, 8)

  local check_bottom = CheckBox(scene)
  check_bottom.props.borderColor = { 1, 1, 1, 1 }
  check_bottom.props.color = { 0.5, 0.5, 0.5, 1 }
  check_bottom.props.checked = self.props.bottom
  check_bottom.props.onChange = function(check)
    self.props.bottom = check
  end


  local left_sprite = Sprite(scene)
  left_sprite.props.sprite = "icon_6"
  left_sprite.props.offset = vec2(8, 8)

  local check_left = CheckBox(scene)
  check_left.props.borderColor = { 1, 1, 1, 1 }
  check_left.props.color = { 0.5, 0.5, 0.5, 1 }
  check_left.props.checked = self.props.left
  check_left.props.onChange = function(check)
    self.props.left = check
  end


  local right_sprite = Sprite(scene)
  right_sprite.props.sprite = "icon_7"
  right_sprite.props.offset = vec2(8, 8)

  local check_right = CheckBox(scene)
  check_right.props.borderColor = { 1, 1, 1, 1 }
  check_right.props.color = { 0.5, 0.5, 0.5, 1 }
  check_right.props.checked = self.props.right
  check_right.props.onChange = function(check)
    self.props.right = check
  end


  local bounce_sprite            = Sprite(scene)
  bounce_sprite.props.sprite     = "icon_8"
  bounce_sprite.props.offset     = vec2(8, 8)

  local radio_bounce             = Radio(scene)
  radio_bounce.props.borderColor = { 1, 1, 1, 1 }
  radio_bounce.props.color       = { 0.5, 0.5, 0.5, 1 }
  radio_bounce.props.selectRadio = onSelect
  radio_bounce.props.isSelected  = isSelect
  radio_bounce.props.data        = 2

  local portal_sprite            = Sprite(scene)
  portal_sprite.props.sprite     = "icon_9"
  portal_sprite.props.offset     = vec2(8, 8)

  local radio_portal             = Radio(scene)
  radio_portal.props.borderColor = { 1, 1, 1, 1 }
  radio_portal.props.color       = { 0.5, 0.5, 0.5, 1 }
  radio_portal.props.selectRadio = onSelect
  radio_portal.props.isSelected  = isSelect
  radio_portal.props.data        = 1

  local none_sprite              = Sprite(scene)
  none_sprite.props.sprite       = "icon_10"
  none_sprite.props.offset       = vec2(8, 8)

  local radio_none               = Radio(scene)
  radio_none.props.borderColor   = { 1, 1, 1, 1 }
  radio_none.props.color         = { 0.5, 0.5, 0.5, 1 }
  radio_none.props.selectRadio   = onSelect
  radio_none.props.isSelected    = isSelect
  radio_none.props.data          = 0


  local sld_hsl_hue            = Slider(scene)
  sld_hsl_hue.props.color      = { colour.hsl_to_rgb(Globals.HSL_COLOR[1], Globals.HSL_COLOR[2], Globals.HSL_COLOR[3]) }
  sld_hsl_hue.props.progress   = self.props.progressHue
  sld_hsl_hue.props.onProgress = function(prog)
    self.props.progressHue = prog

    sld_hsl_hue.props.color = { colour.hsl_to_rgb(Globals.HSL_COLOR[1], Globals.HSL_COLOR[2], Globals.HSL_COLOR[3]) }
  end


  local star_sprite              = Sprite(scene)
  star_sprite.props.sprite       = "icon_13"
  star_sprite.props.offset       = vec2(8, 8)

  local radio_star               = Radio(scene)
  radio_star.props.borderColor   = { 1, 1, 1, 1 }
  radio_star.props.color         = { 0.5, 0.5, 0.5, 1 }
  radio_star.props.selectRadio   = onSelectImage
  radio_star.props.isSelected    = isSelectImage
  radio_star.props.data          = 3

  local heart_sprite             = Sprite(scene)
  heart_sprite.props.sprite      = "icon_14"
  heart_sprite.props.offset      = vec2(8, 8)

  local radio_heart              = Radio(scene)
  radio_heart.props.borderColor  = { 1, 1, 1, 1 }
  radio_heart.props.color        = { 0.5, 0.5, 0.5, 1 }
  radio_heart.props.selectRadio  = onSelectImage
  radio_heart.props.isSelected   = isSelectImage
  radio_heart.props.data         = 2

  local square_sprite            = Sprite(scene)
  square_sprite.props.sprite     = "icon_15"
  square_sprite.props.offset     = vec2(8, 8)

  local radio_square             = Radio(scene)
  radio_square.props.borderColor = { 1, 1, 1, 1 }
  radio_square.props.color       = { 0.5, 0.5, 0.5, 1 }
  radio_square.props.selectRadio = onSelectImage
  radio_square.props.isSelected  = isSelectImage
  radio_square.props.data        = 1

  local circle_sprite            = Sprite(scene)
  circle_sprite.props.sprite     = "icon_16"
  circle_sprite.props.offset     = vec2(8, 8)

  local radio_circle             = Radio(scene)
  radio_circle.props.borderColor = { 1, 1, 1, 1 }
  radio_circle.props.color       = { 0.5, 0.5, 0.5, 1 }
  radio_circle.props.selectRadio = onSelectImage
  radio_circle.props.isSelected  = isSelectImage
  radio_circle.props.data        = 0


  local rain_sprite              = Sprite(scene)
  rain_sprite.props.sprite       = "icon_17"
  rain_sprite.props.offset       = vec2(8, 8)

  local radio_rain               = Radio(scene)
  radio_rain.props.borderColor   = { 1, 1, 1, 1 }
  radio_rain.props.color         = { 0.5, 0.5, 0.5, 1 }
  radio_rain.props.selectRadio   = onSelectBackground
  radio_rain.props.isSelected    = isSelectBackground
  radio_rain.props.data          = 1

  local static_sprite            = Sprite(scene)
  static_sprite.props.sprite     = "icon_18"
  static_sprite.props.offset     = vec2(8, 8)

  local radio_static             = Radio(scene)
  radio_static.props.borderColor = { 1, 1, 1, 1 }
  radio_static.props.color       = { 0.5, 0.5, 0.5, 1 }
  radio_static.props.selectRadio = onSelectBackground
  radio_static.props.isSelected  = isSelectBackground
  radio_static.props.data        = 2

  local empty_sprite             = Sprite(scene)
  empty_sprite.props.sprite      = "icon_19"
  empty_sprite.props.offset      = vec2(8, 8)

  local radio_empty              = Radio(scene)
  radio_empty.props.borderColor  = { 1, 1, 1, 1 }
  radio_empty.props.color        = { 0.5, 0.5, 0.5, 1 }
  radio_empty.props.selectRadio  = onSelectBackground
  radio_empty.props.isSelected   = isSelectBackground
  radio_empty.props.data         = 0

  self:useEffect(function()
    self.props.onProgressX(self.props.progressX)
  end, "progressX")

  self:useEffect(function()
    self.props.onProgressY(self.props.progressY)
  end, "progressY")

  self:useEffect(function()
    self.props.onProgressHue(self.props.progressHue)
  end, "progressHue")

  self:useEffect(function()
    self.props.onChangeCheckBox(self.props.top, self.props.bottom, self.props.left, self.props.right)

    check_top.props.checked    = self.props.top
    check_bottom.props.checked = self.props.bottom
    check_left.props.checked   = self.props.left
    check_right.props.checked  = self.props.right
  end, "top", "bottom", "left", "right")

  self:useEffect(function()
    self.props.onSelect(self.props.selected)
  end, "selected")

  self:useEffect(function()
    self.props.onSelectImage(self.props.selectedImage)
  end, "selectedImage")

  self:useEffect(function()
    self.props.onSelectBackground(self.props.selectedBackground)
  end, "selectedBackground")

  return function(_, x, y, w, h)
    panel:render(x, y, 200, 190)

    x, y = x + 10, y + 10

    down_arrow:render(x, y, 16, 14)
    sld_gravity_x:render(x + 25, y, 60, 14)

    up_arrow:render(x + 90, y, 16, 14)
    sld_gravity_y:render(x + 115, y, 60, 14)

    x, y = x, y + 30

    top_sprite:render(x, y, 16, 14)
    check_top:render(x + 20, y + 3, 10, 10)

    bottom_sprite:render(x + 50, y, 16, 14)
    check_bottom:render(x + 70, y + 3, 10, 10)


    left_sprite:render(x + 100, y, 16, 14)
    check_left:render(x + 120, y + 3, 10, 10)

    right_sprite:render(x + 145, y, 16, 14)
    check_right:render(x + 165, y + 3, 10, 10)

    x, y = x, y + 30

    bounce_sprite:render(x, y, 16, 14)
    radio_bounce:render(x + 20, y + 3, 10, 10)

    portal_sprite:render(x + 75, y, 16, 14)
    radio_portal:render(x + 95, y + 3, 10, 10)

    none_sprite:render(x + 145, y, 16, 14)
    radio_none:render(x + 165, y + 3, 10, 10)

    x, y = x, y + 30

    sld_hsl_hue:render(x, y, 180, 14)

    x, y = x, y + 30

    star_sprite:render(x, y, 16, 14)
    radio_star:render(x + 20, y + 3, 10, 10)

    heart_sprite:render(x + 45, y, 16, 14)
    radio_heart:render(x + 70, y + 3, 10, 10)

    square_sprite:render(x + 95, y, 16, 14)
    radio_square:render(x + 115, y + 3, 10, 10)

    circle_sprite:render(x + 145, y, 16, 14)
    radio_circle:render(x + 165, y + 3, 10, 10)

    x, y = x, y + 30

    rain_sprite:render(x, y, 16, 14)
    radio_rain:render(x + 20, y + 3, 10, 10)

    static_sprite:render(x + 75, y, 16, 14)
    radio_static:render(x + 95, y + 3, 10, 10)

    empty_sprite:render(x + 145, y, 16, 14)
    radio_empty:render(x + 165, y + 3, 10, 10)
  end
end)

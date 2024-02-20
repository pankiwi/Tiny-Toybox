local Panel = require "src.ui.elements.Panel"
local Radio = require "src.ui.elements.Radio"
local Sprite = require "src.ui.elements.Sprite"
local Button = require "src.ui.elements.Button"

return Inky.defineElement(function(self, scene)
  self.props.selected = self.props.selected or 0
  self.props.onSelect = self.props.onSelect or Utils.NILFUNCTION
  self.props.onClear  = self.props.onClear or Utils.NILFUNCTION
  self.props.onSecret = self.props.onSecret or Utils.NILFUNCTION



  local onSelect                  = function(radio)
    if radio.props.data == self.props.selected then
      return
    end

    self.props.selected = radio.props.data
  end

  local isSelect                  = function(radio)
    return self.props.selected == radio.props.data
  end

  local p0                        = Panel(scene)
  p0.props.color                  = { 0, 0, 0, 0 }

  local panel                     = Panel(scene)
  panel.props.pad                 = Assets:Sprite("panel_1")

  local balloonSprite             = Sprite(scene)
  balloonSprite.props.sprite      = "options_0"
  balloonSprite.props.offset      = vec2(8, 8)

  local radio_balloon             = Radio(scene)
  radio_balloon.props.borderColor = { 1, 1, 1, 1 }
  radio_balloon.props.color       = { 0.5, 0.5, 0.5, 1 }
  radio_balloon.props.selectRadio = onSelect
  radio_balloon.props.isSelected  = isSelect
  radio_balloon.props.data        = 2

  local ball_sprite               = Sprite(scene)
  ball_sprite.props.sprite        = "options_2"
  ball_sprite.props.offset        = vec2(8, 8)

  local radio_ball                = Radio(scene)
  radio_ball.props.borderColor    = { 1, 1, 1, 1 }
  radio_ball.props.color          = { 0.5, 0.5, 0.5, 1 }
  radio_ball.props.selectRadio    = onSelect
  radio_ball.props.isSelected     = isSelect
  radio_ball.props.data           = 1

  local stone_sprite              = Sprite(scene)
  stone_sprite.props.sprite       = "options_3"
  stone_sprite.props.offset       = vec2(8, 8)

  local radio_stone               = Radio(scene)
  radio_stone.props.borderColor   = { 1, 1, 1, 1 }
  radio_stone.props.color         = { 0.5, 0.5, 0.5, 1 }
  radio_stone.props.selectRadio   = onSelect
  radio_stone.props.isSelected    = isSelect
  radio_stone.props.data          = 4

  local box_sprite                = Sprite(scene)
  box_sprite.props.sprite         = "options_1"
  box_sprite.props.offset         = vec2(8, 8)

  local radio_box                 = Radio(scene)
  radio_box.props.borderColor     = { 1, 1, 1, 1 }
  radio_box.props.color           = { 0.5, 0.5, 0.5, 1 }
  radio_box.props.selectRadio     = onSelect
  radio_box.props.isSelected      = isSelect
  radio_box.props.data            = 3

  local radio_none                = Radio(scene)
  radio_none.props.borderColor    = { 1, 1, 1, 1 }
  radio_none.props.color          = { 0.5, 0.5, 0.5, 1 }
  radio_none.props.selectRadio    = onSelect
  radio_none.props.isSelected     = isSelect
  radio_none.props.data           = 0

  local btn_clear                 = Button(scene)
  btn_clear.props.icon            = "options_4"
  btn_clear.props.colorIcon       = { 1, 1, 1 }
  btn_clear.props.offsetIcon      = vec2(8, 8)

  btn_clear.props.panel           = p0
  btn_clear.props.onClick         = function()
    self.props.onClear()
    Assets:Sound("option"):play {
      pitch = math.random(0.8, 2)
    }
  end

  local btn_secret                = Button(scene)
  btn_secret.props.icon           = "icon_12"
  btn_secret.props.colorIcon      = { 1, 1, 1 }
  btn_secret.props.offsetIcon     = vec2(8, 8)

  btn_secret.props.panel          = p0
  btn_secret.props.onClick        = function()
    self.props.onSecret()
    Assets:Sound("option"):play {
      pitch = math.random(0.8, 2)
    }
  end

  self:useEffect(function()
    self.props.onSelect(self.props.selected)
  end, "selected")


  return function(_, x, y, w, h)
    panel:render(x, y, 200, 70)

    x, y = x + 10, y + 10

    balloonSprite:render(x, y, 16, 14)
    radio_balloon:render(x + 20, y + 3, 10, 10)

    ball_sprite:render(x + 40, y, 16, 14)
    radio_ball:render(x + 65, y + 3, 10, 10)

    stone_sprite:render(x + 85, y, 16, 14)
    radio_stone:render(x + 105, y + 3, 10, 10)

    box_sprite:render(x + 125, y, 16, 14)
    radio_box:render(x + 145, y + 3, 10, 10)

    radio_none:render(x + 165, y + 3, 10, 10)

    x, y = x, y + 30

    btn_clear:render(x, y, 14, 14)
    btn_secret:render(x + 160, y, 14, 14)
  end
end)

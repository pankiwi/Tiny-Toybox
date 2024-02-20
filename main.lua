lg = love.graphics

function love.load()
  math.randomseed(os.time())

  require "lib.batteries" :export()
  require "src.Globals"
  require "src.util.Utils"
  require "src.util.Log"


  require "src.Load" ()

  SwitchState(Globals.default_state)
end

function love.update()
  local x, y =love.mouse.getPosition()
  x, y = Push:toGame(x, y)
  Scene_Pointer:setPosition(x, y)
end

function love.mousereleased(x, y, button)
  if (button == 1) then
    Scene_Pointer:raise("release")
  end
end

function love.mousepressed(x, y, button)
  if (button == 1) then
    Scene_Pointer:raise("press")
  end

  Cursor:click()
end

function love.textinput(t)
  Scene_Pointer:raise("textinput", t)

  Cursor:click()
end

function love.keypressed(key)
  if (key == "backspace") then
    Scene_Pointer:raise("backspace")
  end

  if (key == "return") then
    Scene_Pointer:raise("return")
  end

  if (key == "1") then
    Globals.DEBUG_UI = not Globals.DEBUG_UI
  end

  if (key == "2") then
    Globals.DEBUG_Collicion = not Globals.DEBUG_Collicion
  end
end

function love.wheelmoved(dx, dy)
  Scene_Pointer:raise("scroll", dy)

  Cursor:click()
end

function love.mousemoved(x, y, dx, dy)
  if (love.mouse.isDown(1)) then
    x, y = Push:toGame(x, y)

    Scene_Pointer:setPosition(x, y)
    Scene_Pointer:raise("drag", dx, dy)
  end
end

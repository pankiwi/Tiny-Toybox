function SwitchState(to)
  Gamestate.switch(Globals.states[to])
end

local function LoadState()
  local states = Utils.requireFolder("src.state")

  for name, state in pairs(states) do
    state.name = name
    states[name] = state
  end

  Globals.states = states
end

--LOAD
return function()
  Log("START LOADING")

  --setup love config
  love.graphics.setBackgroundColor(colour.hsl_to_rgb(Globals.HSL_COLOR[1], Globals.HSL_COLOR[2], Globals.HSL_COLOR[3]))
  love.graphics.getDefaultFilter(Globals.FILTERIMAGE)
  love.mouse.setVisible(false)

  Log("LOADING LIBRARIES")

  --init libraries
  P9 = require "lib.p9"

  local wf = require "lib.windfield"
  Physics = wf.newWorld(Globals.GRAVITY.x, Globals.GRAVITY.y, false)
  Physics_Hidden = wf.newWorld(0, 0, false)

  Physics:setQueryDebugDrawing(true)

  --class collicion

  Physics:addCollisionClass("Ignored", { ignores = { "Ignored" } })
  Physics:addCollisionClass("Solid", { ignores = { "Ignored" } })
  Physics:addCollisionClass("Object", { ignores = { "Ignored" } })
  Physics:addCollisionClass("Cursor", { ignores = { "Ignored" } })


  Inky = require "lib.inky"
  Scene = Inky.scene()
  Scene_Pointer = Inky.pointer(Scene)

  Gamestate = require "lib.hump.gamestate"
  Gamestate.registerEvents()


  Push = require "lib.push"

  Push:setupScreen(Globals.GAME_WIDTH, Globals.GAME_HEIGHT, Globals.WINDOW_WIDTH, Globals.WINDOW_HEIGHT, {
    fullscreen = false,
    resizable = false,
    pixelperfect = true,
    highdpi = true
  })

  for _, obj in ipairs(Push.canvases) do
    obj.canvas:setFilter(Globals.FILTERIMAGE)
  end

  Ripple = require "lib.ripple"

  Globals.Tags = {}

  Globals.Tags["sfx"] = Ripple.newTag()

  local timer = require "lib.hump.timer"
  
  Globals.Timer = timer()




  Log("LOADING GAME")
  require "src.Assets"
  require "src.util.Cursor"
  require "src.util.Background"
  require "src.entities.Entities"
  require "src.entities.EntityManager"

  Assets:Load()
  Entities:Load()

  Background:Load()
  LoadState()

  lg.setFont(Assets:Font("dogica_bold"))
  Log("END LOADING")
end

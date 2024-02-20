local State = require "src.type.State"
local Button = require "src.ui.elements.Button"
local PlaceMenu = require "src.ui.PlaceMenu"
local envSettings = require "src.ui.Components.EnvSettings"
local toyBox = require "src.ui.Components.ToyBox"
local wf = require "lib.windfield"

local Place = State()

function Place:init()
  self._walls = {}
  self._show = false
  self._state_wall = 0
  self._images = { Assets:Sprite("particle_3"), Assets:Sprite("particle_2"), Assets:Sprite("particle_4"), Assets:Sprite(
    "particle_1") }
  self._options = {"Ball", "Balloon", "Box", "Stone"}
  self._selected = 0

  self:createLimits()
  self:setUI()


  EntityManager:onDestroyObject(function()
    Assets:Sound("pop"):play {
      pitch = math.random(0.8, 2)
    }
  end)
end

function Place:draw()
  Push:start()

  lg.clear(colour.hsl_to_rgb(Globals.HSL_COLOR[1], Globals.HSL_COLOR[2], Globals.HSL_COLOR[3]))
  Background:draw()

  EntityManager:draw()

  lg.setColor(1, 1, 1)
  for _, wall in pairs(self._walls) do
    local x, y = wall:getPosition()

    lg.draw(wall.particle, x, y)
  end

  Scene:beginFrame()
  if self._show then
    self._ui:render(10, 10, Globals.GAME_WIDTH - 20, Globals.GAME_HEIGHT - 20)
  end
  Scene:finishFrame()

  Cursor:draw()

  if Globals.DEBUG_Collicion then
    Physics:draw()
    lg.print(Physics.box2d_world:getBodyCount(), 0, 0)
  end
  Push:finish()
end

function Place:update(dt)
  Physics:update(dt)
  EntityManager:update(dt)
  EntityManager:flush()

  self:wallUpdate(dt)
  Globals.Timer:update(dt)
  Cursor:update(dt)
  Background:update(dt)

end

function Place:setUI()
  local env = envSettings(Scene)
  env.props.progressX = mathx.inverse_lerp(Globals.GRAVITY.x, Globals.GRAVITY_X.x, Globals.GRAVITY_X.y)
  env.props.progressY = mathx.inverse_lerp(Globals.GRAVITY.y, Globals.GRAVITY_X.x, Globals.GRAVITY_X.y)
  env.props.progressHue = Globals.HSL_COLOR[1]

  env.props.onProgressX = function(prog)
    local grav = mathx.lerp(Globals.GRAVITY_X.x, Globals.GRAVITY_X.y, prog)

    Globals.GRAVITY.x = grav

    Physics:setGravity(Globals.GRAVITY.x, Globals.GRAVITY.y)
  end

  env.props.onProgressY = function(prog)
    local grav = mathx.lerp(Globals.GRAVITY_Y.x, Globals.GRAVITY_Y.y, prog)

    Globals.GRAVITY.y = grav

    Physics:setGravity(Globals.GRAVITY.x, Globals.GRAVITY.y)
  end

  env.props.onProgressHue = function(prog)
    Globals.HSL_COLOR[1] = prog

    local r, g, b = colour.hsl_to_rgb(Globals.HSL_COLOR[1], Globals.HSL_COLOR[2] + 0.2, Globals.HSL_COLOR[3] + 0.2)
    for _, wall in pairs(self._walls) do
      wall.particle:setColors(r, g, b, 0.8)
    end

    Background:setColor({ colour.hsl_to_rgb(Globals.HSL_COLOR[1], Globals.HSL_COLOR[2], Globals.HSL_COLOR[3] - 0.2) })
  end

  env.props.onChangeCheckBox = function(...)
    self:updateWalls(...)
  end

  env.props.onSelect = function(select)
    self._state_wall = select

    if select == 1 then
      env.props.top = false
      env.props.bottom = false
      env.props.left = false
      env.props.right = false


      for _, wall in pairs(self._walls) do
        wall.particle:setEmissionRate(50)
      end
    else
      env.props.top = true
      env.props.bottom = true
      env.props.left = true
      env.props.right = true


      for _, wall in pairs(self._walls) do
        wall.particle:setEmissionRate(0)
      end
    end
  end

  env.props.onSelectImage = function(select)
    Background:setImage(self._images[select + 1])
  end

  env.props.onSelectBackground = function(select)
    Background:setState(select)
  end

  local toy = toyBox(Scene)
  toy.props.onSelect = function (select)
    self._selected = select
  end
  toy.props.onClear = function (select)
    EntityManager.Objects:call(function (pool, entity)
      entity:Remove()
    end)
  end
  toy.props.onSecret = function ()
    SwitchState("Credits")
  end

  self._ui = PlaceMenu(Scene)
  self._ui.props.envSettings = env
  self._ui.props.toyBox = toy
end

function Place:updateWalls(top, bottom, left, right)
  self._walls["top"]:setCollisionClass(not top and 'Ignored' or 'Solid')
  self._walls["bottom"]:setCollisionClass(not bottom and 'Ignored' or 'Solid')
  self._walls["left"]:setCollisionClass(not left and 'Ignored' or 'Solid')
  self._walls["right"]:setCollisionClass(not right and 'Ignored' or 'Solid')
end

function Place:createLimits()
  local _wall = Physics:newRectangleCollider(0, -10, Globals.GAME_WIDTH, 10)
  _wall:setType('static')
  _wall.particle = self.particleWalls(Globals.GAME_WIDTH, 10, math.rad(90))


  self._walls["top"] = _wall

  local _wall = Physics:newRectangleCollider(0, Globals.GAME_HEIGHT, Globals.GAME_WIDTH, 10)
  _wall:setType('static')
  _wall.particle = self.particleWalls(Globals.GAME_WIDTH, 10, -math.rad(90))


  self._walls["bottom"] = _wall

  local _wall = Physics:newRectangleCollider(-10, 0, 10, Globals.GAME_HEIGHT)
  _wall:setType('static')
  _wall.particle = self.particleWalls(10, Globals.GAME_HEIGHT, 0)


  self._walls["left"] = _wall

  local _wall = Physics:newRectangleCollider(Globals.GAME_WIDTH, 0, 10, Globals.GAME_HEIGHT)
  _wall:setType('static')
  _wall.particle = self.particleWalls(10, Globals.GAME_HEIGHT, math.pi)


  self._walls["right"] = _wall

  self:updateWalls(false, false, false, false)
end

function Place.particleWalls(w, h, d)
  local ps = love.graphics.newParticleSystem(Assets:Sprite("particle_0"), 240)

  ps:setColors(1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 0.5, 1, 1, 1, 0)
  ps:setDirection(d)
  ps:setEmissionArea("uniform", w, h, 0, false)
  ps:setInsertMode("top")
  ps:setLinearAcceleration(-0.45932897925377, 0, -0.45932897925377, 0)
  ps:setLinearDamping(3, 4)
  ps:setParticleLifetime(0.1778521835804, 1.5)
  ps:setRadialAcceleration(0, -0.91865795850754)
  ps:setRelativeRotation(false)
  ps:setRotation(0, 0)
  ps:setSizes(1)
  ps:setSizeVariation(1)
  ps:setSpeed(80.70420837402, 320.98919677734)
  ps:setSpin(0, 0)
  ps:setSpinVariation(0)
  ps:setSpread(0.31415927410126)
  ps:setTangentialAcceleration(0, -0.10207310318947)

  return ps
end

function Place:wallUpdate(dt)
  for _, wall in pairs(self._walls) do
    wall.particle:update(dt)
  end

  if self._state_wall == 1 then
    EntityManager:callObject(function(pool, entity, index)
      if entity.x and entity.y and entity.setX and entity.setY then
        if entity.x > Globals.GAME_WIDTH + 50 then
          entity:setX(-50)

          Assets:Sound("tp"):play {
            pitch = math.random(0.8, 2)
          }
        end

        if entity.x < -50 then
          entity:setX(Globals.GAME_WIDTH + 50)

          Assets:Sound("tp"):play {
            pitch = math.random(0.8, 2)
          }
        end

        if entity.y > Globals.GAME_HEIGHT + 50 then
          entity:setY(-50)

          Assets:Sound("tp"):play {
            pitch = math.random(0.8, 2)
          }
        end

        if entity.y < -50 then
          entity:setY(Globals.GAME_HEIGHT + 50)

          Assets:Sound("tp"):play {
            pitch = math.random(0.8, 2)
          }
        end
      end
    end)
  end

  if self._state_wall == 2 then
    if self._walls["top"]:enter("Object") and self._walls["top"].collision_class == "Solid" then
      local collider = self._walls["top"]:getEnterCollisionData("Object").collider

      if not collider or collider:isDestroyed()then
        return
      end

      collider:applyLinearImpulse(0, collider:getMass() * 500)
      self._walls["top"].particle:emit(120)

      Assets:Sound("jump"):play {
        pitch = math.random(0.8, 2)
      }
    end

    if self._walls["bottom"]:enter("Object") and self._walls["bottom"].collision_class == "Solid" then
      local collider = self._walls["bottom"]:getEnterCollisionData("Object").collider

      if not collider or collider:isDestroyed() then
        return
      end

      collider:applyLinearImpulse(0, collider:getMass() * -500)
      self._walls["bottom"].particle:emit(120)

      Assets:Sound("jump"):play {
        pitch = math.random(0.8, 2)
      }
    end

    if self._walls["left"]:enter("Object") and self._walls["left"].collision_class == "Solid" then
      local collider = self._walls["left"]:getEnterCollisionData("Object").collider

      if not collider or collider:isDestroyed() then
        return
      end

      collider:applyLinearImpulse(collider:getMass() * 500, 0)
      self._walls["left"].particle:emit(120)

      Assets:Sound("jump"):play {
        pitch = math.random(0.8, 2)
      }
    end

    if self._walls["right"]:enter("Object") and self._walls["right"].collision_class == "Solid" then
      local collider = self._walls["right"]:getEnterCollisionData("Object").collider

      if collider == nil or collider:isDestroyed() then
        return
      end

      collider:applyLinearImpulse(collider:getMass() * -500, 0)

      self._walls["right"].particle:emit(120)

      Assets:Sound("jump"):play {
        pitch = math.random(0.8, 2)
      }
    end
  end
end

function Place:createObject(x, y)
  if self._selected ~= 0 then
    EntityManager:addObject(Entities:Object(self._options[self._selected])(x, y))

  Assets:Sound("place"):play {
    pitch = math.random(0.8, 2)
  }
  end
  
end

function Place:mousereleased(x, y, button)
  if button == 2 then
    self._show = not self._show

    if self._show then
      Assets:Sound("menu_open"):play()
    else
      Assets:Sound("menu_close"):play()
    end
  end

  if button == 1 and not self._show then
    self:createObject(Cursor._x, Cursor._y)
  end
end

return Place

local EnvSettings = require "src.ui.Components.EnvSettings"
local ToyBox = require "src.ui.Components.ToyBox"
local Button = require "src.ui.elements.Button"
local Panel = require "src.ui.elements.Panel"

return Inky.defineElement(function(self, scene)
   self.props.envSettings = self.props.envSettings or EnvSettings(scene)
   self.props.toyBox      = self.props.toyBox or ToyBox(scene)
   self.props.env         = false
   self.props.toy         = false


   local p0                 = Panel(scene)
   p0.props.color           = { 0, 0, 0, 0 }

   local btn_env            = Button(Scene)
   btn_env.props.icon       = "gear"
   btn_env.props.colorIcon  = { 1, 1, 1 }
   btn_env.props.offsetIcon = vec2(16, 16)

   btn_env.props.panel      = p0
   btn_env.props.onClick    = function()
      self.props.env = not self.props.env
      Assets:Sound("gear"):play {
         pitch = math.random(0.8, 2)
      }
   end

   local btn_toy            = Button(Scene)
   btn_toy.props.icon       = "options"
   btn_toy.props.colorIcon  = { 1, 1, 1 }
   btn_toy.props.offsetIcon = vec2(16, 16)

   btn_toy.props.panel      = p0
   btn_toy.props.onClick    = function()
      self.props.toy = not self.props.toy
      Assets:Sound("option"):play {
         pitch = math.random(0.8, 2)
      }
   end

   return function(_, x, y, w, h)
      btn_env:render(x, y, 32, 32)

      if self.props.env then
         self.props.envSettings:render(x + 48, y, 520, 520)

         x, y = x, y + 200
      else
         x, y = x, y + 42
      end

      btn_toy:render(x, y, 32, 32)

      if self.props.toy then
         self.props.toyBox:render(x + 48, y, 520, 520)

         x, y = x, y + 220
      end
   end
end)

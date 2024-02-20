local State = require "src.type.State"


local Credits = State()

function Credits:init()
end

function Credits:draw()
  Push:start()
  
  lg.clear(133/255, 80/255, 1, 1)
  lg.print("Tiny ToyBox by RandomGuy",  50,40)
  lg.print("used font \n\n Dogica Font by Roberto Mocci \n\n  (SIL OPEN FONT LICENSE)", 20, 80)
  lg.print("used sounds \n\n Universal UI Soundpack\n\n    by Nathan Gibson \n\n    (CC LICENSE)", 20, 150)

  lg.print("Thanks for playing",  70,220)
  lg.draw(Assets:Sprite("icon_12"), 130, 235, 0, 2, 2)

  lg.print("made with love2d",  70,280)

  
  Cursor:draw()
  Push:finish()
end

function Credits:update(dt)
  Cursor:update(dt)
end

function Credits:mousereleased()
  SwitchState("Place")
end

return Credits

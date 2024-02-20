local State = class({
  name = "StateType",
  default_tostring = false
})

function State:new()
  self.name = "nil"
end

function State:__tostring()
  return self:type() .. "_" .. self.name
end

return State
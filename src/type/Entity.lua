local Entity = class({
  name = "Entity"
})

function Entity:new()
  self._id = ""
  self._name = ""
  self._removed = false
  self._update = false
  self._drawing = false
  self._mouse = false
  self._limit = false
end

function Entity:canUpdate()
  return self._update
end

function Entity:canDraw()
  return self._drawing
end

function Entity:canInteraction()
  return self._mouse
end

function Entity:canRemove()
  return self._removed
end

function Entity:canLimit()
  return self._limit
end

function Entity:Remove()
  self._removed = true
end

function Entity:Destroyed()
end

function Entity:id()
  return self._id
end

function Entity:name()
  return self._name
end

function Entity:__tostring()
  return self:type().. self:name() .. "_" .. self:id()
end

return Entity
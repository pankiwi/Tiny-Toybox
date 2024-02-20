Entities = {
  Objects = {},
  Effects = {}
}

function Entities:Load()
  self.Objects = Utils.requireFolder("src.entities.Object")
  self.Effects = Utils.requireFolder("src.entities.Effect")
end

function Entities:Object(name)
  return self.Objects[name]
end


function Entities:Effect(name)
  return self.Effects[name]
end
Assets = {
  sprites = {},
  sounds  = {},
  musics  = {},
  fonts   = {}
}


function Assets:Load()
  self:LoadSprites()
  self:LoadUI()
  self:LoadFonts()
  self:LoadSounds()
end

function Assets:LoadSprites()
  self.sprites["gear"] = love.graphics.newImage("assets/sprites/ui/gear.png")
  self.sprites["options"] = love.graphics.newImage("assets/sprites/ui/options.png")


  for i = 0, 4, 1 do
    self.sprites["particle_" .. i] = love.graphics.newImage("assets/sprites/particle_" .. i .. ".png")
    self.sprites["particle_" .. i]:setFilter("nearest")
  end
end

function Assets:LoadFonts()
  self.fonts["dogica_bold"] = love.graphics.newFont("assets/dogicabold.ttf", 8)
  self.fonts["dogica"] = love.graphics.newFont("assets/dogica.ttf", 8)
end

function Assets:LoadUI()
  for i = 0, 4, 1 do
    self.sprites["panel_" .. i] = P9.load("assets/sprites/ui/panel_" .. i .. ".png")
  end

  for i = 0, 19, 1 do
    self.sprites["icon_" .. i] = love.graphics.newImage("assets/sprites/ui/icon_" .. i .. ".png")
    self.sprites["icon_" .. i]:setFilter("nearest")
  end


  for i = 0, 4, 1 do
    self.sprites["options_" .. i] = love.graphics.newImage("assets/sprites/ui/options_" .. i .. ".png")
    self.sprites["options_" .. i]:setFilter("nearest")
  end
end

function Assets:LoadSounds()
  local sounds = Utils.recursiveEnumerate("assets/sounds", {})

  for _, sound in ipairs(sounds) do
    local path = sound:sub(1, -5)
    local file = string.sub(path, string.find(path, Utils.REGEX_NAME_PATH))

    self.sounds[file] = Ripple.newSound(love.audio.newSource(sound, 'static'), {
      tags = { Globals.Tags["sfx"] }
    })
  end
end

function Assets:Sprite(name)
  return self.sprites[name]
end

function Assets:Sound(name)
  return self.sounds[name]
end

function Assets:Music(name)
  return self.musics[name]
end

function Assets:Font(name)
  return self.fonts[name]
end

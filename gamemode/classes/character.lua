RP.Character = class("Character", RP.Base)

local char = RP.Character

char.bounty = 0

char.name = "Character"

char.model = "models/kleiner.mdl"

char.title = ""

char.alive = true

char.deathCount = 0

char.experience = 0

char.upgradePoints = 0

char.stats = RP.Stats()

function char:__tostring()
  local str = "Character ('" .. char.name .. "', " .. self.id .. "): {\n"
  str = str .. tostring(self.stats)
  str = str .. "\n}"
  return str
end

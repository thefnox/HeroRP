RP.Stats = class("Stats", RP.Base)

local stats = RP.Stats

local health = 100

local healthRegen = 0.5

local manaRegen = 0.5

local staminaRegen = 0.5

local level = 1

local mana = 0

local stamina = 0

local fortitude = 1

local intelligence = 1

local dexterity = 1

local constitution = 1

local perception = 1

local charisma = 1

local modifiers = {}

stats.static.baseHealth = 100
stats.static.baseStamina = 100
stats.static.baseHealthPerLevel = 20
stats.static.baseManaPerLevel = 20
stats.static.baseStaminaPerLevel = 20
stats.static.baseHealthRegen = 0.5
stats.static.baseStaminaRegen = 0.5
stats.static.baseManaRegen = 1

function stats:initialize(id, tbl)
  if (id != nil) then
    self.id = id
  else
    self.id = uuid()
  end
  if (tbl != nil) then
    health = tbl["health"]
    mana = tbl["mana"]
    stamina = tbl["stamina"]
    level = tbl["level"]
    fortitude = tbl["fortitude"]
    intelligence = tbl["intelligence"]
    dexterity = tbl["dexterity"]
    constitution = tbl["constitution"]
    perception = tbl["perception"]
    charisma = tbl["charisma"]
  end
end

function stats:__tostring()
  local str = "Stats: {\n"
  str = str .. "\tLVL: " .. level .. ",\n"
  str = str .. "\tHP: " .. self:GetHealth() .. "/" .. self:GetMaxHealth() .. ",\n"
  str = str .. "\tMNA: " .. self:GetMana() .. "/" .. self:GetMaxMana() .. ",\n"
  str = str .. "\tSTA: " .. self:GetStamina() .. "/" .. self:GetMaxStamina() .. ",\n"
  str = str .. "\tHRG: " .. self:GetHealthRegen() .. ",\n"
  str = str .. "\tMRG: " .. self:GetManaRegen() .. ",\n"
  str = str .. "\tSRG: " .. self:GetStaminaRegen() .. ",\n"
  str = str .. "\tFOR: " .. self:GetFortitude() .. ",\n"
  str = str .. "\tINT: " .. self:GetIntelligence() .. ",\n"
  str = str .. "\tDEX: " .. self:GetDexterity() .. ",\n"
  str = str .. "\tCON: " .. self:GetConstitution() .. ",\n"
  str = str .. "\tPER: " .. self:GetPerception() .. ",\n"
  str = str .. "\tCHR: " .. self:GetCharisma() .. "\n"
  str = str .. "}"
  return str
end

function stats:GetModifiers(stat)
    for modifier, tbl in pairs(modifiers) do
      if tbl[stat] != nil then
        return tbl[stat]
      end
    end
    return 0
end

function stats:AddModifiers(name, tbl)
  modifiers[name] = tbl
end

function stats:RemoveModifiers(name)
  modifiers[name] = nil
end

function stats:GetHealth()
  return math.Clamp(health, 0, self:GetMaxHealth())
end

function stats:GetMana()
  return math.Clamp(mana, 0, self:GetMaxMana())
end

function stats:GetStamina()
  return math.Clamp(stamina, 0, self:GetMaxStamina())
end

function stats:GetHealthRegen()
  return stats.static.baseHealthRegen + self:GetModifiers("healthRegen")
end

function stats:GetManaRegen()
  return stats.static.baseManaRegen + self:GetModifiers("manaRegen")
end

function stats:GetStaminaRegen()
  return stats.static.baseStaminaRegen + self:GetModifiers("staminaRegen")
end

function stats:GetBaseMaxHealth()
  return stats.static.baseHealth + (stats.static.baseHealthPerLevel * (level * 0.75 + self:GetConstitution()))
end

function stats:GetMaxHealth()
  return math.Round(math.max(self:GetBaseMaxHealth() + self:GetModifiers("maxHealth"), stats.static.baseHealth))
end

function stats:GetBaseMaxMana()
  return stats.static.baseManaPerLevel * (level * 0.5 + self:GetIntelligence())
end

function stats:GetMaxMana()
  return math.Round(math.max(self:GetBaseMaxMana() + self:GetModifiers("maxMana"), 0))
end

function stats:GetBaseMaxStamina()
  return stats.static.baseStamina + (stats.static.baseStaminaPerLevel * (level * 0.35 + self:GetDexterity()))
end

function stats:GetMaxStamina()
  return math.Round(math.max(self:GetBaseMaxStamina() + self:GetModifiers("maxStamina"), 0))
end

function stats:GetBaseFortitude()
  return fortitude
end

function stats:GetBaseIntelligence()
  return intelligence
end

function stats:GetBaseDexterity()
  return dexterity
end

function stats:GetBaseConstitution()
  return constitution
end

function stats:GetBasePerception()
  return perception
end

function stats:GetBaseCharisma()
  return charisma
end

function stats:GetFortitude()
  return math.Round(math.max(self:GetBaseFortitude() + self:GetModifiers("fortitude"), 1))
end

function stats:GetIntelligence()
  return math.Round(math.max(self:GetBaseIntelligence() + self:GetModifiers("inteligence"), 1))
end

function stats:GetDexterity()
  return math.Round(math.max(self:GetBaseDexterity() + self:GetModifiers("dexterity"), 1))
end

function stats:GetConstitution()
  return math.Round(math.max(self:GetBaseConstitution() + self:GetModifiers("constitution"), 1))
end

function stats:GetPerception()
  return math.Round(math.max(self:GetBasePerception() + self:GetModifiers("perception"), 1))
end

function stats:GetCharisma()
  return math.Round(math.max(self:GetBaseCharisma() + self:GetModifiers("charisma"), 1))
end

function stats:SetIntelligence(value)
  intelligence = math.max(1, value)
end

function stats:SetFortitude(value)
  fortitude = math.max(1, value)
end

function stats:SetDexterity(value)
  dexterity = math.max(1, value)
end

function stats:SetConstitution(value)
  constitution = math.max(1, value)
end

function stats:SetPerception(value)
  perception = math.max(1, value)
end

function stats:SetCharisma(value)
  charisma = math.max(1, value)
end

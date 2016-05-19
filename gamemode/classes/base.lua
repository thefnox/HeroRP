RP.Base = class("Base")

function RP.Base:initialize(id)
  if (id != nil) then
    self.id = id
  else
    self.id = uuid()
  end
end

function RP.Base:__tostring()
  return "Class " .. self.name .. " (ID:" .. self.id .. ")"
end

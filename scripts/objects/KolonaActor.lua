local Kolona, super = Class(ActorSprite)

function Kolona:init(actor)
    super.init(self, actor)
    -- parts init
    self.wreath = KolonaPart("enemies/kolona/idle_wreath", 0, 0)
    self.wreath.id = "wreath"
    self.wreath.layer = 0
    self:addChild(self.wreath)

    self.pillar = KolonaPart("enemies/kolona/pillar", 0, 0)
    self.pillar.id = "pillar"
    self.pillar.layer = 1
    self:addChild(self.pillar)

    self.flame = KolonaFlame(0, 0)
    self.flame.id = "flame"
    self.flame.layer = 2
    self:addChild(self.flame)

    self.face = KolonaPart("enemies/kolona/face/kolonaface_3", 0, 0)
    self.face.id = "face"
    self.face.layer = 3
    self:addChild(self.face)
    
    self.parts = {
        self.wreath,
        self.pillar,
        self.flame,
        self.face
    }

end

function Kolona:getPart(name)
    if isClass(name) then
        return name
    elseif self[name] then
        return self[name]
    end
end
function Kolona:setAnimation(anim)
    if not ignore_actor then
        self.actor:onSetAnimation(self, anim)
    end
end
function Kolona:setPartSprite(name, path)
    local part = self:getPart(name)
    part:setSprite(path)
end

return Kolona
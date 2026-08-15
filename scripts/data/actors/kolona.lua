local Kolona, super = Class(Actor, "kolona")

function Kolona:init()
    super.init(self)
    self.width, self.height = 64, 64
    self.hitbox = {16, 32, 32, 32}
    self.path = "enemies/kolona"
    self.voice = nil
    self.default = "kolonablank"
end
function Kolona:onSpriteInit(sprite)
    sprite.siner = math.random(1, 10)
end

function Kolona:onSetAnimation(sprite, anim)
    if anim == "kolonadamage" then
        sprite:setPartSprite("face", "enemies/kolona/face/kolonaface_2")
        sprite:setPartSprite("wreath", "enemies/kolona/hurt_wreath")
    elseif anim == "kolonadamageend" then
        sprite:setPartSprite("face", "enemies/kolona/face/kolonaface_3")
        sprite:setPartSprite("wreath", "enemies/kolona/idle_wreath")
    end
end
function Kolona:preSpriteUpdate(sprite)
    sprite.siner = sprite.siner + DT
    sprite.y = sprite.y + math.sin(sprite.siner*2) / 32
end
function Kolona:createSprite()
    return KolonaActor(self)
end

return Kolona
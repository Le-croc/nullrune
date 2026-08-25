local Kolona, super = Class(Actor, "kolona")

function Kolona:init()
    super.init(self)
    self.width, self.height = 64, 64
    self.hitbox = {16, 32, 32, 32}
    self.path = "enemies/kolona"
    self.voice = nil
    self.default = "kolonablank"
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
--float anim
function Kolona:onSpriteInit(sprite)
    sprite.siner = math.random(1, 10)
    Game.stage.timer:every(1/30, function ()
        if not self then return false end
        sprite.siner = sprite.siner + 1/30
        sprite.y = sprite.y + math.sin(sprite.siner*2)/32
    end)
end
function Kolona:createSprite()
    return KolonaActor(self)
end

return Kolona
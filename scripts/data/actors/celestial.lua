local Celestial, super = Class(Actor, "celestial")

function Celestial:init()
    super.init(self)
    self.name = "Celestial"
    self.width, self.height = 106, 106
    self.hitbox = {8, 16, 106, 182}
    self.color = { 1, 0, 0 }
    self.flip = nil
    self.path = "enemies/celestial"
    self.default = "idle"
    self.voice = nil
    self.portrait_path = nil
    self.portrait_offset = nil
    self.can_blush = false
    self.talk_sprites = {}

    self.animations = {
        ["idle"] = { "idle", 0.25, true },
    }

    self.offsets = {
        ["idle"] = { 0, 0 },
    }
end
--  float anim
function Celestial:onSpriteInit(sprite)
    sprite.siner = math.random(1, 10)
    Game.stage.timer:every(1/30, function ()
        sprite.siner = sprite.siner + 1/30
        sprite.y = sprite.y + math.sin(sprite.siner*2)/8
    end)
end

return Celestial

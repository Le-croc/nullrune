local Evilmart, super = Class(Actor, "evilmart")

function Evilmart:init()
    super.init(self)
    self.name = "Evil Red Mart"
    self.width, self.height = 39, 33
    self.hitbox = {0, 0, 39, 33}
    self.color = { 1, 0, 0 }
    self.flip = nil
    self.path = "enemies/evilredmart"
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
function Evilmart:onSpriteInit(sprite)
    if not self then return false end
    sprite.siner = math.random(1, 10)
    Game.stage.timer:every(1/30, function ()
        sprite.siner = sprite.siner + 1/30
        sprite.y = sprite.y + math.sin(sprite.siner*2)/8
    end)
end

return Evilmart

local Telefragger, super = Class(Actor, "telefragger")

function Telefragger:init()
    super.init(self)
    self.name = "Telefragger"
    self.width, self.height = 48, 48
    self.hitbox = {8, 16, 24, 24}
    self.color = { 1, 0, 0 }
    self.flip = nil
    self.path = "enemies/telefragger"
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
function Telefragger:onSpriteInit(sprite)
    sprite:setScale(3/4)
    sprite.siner = math.random(1, 10)
    Game.stage.timer:every(1/30, function ()
        sprite.siner = sprite.siner + 1/30
        sprite.y = sprite.y + math.sin(sprite.siner*2)/8
    end)
end

return Telefragger

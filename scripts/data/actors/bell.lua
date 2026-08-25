local Bell, super = Class(Actor, "bell")

function Bell:init()
    super.init(self)
    self.name = "bell"
    self.width, self.height = 64, 64
    self.hitbox = {16, 32, 32, 32}
    self.color = { 1, 0, 0 }
    self.flip = nil
    self.path = "enemies/bell"
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
--float anim
function Bell:onSpriteInit(sprite)
    sprite.siner = math.random(1, 10)
    Game.stage.timer:every(1/30, function ()
        if not self then return false end
        sprite.siner = sprite.siner + 1/30
        sprite.y = sprite.y + math.sin(sprite.siner*2)/8
    end)
end
function Bell:preSpriteUpdate(sprite)

    return super.preSpriteUpdate(self, sprite)
end

return Bell

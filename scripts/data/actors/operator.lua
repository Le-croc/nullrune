local actor, super = Class(Actor, "operator")

function actor:init()
    super.init(self)
    self.name = "Operator"
    self.width = 64
    self.height = 64
    self.hitbox = {16, 32, 32, 32}
    self.color = { 1, 0, 0 }
    self.flip = nil
    self.path = "enemies/operator"
    self.default = "idle"
    self.voice = nil
    self.portrait_path = nil
    self.portrait_offset = nil
    self.can_blush = false
    self.talk_sprites = {}
    self.animations = {
        ["idle"] = { "idle", 0.25, true },
    }

    -- wobble animation

    function actor:onSpriteInit(sprite)
        if not self then return false end
        sprite.siner = math.random(1, 10)
        sprite.rot = 0
        sprite:setRotationOrigin(0.5, 0.55)
        Game.stage.timer:every(1/30, function ()
            -- IF YOU TOUCH THIS IT WILL PROBABLY FUCKING EXPLODE AND DIE
            -- SO DONT
            -- yes, i do know how fucking stupid this is please help
            -- makes operator wobble while it is attacking
            sprite.ifrot = sprite.rot%30
            local rotations = {
            0, 2, 4, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 4, 2, 0,
            -2, -4, -5, -5, -5, -5, -5, -5, -5, -5, -5, -5, -4, -2
            }
            if sprite:isSprite("attacking") then
                sprite.rotation = math.rad(rotations[sprite.ifrot + 1])
                sprite.rot = sprite.rot + 2
            elseif sprite:isSprite("idle") then
                if sprite.rotation == math.rad(5) then
                    sprite.rotation = math.rad(4)
                elseif sprite.rotation == math.rad(4) then
                    sprite.rotation = math.rad(2)
                elseif sprite.rotation == math.rad(2) then
                    sprite.rotation = 0
                elseif sprite.rotation == math.rad(-5) then
                    sprite.rotation = math.rad(-4)
                elseif sprite.rotation == math.rad(-4) then
                    sprite.rotation = math.rad(-2)
                elseif sprite.rotation == math.rad(-2) then
                    sprite.rotation = 0
                end
                sprite.siner = sprite.siner + 1/30
                sprite.y = sprite.y + math.sin(sprite.siner*2) / 16
            end
        end)
    end
    self.offsets = {
        ["idle"] = { 0, 0 },
    }
end

return actor

local actor, super = Class(Actor, "VBO")

function actor:init()
    super.init(self)

    -- Display name (optional)
    self.name = "Voidbound Operator"
    self.width = 64
    self.height = 64
    self.hitbox = {16, 32, 32, 32}
    self.color = { 1, 0, 0 }
    self.flip = nil
    self.path = "enemies/VBO"
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
        sprite.siner = math.random(1, 10)
        sprite.rot = 0
        sprite:setRotationOrigin(0.5, 0.5)
        Game.stage.timer:every(1/30, function ()
            if not self then return false end
            -- IF YOU TOUCH THIS IT WILL PROBABLY FUCKING EXPLODE AND DIE
            -- SO DONT
            -- yes, i do know how fucking stupid this is please help
            -- makes VBO wobble while it is attacking, hover while it is idle
            sprite.ifrot = sprite.rot%30
            local rotations = {
            1, 1, -3, -6.5, -8.5, -11, -10, -10, -10, -10, -8.5, -6.5, -3, 2, 1,
            1, 1, -3, -6.5, -8.5, -11, -10, -10, -10, -10, -8.5, -6.5, -3, 2, 1
            }
            if sprite:isSprite("attacking") or sprite:isSprite("attacking_f") then
                sprite.rotation = math.rad(rotations[sprite.ifrot + 1])
                sprite.rot = sprite.rot + 1
            elseif sprite:isSprite("idle") then
                if sprite.rotation == math.rad(1) then
                    sprite.rotation = 0
                elseif sprite.rotation == math.rad(2) then
                    sprite.rotation = 0
                elseif sprite.rotation == math.rad(-11) then
                    sprite.rotation = math.rad(-10)
                elseif sprite.rotation == math.rad(-10) then
                    sprite.rotation = math.rad(-8.5)
                elseif sprite.rotation == math.rad(-8.5) then
                    sprite.rotation = math.rad(-6.5)
                elseif sprite.rotation == math.rad(-6.5) then
                    sprite.rotation = math.rad(-3)
                elseif sprite.rotation == math.rad(-3) then
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

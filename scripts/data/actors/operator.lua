local actor, super = Class(Actor, "operator")

function actor:init()
    super.init(self)

    -- Display name (optional)
    self.name = "Operator"

    -- Width and height for this actor, used to determine its center
    self.width = 64
    self.height = 64

    -- Hitbox for this actor in the overworld (optional, uses width and height by default)
    self.hitbox = {16, 32, 32, 32}

    -- Color for this actor used in outline areas (optional, defaults to red)
    self.color = { 1, 0, 0 }

    -- Whether this actor flips horizontally (optional, values are "right" or "left", indicating the flip direction)
    self.flip = nil

    -- Path to this actor's sprites (defaults to "")
    self.path = "enemies/operator"
    -- This actor's default sprite or animation, relative to the path (defaults to "")
    self.default = "idle"

    -- Sound to play when this actor speaks (optional)
    self.voice = nil
    -- Path to this actor's portrait for dialogue (optional)
    self.portrait_path = nil
    -- Offset position for this actor's portrait (optional)
    self.portrait_offset = nil

    -- Whether this actor as a follower will blush when close to the player
    self.can_blush = false

    -- Table of talk sprites and their talk speeds (default 0.25)
    self.talk_sprites = {}

    -- Table of sprite animations
    self.animations = {
        -- Looping animation with 0.25 seconds between each frame
        -- (even though there's only 1 idle frame)
        ["idle"] = { "idle", 0.25, true },

    }
    -- wobble animation

    function actor:onSpriteInit(sprite)
        sprite.siner = 0
        sprite.rot = 0
        sprite:setRotationOrigin(0.5, 0.55)
    end

    function actor:preSpriteUpdate(sprite)
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
            sprite.siner = sprite.siner + DT
            sprite.y = sprite.y + math.sin(sprite.siner*2) / 16
        end

    end
    -- Table of sprite offsets (indexed by sprite name)
    self.offsets = {
        -- Since the width and height is the idle sprite size, the offset is 0,0
        ["idle"] = { 0, 0 },
    }
end

return actor

---@class cutter : Bullet
local cutter, super = Class(Bullet)

---@param x number 
---@param y number
---@param rotation number
---@param nr number
---@param is_last number
function cutter:init(x, y, rotation, nr, is_last)
    super.init(self, x, y, "bullets/cutter/cutter_i")
    self.can_graze = false
    self.rotation = math.rad(rotation)
    self.destroy_on_hit = false
    self.collider = nil
    if nr == 1 then
        Game.stage.timer:after(1.7, function () 
            if is_last == 0  then Assets.playSound("celestial/cutter/cutter_h")
            else Assets.playSound("celestial/cutter/cutter_f")
            end
            end)
    end
    Game.stage.timer:approach(1.7, math.rad(rotation), math.rad(rotation+360), function (r)
        self.rotation = r
    end, "outCirc")
    Game.stage.timer:after(1.7, function () 
        self:setSprite("bullets/cutter/cutter")
        self:setHitbox(2, 0, self.width*0.8, self.height/2-15)
        Game.stage.timer:approach(1, 2, 0.1, function (x)
            self:setScale(x, 2)
        end, "outSine")
        Game.stage.timer:after(0.8, function ()
            self.collider = nil
            self:remove()
        end)
    end)
end

function cutter:onDamage(soul)
    if touchingmagicbox == false then
        return super.onDamage(self, soul)
    else
    end
end

return cutter

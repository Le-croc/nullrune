local em1, super = Class(Wave)

function em1:init()
    super.init(self)
    self.time = 10
end
function em1:onStart()
    -- check for ability armors
    super.onStart(self)
    -- arena size
    self.timer:approach(1, 142, SCREEN_WIDTH/2, function (wid)
        if wid <= SCREEN_HEIGHT/2 then
            self:setArenaSize(wid, wid+14)
        else
            self:setArenaSize(wid, Game.battle.arena.height)
        end
    end, "in-cubic")

    --attacks
    self.timer:every(1.5, function ()
        self:circlebeams()
        self:spawnBullet("smallevilmart", math.random(SCREEN_WIDTH/3, SCREEN_WIDTH*2/3), math.random(SCREEN_HEIGHT/3, SCREEN_HEIGHT*2/3), 0, math.random(8,13)/10, 1)
    end, 4)
end
function em1:circlebeams()
    Assets.playSound("celestial/cutter/cutter_c",0.7,1.1)
    for i=1, math.random(6,8) do
        local x1=math.random(SCREEN_WIDTH/3, SCREEN_WIDTH*2/3)
        self:spawnBullet("evilmartcirclebeam", x1, SCREEN_HEIGHT-9)
    end
    self.timer:after(1.2, function ()
        Assets.playSound("celestial/cutter/cutter_h",0.7,1.1)
    end)
end




function em1:update()
    super.update(self)
end

return em1



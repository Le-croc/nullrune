local Placeholder, super = Class(Wave)

function Placeholder:init()
    super.init(self)
    self.time = 20
end
function Placeholder:onStart()
    --  vars
    playvimpsound = 0
    -- arena size
    self.timer:approach(1, 142, SCREEN_WIDTH, function (wid)
        if wid <= SCREEN_HEIGHT then
            self:setArenaSize(wid, wid+14)
        else
            self:setArenaPosition(SCREEN_WIDTH/2, SCREEN_HEIGHT/2)
            self:setArenaSize(wid, Game.battle.arena.height)
        end
    end, "in-cubic")

    --attacks
    self.timer:after(1.2, function ()
        self:dib()
    end)
    super.onStart(self)
end

function Placeholder:dib()
    self:spawnBullet("deathinbloom",math.random(0, SCREEN_WIDTH),math.random(0, SCREEN_HEIGHT))
end

function Placeholder:circlebeams()
    Assets.playSound("celestial/cutter/cutter_c",0.7,1.1)
    for i=1, math.random(8,10) do
        local x1=math.random(0, SCREEN_WIDTH)
        self:spawnBullet("circlebeam", x1, SCREEN_HEIGHT-9)
    end
    self.timer:after(2, function ()
        Assets.playSound("celestial/cutter/cutter_h",0.7,1.1)
    end)
end

function Placeholder:trih()
    for i=1, 5 do
        local x1 = math.random(0, SCREEN_WIDTH)
        local y1 = math.random(0, SCREEN_HEIGHT)
        self:spawnBullet("trih", x1, y1)
    end
end
function Placeholder:gih()
    for i=1, 20 do
        local x1 = math.random(0, SCREEN_WIDTH)
        local y1 = math.random(0, SCREEN_HEIGHT)
        self:spawnBullet("gih", x1, y1)
    end
end
    
function Placeholder:fall()
    self.timer:everyInstant(1.2, function ()
        self:spawnBullet("IIIEbeam", Game.battle.soul.x, Game.battle.soul.y, 1, 0.8)
    end, 3)
    self.timer:after(3.6, function ()
        Assets.playSound("celestial/1113/1113_F")
        self:spawnBullet("IIIEbeam", Game.battle.soul.x, Game.battle.soul.y, 3, 1.5)
        self:spawnBullet("IIIEbeam", Game.battle.soul.x, Game.battle.soul.y, 3, 1.5)
        self:spawnBullet("IIIEbeam", Game.battle.soul.x, Game.battle.soul.y, 3, 1.5)
    end)
end

function Placeholder:vimps()
    Assets.playSound("celestial/vimps/vimp_c", 1, 2)
    for i=1, 20 do
        local x1 = math.random(0, SCREEN_WIDTH)
        local y1 = math.random(0, SCREEN_HEIGHT)
        self:spawnBullet("vimp", x1, y1, math.random(0, 30))
    end
end

function Placeholder:cutter()
    Assets.playSound("celestial/cutter/cutter_c")
    local rotation = math.random(0, 360)
    local x1 = math.random(0, SCREEN_WIDTH)
    local y1 = math.random(0, SCREEN_HEIGHT)
    self:spawnBullet("secretboxthatnegatesdamageandfixesthecutterattack", x1, y1, rotation)
    for i=0,7 do
        self:spawnBullet("cutter", x1, y1, rotation+45*i, i+1, 0)
        end
    self.timer:every(2.4, function ()
        local rotation = math.random(0, 360)
        local x1 = math.random(0, SCREEN_WIDTH)
        local y1 = math.random(0, SCREEN_HEIGHT)
        self:spawnBullet("secretboxthatnegatesdamageandfixesthecutterattack", x1, y1, rotation)
        for i=0,7 do
        self:spawnBullet("cutter", x1, y1, rotation+45*i, i+1, 0)
        end
    end, 2)
    self.timer:after(7.2, function ()
        local rotation = math.random(0, 360)
        local x1 = math.random(0, SCREEN_WIDTH)
        local y1 = math.random(0, SCREEN_HEIGHT)
        self:spawnBullet("secretboxthatnegatesdamageandfixesthecutterattack", x1, y1, rotation)
        for i=0,7 do
        self:spawnBullet("cutter", x1, y1, rotation+45*i, i+1, 1)
        end
    end, 2)
end

function Placeholder:update()
    super.update(self)
end


return Placeholder



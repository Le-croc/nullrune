local em2, super = Class(Wave)

function em2:init()
    super.init(self)
    self.time = 15
end
function em2:onStart()
    Game.battle:swapSoul(BallGameSoul())
    self.timer:after(1, function()
    self:spawnBullet("smallevilmart", math.random(SCREEN_WIDTH/3, SCREEN_WIDTH*2/3), math.random(0, SCREEN_HEIGHT/2), 0, math.random(8,13)/4, 0.5)
    self:spawnBullet("smallevilmart", math.random(SCREEN_WIDTH/3, SCREEN_WIDTH*2/3), math.random(0, SCREEN_HEIGHT/2), 0, math.random(8,13)/4, 0.5)
    self:spawnBullet("smallevilmart", math.random(SCREEN_WIDTH/3, SCREEN_WIDTH*2/3), math.random(0, SCREEN_HEIGHT/2), 0, math.random(8,13)/4, 0.5)
    self:spawnBullet("smallevilmart", math.random(SCREEN_WIDTH/3, SCREEN_WIDTH*2/3), math.random(0, SCREEN_HEIGHT/2), 0, math.random(8,13)/4, 0.5)
    self:spawnBullet("martblaster", SCREEN_WIDTH/2, SCREEN_HEIGHT/2-65, 0)
    self:spawnBullet("martblaster", SCREEN_WIDTH/2, SCREEN_HEIGHT/2-65, math.rad(90))
    Assets.playSound("mart/idle",  0.6)
    end)
end

function em2:update()
    super.update(self)
end

return em2

local VBOattack, super = Class(Wave)
function VBOattack:init()
    super.init(self)
    self.time = 5
end

function VBOattack:onStart()
    Game.battle:swapSoul(BallGameSoul())
    local x = SCREEN_WIDTH/2
    local y = SCREEN_HEIGHT/2-68
    local enemy = Game.battle:getEnemyBattler("VBO")
    enemy.sprite:setSprite("attacking")
    Assets.playSound("VBO/VBO_Ticking")
    local tick = 0
    Vbokey = 0
    -- key is used to determine whether attacks will be orange/blue
    self.timer:every(0.2, function()
        if Game.battle:getState() == "DEFENDINGEND" then
            return false
        end
        tick = tick+1
        if tick == 3 or tick == 6 or tick == 9 then
            if math.random(0,1) == 1 then 
                self:spawnBullet("arenaflashblue", x, y)
                Vbokey = Vbokey*10 + 1
            else
                self:spawnBullet("arenaflashorange", x, y)
                Vbokey = Vbokey*10 + 2
            end
        elseif tick == 11 then
            Vbokey = math.floor(Vbokey/100) + math.floor(Vbokey/10%10)*10 + Vbokey%10*100
        elseif tick == 15 or tick == 18 or tick == 21 then
            if Vbokey%2 == 1 then 
                self:spawnBullet("arenaattackblue_vbo", x, y)
            elseif Vbokey%2 == 0 then
                self:spawnBullet("arenaattackorange_vbo", x, y)
            end
            Vbokey = math.floor(Vbokey/10)
        elseif tick == 23 then
            Assets.playSound("VBO/VBO_Cleared")
        end
    end)
end
function VBOattack:onEnd()
    local enemy = Game.battle:getEnemyBattler("VBO")
    enemy.sprite:setSprite("idle")
end

return VBOattack

local function FindSnailByID(world, player)
    for k,v in pairs(world.components.persistentsnail_manager.snaillink) do
        if player.userid == v.userid then
            return v.snailent
        end
    end
    return nil
end

local function OnPlayerJoined(world, player)
    if FindSnailByID(world, player) ~= nil then
        world.components.persistentsnail_manager:SpawnSnailForPlayer(player, FindSnailByID(world, player):GetPosition()) --spawn positioned snail
    else
        world.components.persistentsnail_manager:SpawnSnailForPlayer(player)
    end
end

local function OnPlayerLeft(world, player)
    world.components.persistentsnail_manager:RemoveFromSnailLog(player)
    for k,v in pairs(snaillink) do
        if v.snailent:HasTag("target_"..player.userid) then
            world.components.persistentsnail_manager:AddToSnailLog(player, v)
            v:Remove()
        end
    end
end

--------------------------------------------------------

local PersistentSnailManager = Class(function(self, inst)
    assert(TheWorld.ismastersim, "PersistentSnail Manager should not exist on the client!")

    self.inst = inst

    self.snaillink = {}

    self.inst:ListenForEvent("ms_playerjoined", OnPlayerJoined)
    self.inst:ListenForEvent("ms_playerleft",   OnPlayerLeft)
end)

function PersistentSnailManager:SpawnSnailForPlayer(player, snailpos)
    local angrysnail = SpawnPrefab("persistentsnail")
    angrysnail.components.persistenthunter:SetTargetByID(player.userid)
    if snailpos ~= nil then
        angrysnail.Transform:SetPosition(snailpos.x, snailpos.y, snailpos.z)
    else
        --angrysnail.Transform:SetPosition(player:GetPosition()) -- still make random
    end
    TheWorld.components.persistentsnail_manager:AddToSnailLog(player, angrysnail)
end

function PersistentSnailManager:AddToSnailLog(player, snail)
    if FindSnailByID(TheWorld, player) == nil then
        table.insert(self.snaillink, {userid = player.userid, snailent = snail}) --
    end
end

function PersistentSnailManager:RemoveFromSnailLog(player)
    for i, v in ipairs(self.snaillink) do
        if v.userid == player.userid then
            table.remove(self.snaillink, i)
        end
    end
end

--------------------------------------------------------

function PersistentSnailManager:OnSave()
        data.snaillink = self.snaillink
    return data
end

function PersistentSnailManager:OnLoad(data)
    if data then
        self.snaillink = data.snaillink
    end
end

--------------------------------------------------------

return PersistentSnailManager
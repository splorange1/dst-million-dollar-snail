local function FindSnailPosByID(playerid)
    for k,v in pairs(TheWorld.components.persistentsnail_manager.snailtable) do
        if playerid == v.userid then
            return v.snailpositionx, v.snailpositiony, v.snailpositionz
        end
    end
    return nil
end

--------------------------------------------------------

local PersistentSnailManager = Class(function(self, inst)
    assert(TheWorld.ismastersim, "PersistentSnail Manager should not exist on the client!")

    self.inst = inst

    self.snailtable = {}
    self.activesnails = {}

    self.inst:ListenForEvent("ms_playerjoined", function(src, player) self:OnPlayerJoined(player) end, TheWorld)
    self.inst:ListenForEvent("ms_playerleft",   function(src, player) self:OnPlayerLeft(player) end, TheWorld)

    
    function self:OnSave()
        self:UpdateSnailTable()
        local data = {
            snailtable = self.snailtable
        }
        return data
    end

    function self:OnLoad(data)
        if not data then return end
        self.snailtable = data.snailtable or self.snailtable
    end

    function self:OnPlayerJoined(player)
        local x,y,z = FindSnailPosByID(player.userid)
        if x ~= nil then  --spawn existing snail from table
            self:SpawnSnailForPlayer(player, x,y,z)
        else
            self:SpawnSnailForPlayer(player) --new player, new snail
        end
    end

    function self:OnPlayerLeft(player)
        for k,v in pairs(self.activesnails) do
            if v:HasTag("target_"..player.userid) and v:IsValid() then
                local fx = SpawnPrefab("spawn_fx_small")
                local x,y,z = v.Transform:GetWorldPosition()
                fx.Transform:SetPosition(x, y, z)
                self:RemoveFromSnailTable(player)
                self:AddToSnailTable(player, v)
                v:Remove()
            end
        end
    end

end)

function PersistentSnailManager:SpawnSnailForPlayer(player, x,y,z)
    TheWorld:DoTaskInTime(2, function()
        local angrysnail = SpawnPrefab("persistentsnail")
        local fx = SpawnPrefab("spawn_fx_small")
        angrysnail.components.persistenthunter:SetTargetByID(player.userid)
        if x ~= nil then
            fx.Transform:SetPosition(x, y, z)
            angrysnail.Transform:SetPosition(x, y, z)
        else
            --TODO: RANDOM SPAWN AROUND PORTAL
            local px, py, pz = player.Transform:GetWorldPosition()
            fx.Transform:SetPosition(px+10, py, pz)
            angrysnail.Transform:SetPosition(px+10, py, pz)
            self:AddToSnailTable(player, angrysnail)
        end
        table.insert(self.activesnails, angrysnail)
    end)
end

function PersistentSnailManager:AddToSnailTable(player, snail)
    if FindSnailPosByID(player.userid) == nil then
        local x,y,z = snail.Transform:GetWorldPosition()
        table.insert(self.snailtable, {userid = player.userid, snailpositionx = x, snailpositiony = y, snailpositionz = z }) --
    end
end

function PersistentSnailManager:RemoveFromSnailTable(player)
    for i, v in ipairs(self.snailtable) do
        if v.userid == player.userid then
            table.remove(self.snailtable, i)
        end
    end
end

function PersistentSnailManager:UpdateSnailTable()
    for _, i in ipairs(self.activesnails) do
        for k, v in ipairs(self.snailtable) do
            if i.components.persistenthunter.targetid == v.userid then
                table.remove(self.snailtable, k)
                self:AddToSnailTable(UserToPlayer(k), i)
            end
        end
    end
end

return PersistentSnailManager
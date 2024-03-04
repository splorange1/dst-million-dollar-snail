local PersistentHunter = Class(function(self, inst)
    self.inst = inst
    self.target = nil
    self.targetid = nil
    self.targetname = nil
    self.notargetfn = nil
    self.hastargetfn = nil
end)

function PersistentHunter:SetHasTargetFn(fn)
    self.hastargetfn = fn
end

function PersistentHunter:SetNoTargetFn(fn)
    self.notargetfn = fn
end

--[[
    not finished because not useful for the mod
function PersistentHunter:SetTarget(target)
    self.target = target
    self.targetid = target.userid
    self.targetname = target.name

    self.inst:AddTag("target_"..self.targetid)
    self.inst:DoPeriodicTask(1,function()
        if self.target ~= nil and self.target:IsValid() then
            self.inst.components.combat:SetTarget(self.target)
        end
    end)
end
]]--

function PersistentHunter:SetTargetByID(kuid)
    self.target = UserToPlayer(kuid)
    self.targetid = kuid
    self.targetname = UserToName(kuid)

    self.inst:AddTag("target_"..self.targetid)
    self:StartHunting(self.targetid)
end

function PersistentHunter:StartHunting(kuid)
    self.inst:DoPeriodicTask(1,function()
        if (self.target == nil and self.target ~= "[Host]") or self.inst.components.combat.target == nil then
            self.target = UserToPlayer(kuid) -- relocate the target if something is wrong
            if self.notargetfn then
                self.notargetfn(self.inst)
            end
        end
        if self.target ~= nil and self.target:IsValid() then
            self.inst.components.combat:SetTarget(self.target) -- sets target
            if self.notargetfn then
                self.hastargetfn(self.inst)
            end
        end
    end)
end

--TheNet:GetClientTableForUser(kuid).name
return PersistentHunter
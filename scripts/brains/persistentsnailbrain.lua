require "behaviours/standstill"
require "behaviours/runaway"
require "behaviours/doaction"
require "behaviours/useshield"
require "behaviours/wander"
require "behaviours/chaseandattack"
local BrainCommon = require("brains/braincommon")

local MAX_CHASE_TIME = 99999999
local MAX_CHASE_DIST = 99999999
local DAMAGE_UNTIL_SHIELD = TUNING.SLURTLE_DAMAGE_UNTIL_SHIELD
local AVOID_PROJECTILE_ATTACKS = true
local HIDE_WHEN_SCARED = true
local SHIELD_TIME = 2
local SEE_FOOD_DIST = 13
local HUNGER_TOLERANCE = 70

local PersistentSnailBrain = Class(Brain, function(self, inst)
	Brain._ctor(self, inst)
end)

local function CheckIfTargetIsValid(inst, kuid)
    if UserToPlayer(kuid) ~= nil then
        inst.components.combat:SetTarget(UserToPlayer(kuid))
        return true
    else
        return false
    end
end

function PersistentSnailBrain:OnStart()
    local root = PriorityNode(
    {
        --WhileNode(function() return self.inst.components.combat.target == nil end, "Inactive",
                --UseShield(self.inst, DAMAGE_UNTIL_SHIELD, SHIELD_TIME, AVOID_PROJECTILE_ATTACKS, HIDE_WHEN_SCARED)),

        ChaseAndAttack(self.inst, MAX_CHASE_TIME, MAX_CHASE_DIST)
        --WhileNode(CheckIfTargetIsValid(self.inst, "KU_g0cDSBiB"), "KILL",
        --ChaseAndAttack(self.inst, MAX_CHASE_TIME, MAX_CHASE_DIST))
        --Wander(self.inst, nil, MAX_WANDER_DIST)

    }, .25)

    self.bt = BT(self.inst, root)
end

return PersistentSnailBrain

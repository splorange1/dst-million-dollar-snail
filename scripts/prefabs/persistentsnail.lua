
local assets =
{
    Asset("ANIM", "anim/slurtle.zip"),
    Asset("ANIM", "anim/slurtle_snaily.zip"),
    Asset("SOUND", "sound/slurtle.fsb"),
}

local prefabs =
{
    "slurtleslime",
    "slurtle_shellpieces",
    "slurtlehat",
    "armorsnurtleshell",
    "explode_small",
}

local persistent_snail_brain = require "brains/persistentsnailbrain"

--[[
local function SpawnMeteorOnCorpse(inst)
    local playerpos = inst:GetPosition()
    inst:DoTaskInTime(1.2,function() --ensure the meteor hits the corpse's items
        local meteor = SpawnPrefab("shadowmeteor")
        meteor.Transform:SetPosition(playerpos.x, playerpos.y, playerpos.z)
    end)
end

local function WesTransformation(inst)
    inst.components.seamlessplayerswapper:_StartSwap("wes")
end

local function Test(inst)
end

local randompunishmentfns = 
{
    {fn = SpawnMeteorOnCorpse, name = "Shadow meteor rain!"},
    {fn = Test, name = "Test!"},
    --{fn = WesTransformation, name = "Wes transformation!"}
}

local function FindRandomPunishment(inst)
    local punishment = randompunishmentfns[math.random(#randompunishmentfns)]
    punishment.fn(inst)
    c_announce(inst.name.."'s punishment for touching the snail is: "..punishment.name)
end
]]--

local function DisplayNameFn(inst)
    for i, v in ipairs(AllPlayers) do
        if inst:HasTag("target_"..AllPlayers[i].userid) then
            local targetname = UserToName(AllPlayers[i].userid)
            return targetname.."'s Persistent Snail"
        end
    end
    return "Dormant Snail"
end

local function OnCollide(inst, other)
    if other then
        if other:HasTag("player") and inst:HasTag("target_"..other.userid) and inst.touchcooldown ~= true and other:HasTag("playerghost") ~= true then
            inst.touchcooldown = true
            inst:DoTaskInTime(10,function()
                inst.touchcooldown = false
            end)
            --FindRandomPunishment(other) perhaps in a future update
            --if inst.components.health.currenthealth and inst.components.health.currenthealth < 0 then
                --other.components.health:DoDelta(other.components.health.maxhealth * -5, nil, inst.prefab, true, inst.prefab, true)
            --end
            other:PushEvent("death")
        end
    end
end

local function HasTargetFn(inst)
    --inst:PushEvent("exitshield")
    --c_announce("t")
end

local function NoTargetFn(inst)
    --inst:PushEvent("entershield")
    --c_announce("n")
end

local function OnInit(inst)
    --
end

local function OnHitOther(inst,other)
--
end

local function OnSave(inst,data)
    if inst.components.persistenthunter and inst.components.persistenthunter.targetid then
        data.persistenttargetid = inst.components.persistenthunter.targetid
    end
end

local function OnLoad(inst,data)
    if data and data.persistenttargetid ~= nil then
        inst:DoTaskInTime(0, function()
            inst.components.persistenthunter:SetTargetByID(data.persistenttargetid) --"KU_g0cDSBiB"
        end)
    end
end

local function CustomOnHaunt(inst)
    --
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddDynamicShadow()
    inst.entity:AddNetwork()

    inst.DynamicShadow:SetSize(0.75, 0.5)

    MakeCharacterPhysics(inst, 10, 1.5)
    RemovePhysicsColliders(inst)
    inst.Physics:SetCollisionGroup(COLLISION.SANITY)

    inst.Transform:SetFourFaced()

    MakeCharacterPhysics(inst, 50, .5)

    inst.AnimState:SetBank("snurtle")
    inst.AnimState:SetBuild("slurtle_snaily")
    inst.AnimState:SetScale(.3, .3)

    inst:AddTag("NOBLOCK")

    inst.displaynamefn = DisplayNameFn

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst.Physics:SetCollisionCallback(OnCollide)

    inst:SetBrain(persistent_snail_brain)

    inst:AddComponent("locomotor")
    inst.components.locomotor.walkspeed = TUNING.SNURTLE_WALK_SPEED - 2

    inst:SetStateGraph("SGslurtle")

    inst:AddComponent("inspectable")

    inst:AddComponent("persistenthunter")
    inst.components.persistenthunter:SetHasTargetFn(HasTargetFn)
    inst.components.persistenthunter:SetNoTargetFn(NoTargetFn)

    inst:AddComponent("combat")
    inst.components.combat:SetRange(0.1)

    --inst:AddComponent("health")

    inst.entity:SetCanSleep(false)

    inst.touchcooldown = false

    inst:DoTaskInTime(0, OnInit)

    inst.OnSave = OnSave
    inst.OnLoad = OnLoad

    return inst
end

return Prefab("persistentsnail", fn, assets, prefabs)

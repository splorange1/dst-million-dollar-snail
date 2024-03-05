local modname = KnownModIndex:GetModActualName("Million Dollar Snails")
local snailspeed = GetModConfigData("snailSpeed", modname)

local assets =
{
    Asset("ANIM", "anim/slurtle.zip"),
    Asset("ANIM", "anim/slurtle_snaily.zip"),
    Asset("SOUND", "sound/slurtle.fsb"),
}

local persistent_snail_brain = require "brains/persistentsnailbrain"

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
            if other.components.health then
                other.components.health:DoDelta(other.components.health.maxhealth * -5, nil, "snaildeath")
            end
        end
    end
end

local function OnLoad(inst,data)
    inst:Remove()
end

local function GetStatus(inst, viewer)
    if inst:HasTag("target_"..viewer.userid) then
        return "LINKED"
    else
        return "NOTLINKED"
    end
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddDynamicShadow()
    inst.entity:AddNetwork()

    inst.DynamicShadow:SetSize(0.75, 0.5)

    MakeGhostPhysics(inst, .5, .5) --will aim to pathfind, but will cheat if stuck

    inst.Transform:SetFourFaced()

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
    inst.components.locomotor.walkspeed = snailspeed

    inst:SetStateGraph("SGslurtle")

    inst:AddComponent("inspectable")
    inst.components.inspectable.getstatus = GetStatus

    inst:AddComponent("persistenthunter")

    inst:AddComponent("combat")
    inst.components.combat:SetRange(0.01)

    inst:AddComponent("drownable") -- for the smart players

    inst.entity:SetCanSleep(false)

    inst.touchcooldown = false

    inst.OnLoad = OnLoad

    return inst
end

return Prefab("persistentsnail", fn, assets)

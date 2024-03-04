--
local PopupDialogScreen = require "screens/redux/popupdialog"
GLOBAL.STRINGS.NAMES.PERSISTENTSNAIL = "Persistent Snail"

PrefabFiles = {
    "persistentsnail"
}

AddPrefabPostInit("forest", function(inst)
    if GLOBAL.TheWorld.ismastersim then
        inst:AddComponent("persistentsnail_manager")
    end
end)
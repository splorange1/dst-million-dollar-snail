------------------------------------------------------------------- strings
GLOBAL.STRINGS.NAMES.PERSISTENTSNAIL = "Persistent Snail"

GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.PERSISTENTSNAIL = {
    LINKED = "I don't think I should touch it.",
    NOTLINKED = "That thing is after someone else."
}
GLOBAL.STRINGS.CHARACTERS.WALTER.DESCRIBE.PERSISTENTSNAIL = {
    LINKED = "Can we keep it, Woby?",
    NOTLINKED = "Can I touch it now?"
}
GLOBAL.STRINGS.CHARACTERS.WANDA.DESCRIBE.PERSISTENTSNAIL = {
    LINKED = "",
    NOTLINKED = ""
}
GLOBAL.STRINGS.CHARACTERS.WARLY.DESCRIBE.PERSISTENTSNAIL = {
    LINKED = "",
    NOTLINKED = ""
}
GLOBAL.STRINGS.CHARACTERS.WATHGRITHR.DESCRIBE.PERSISTENTSNAIL = {
    LINKED = "",
    NOTLINKED = ""
}
GLOBAL.STRINGS.CHARACTERS.WAXWELL.DESCRIBE.PERSISTENTSNAIL = {
    LINKED = "",
    NOTLINKED = ""
}
GLOBAL.STRINGS.CHARACTERS.WEBBER.DESCRIBE.PERSISTENTSNAIL = {
    LINKED = "We know to stay away!",
    NOTLINKED = "Who is it after?"
}
GLOBAL.STRINGS.CHARACTERS.WENDY.DESCRIBE.PERSISTENTSNAIL = {
    LINKED = "Every moment I'm not moving it gets closer.",
    NOTLINKED = "Another victim is in an endless chase."
}
GLOBAL.STRINGS.CHARACTERS.WICKERBOTTOM.DESCRIBE.PERSISTENTSNAIL = {
    LINKED = "It seems to be determined on making contact with me.",
    NOTLINKED = ""
}
GLOBAL.STRINGS.CHARACTERS.WILLOW.DESCRIBE.PERSISTENTSNAIL = {
    LINKED = "Stop chasing me!",
    NOTLINKED = "It's fun watching it chase other people!"
}
GLOBAL.STRINGS.CHARACTERS.WINONA.DESCRIBE.PERSISTENTSNAIL = {
    LINKED = "",
    NOTLINKED = ""
}
GLOBAL.STRINGS.CHARACTERS.WOLFGANG.DESCRIBE.PERSISTENTSNAIL = {
    LINKED = "Wolfgang will outsmart!",
    NOTLINKED = ""
}
GLOBAL.STRINGS.CHARACTERS.WOODIE.DESCRIBE.PERSISTENTSNAIL = {
    LINKED = "",
    NOTLINKED = ""
}
GLOBAL.STRINGS.CHARACTERS.WORMWOOD.DESCRIBE.PERSISTENTSNAIL = {
    LINKED = "Shell friend?",
    NOTLINKED = "Oh. Has other friend."
}
GLOBAL.STRINGS.CHARACTERS.WORTOX.DESCRIBE.PERSISTENTSNAIL = {
    LINKED = "Oh what fun it is to run!",
    NOTLINKED = ""
}
GLOBAL.STRINGS.CHARACTERS.WURT.DESCRIBE.PERSISTENTSNAIL = {
    LINKED = "",
    NOTLINKED = ""
}
GLOBAL.STRINGS.CHARACTERS.WX78.DESCRIBE.PERSISTENTSNAIL = {
    LINKED = "",
    NOTLINKED = ""
}

-------------------------------------------------------------------

PrefabFiles = {
    "persistentsnail"
}

AddPrefabPostInit("world", function(inst)
    if GLOBAL.TheWorld.ismastersim then
        inst:AddComponent("persistentsnail_manager")
    end
end)
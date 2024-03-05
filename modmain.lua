------------------------------------------------------------------- strings
GLOBAL.STRINGS.NAMES.PERSISTENTSNAIL = "Persistent Snail"
GLOBAL.STRINGS.NAMES.SNAILDEATH = "touching the snail"

GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.PERSISTENTSNAIL = {
    LINKED = "I don't think I should touch it.",
    NOTLINKED = "That thing is after someone else."
}
GLOBAL.STRINGS.CHARACTERS.WALTER.DESCRIBE.PERSISTENTSNAIL = {
    LINKED = "Can we keep it, Woby?",
    NOTLINKED = "Can I touch it now?"
}
GLOBAL.STRINGS.CHARACTERS.WANDA.DESCRIBE.PERSISTENTSNAIL = {
    LINKED = "Not doing this in another timeline.",
    NOTLINKED = "Oh botheration, there's multiple of them."
}
GLOBAL.STRINGS.CHARACTERS.WARLY.DESCRIBE.PERSISTENTSNAIL = {
    LINKED = "Don't think I'm making soup out of this one.",
    NOTLINKED = "Never seen something chase someone like that."
}
GLOBAL.STRINGS.CHARACTERS.WATHGRITHR.DESCRIBE.PERSISTENTSNAIL = {
    LINKED = "A mighty warrior knows their limits.",
    NOTLINKED = "It possesses the strength of a God-warrior."
}
GLOBAL.STRINGS.CHARACTERS.WAXWELL.DESCRIBE.PERSISTENTSNAIL = {
    LINKED = "Is this another prank from Wortox?",
    NOTLINKED = "So I'm not the only one."
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
    NOTLINKED = "It is oblivious to my presence! Interesting."
}
GLOBAL.STRINGS.CHARACTERS.WILLOW.DESCRIBE.PERSISTENTSNAIL = {
    LINKED = "Stop chasing me!",
    NOTLINKED = "It's fun watching it chase other people!"
}
GLOBAL.STRINGS.CHARACTERS.WINONA.DESCRIBE.PERSISTENTSNAIL = {
    LINKED = "Angry little fella.",
    NOTLINKED = "Hope it doesn't reach anyone it's after."
}
GLOBAL.STRINGS.CHARACTERS.WOLFGANG.DESCRIBE.PERSISTENTSNAIL = {
    LINKED = "Wolfgang will outsmart!",
    NOTLINKED = "Friend in danger."
}
GLOBAL.STRINGS.CHARACTERS.WOODIE.DESCRIBE.PERSISTENTSNAIL = {
    LINKED = "Better watch my step.",
    NOTLINKED = "Watch out for the little guy."
}
GLOBAL.STRINGS.CHARACTERS.WORMWOOD.DESCRIBE.PERSISTENTSNAIL = {
    LINKED = "Shell friend?",
    NOTLINKED = "Oh. Has other friend."
}
GLOBAL.STRINGS.CHARACTERS.WORTOX.DESCRIBE.PERSISTENTSNAIL = {
    LINKED = "Oh what fun it is to run!",
    NOTLINKED = "I wish I thought of this one before!"
}
GLOBAL.STRINGS.CHARACTERS.WURT.DESCRIBE.PERSISTENTSNAIL = {
    LINKED = "Makes nervous, glorp.",
    NOTLINKED = "Not friend of friend."
}
GLOBAL.STRINGS.CHARACTERS.WX78.DESCRIBE.PERSISTENTSNAIL = {
    LINKED = "WARNING: THREATENING PERSISTENT ENTITY",
    NOTLINKED = "LOOK AT THE FLESHLING RUN. HA."
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
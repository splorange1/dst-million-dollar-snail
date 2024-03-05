name = "Million Dollar Snails"
--The name of your mod
description = "Would you take 10 million dollars in exchange of having an immortal snail that follows you and kills you instantly on contact?\n\nWith this mod you can find out! Without the 10 million dollars of course.\n\n Version: 1"
--The description that shows when you are selecting the mod from the list
author = "splorange"
--Your name!
version = "1.0"

forumthread = ""

icon_atlas = "modicon.xml"

icon = "modicon.tex"

dst_compatible = true
forge_compatible = true
gorge_compatible = true

dont_starve_compatible = false
reign_of_giants_compatible = false
shipwrecked_compatible = false

all_clients_require_mod = true
server_only_mod = false
client_only_mod = false

api_version = 10
--This is the version of the game's API and should stay the same for the most part
configuration_options =
{
    {
        name = "snailSpeed",
        label = "Snail Speed",
        options =
        {
            {description = "Slow", data = 1},
            {description = "Default", data = 2},
            {description = "Intense", data = 6}

        },
        default = 2,
    }
}
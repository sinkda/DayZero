-- Config Store
DZData = {};

-- Default Values
if DZData.FirstLogin == nil then

    DZData.FirstLogin = true;
    DZData.NameplateDistance = "100";
    DZData.NameplateColor = 1;

end


-- Helper Functions
local function SetNameplateDistance(val)
    if not tonumber(val) then
        return print("[DayZero] Error setting nameplate distance -- non number provided.");
    end

    DZData.NameplateDistance = val;
    print("[DayZero] Nameplate Distance set to: ".. val);
    SetCVar("nameplateMaxDistance", DZData.NameplateDistance);
end

local function SetNameplateClassColor(val)
    if not tonumber(val) then
        return print("Error setting class color -- 0 or 1 not provided.");
    end

    if(val == 1) or val == "1" then
        print("[DayZero] |cFF0066FFClass Color Enabled");
        DZData.NameplateColor = 1;
    else    
        print("[DayZero] Class Color Disabled");
        DZData.NameplateColor = 0;
    end
    
    SetCVar("ShowClassColorInFriendlyNameplate", DZData.NameplateColor);
    SetCVar("ShowClassColorInNameplate", DZData.NameplateColor);
    
end

-- Register Slash Commands
SLASH_DAYZERO1 = "/dz";
SLASH_DAYZERO2 = "/dayzero";
SlashCmdList["DAYZERO"] = function(input)

    -- split the input string
    -- format should be i.e.: /dz distance 80

    local cmd = {};
    local pattern = string.format("([^%s]+)", " ");
    string.gsub(input, pattern, function(c) cmd[#cmd + 1] = c end);


    local command = "";
    local value = "";
    for k,v in pairs(cmd) do
        if k == 1 then
            command = v;
        elseif k == 2 then
            value = v;
        else
            return print("Invalid command provided");
        end
    end

    -- check the command and pass the value
    if command == "distance" then
        SetNameplateDistance(value);
    elseif command == "color" then
        SetNameplateClassColor(value);
    elseif command == "help" then
        print("DayZero Help:");
        print("/dz distance <value>");
        print("/dz color <value> (0=disable or 1=enable)");
    end

end

-- Event Register
local dz = CreateFrame("Frame");
dz:RegisterEvent("PLAYER_LOGIN");
dz:RegisterEvent("ADDON_LOADED");

dz:SetScript("OnEvent", function(self, event)

    -- Get action bars to load
    if event == "ADDON_LOADED" then
        if DZData.FirstLogin then 
            SetActionBarToggles(1,1,1,1); -- show all the action bars
            return;
        end
    end

    -- Welcome to game
    if DZData.FirstLogin then
        local name = GetUnitName("player");
        print("Welcome to WoW Classic ".. name .."! Best of Luck out there!");
        DZData.FirstLogin = false;
    end

    -- Run settings on player login
    SetNameplateClassColor(DZData.NameplateColor);
    SetNameplateDistance(DZData.NameplateDistance);

    -- Some non-configurable C-Vars that are easy to change in game
    SetCVar("nameplateShowEnemies", 1); -- show enemy nameplates by default
    SetCVar("instantQuestText", 1); -- set instant quest text

    self:UnregisterEvent("PLAYER_LOGIN");
end);
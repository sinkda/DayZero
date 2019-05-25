# DayZero Addon for WoW Classic

This addon sets up a new character in WoW Classic for their first adventure! Many of the options in here are CVars and as such are not easily altered.

## Addon Options

You can control the addon values as well using the following:
```
/dz distance <value>
/dz color <value>
```

The distance value is the draw distance for nameplates. This goes from 0 - 100.
The color value is friendly and enemy nameplates to have class colors.  0 = disable, 1 = enable.

## Action Bar

I also added on enabling the 4 extra action bars.  This is not currently toggleable via the addon as it can be updated from the interface options window.  This code will only run once for each character you create, but can be removed in the DayZero.lua file.  Locate the following code and remove it:

```lua
-- Get action bars to load
    if event == "ADDON_LOADED" then
        if DZData.FirstLogin then 
            SetActionBarToggles(1,1,1,1); -- show all the action bars
            return;
        end
    end
```

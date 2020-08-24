This script does nothing by itself, but provides a simple API to handle configuration and data files. It is required for all of my modules.

Installation instructions: https://github.com/tes3mp-scripts/Tutorials

# Using it in your scripts

The following is a list of all functions in this module (and their arguments) you are expected to use in your scripts. If you required it in standard way, they will be accessible from the global `DataManager` table.
* `loadConfiguration`
  * `scriptName` name by which you will be requesting your configuration file.
  * `defaultConfig` default values for your config file. Should be a complete and valid config, as it will simply be used if no file is found.
  * `keyOrder` array which defines order in which json keys should be written into the file, exposed from jsonInterface.save method
* `loadData`
  * `scriptName` same as for configuration
  * `defaultData` value used for when the file isn't found.
  * `keyOrder` array which defines order in which json keys should be written into the file jsonInterface.save method
* `saveData`
  * `scriptName`
  * `data` data to write to the file
  * `keyOrder` array which defines order in which json keys should be written into the file jsonInterface.save method

# 0.8 future-proofing

[My branch of CoreScripts](https://github.com/uramer/CoreScripts/tree/0.7.1-async) (likely to be merged for 0.8 release) provides configuration and data storage APIs out of the box.  
If you want your script to function both in 0.7 and 0.8 (possible for most, maybe even all 0.7 scripts), you have two options:
1. Use the new API (recommended)
    * Your script will require `DataManager` for 0.7, but not for 0.8
    * When running 0.7, data will only be saved on server exit, and not periodically
2. Keep using `DataManager`, which will use the new implementation automatically  
    Your script will require `DataManager` both for 0.7 and 0.8
    There are a couple of nuances when running on 0.8:
    * `saveData` does nothing, data will be saved automatically instead
    * just like when using `storage`, if you want it data to be saved at all,
    you must alter the table you received from `loadData`, rather than create a new one when you change it  
    Example:
    ```Lua
      MyScript.data = DataManager.loadData("MyScript", {})
      MyScript.data.players = {} -- ok, will be saved correctly
      MyScript.data = { players = {} } -- not ok, will not be saved
      MyScript.data = tableHelper.deepCopy(MyScript.data) -- not ok either
    ```
    * for servers running Postgres, you must only `loadData` on or after `OnServerInit` event, e.g.:
      ```Lua
        customEventHooks.registerHandler('OnServerInit', function(eventStatus)
          if not eventStatus.validDefaultHandler then return end
          MyScript.data = DataManager.loadData("MyScript", {})
        end)
      ```
    * `keyOrder` argument of `loadData` will be ignored for performance reasons

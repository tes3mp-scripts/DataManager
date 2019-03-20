This module does nothing by itself, but provides a simple API to handle configuration and data files. Is required for all of my moudles.

Has to be `require`d before any of the modules that use it.

Using it in your modules
---
The following is a list of all functions in this module (and their arguments) you are expected to use in your scripts. If you required it in standard way, they will be accessible from the global `DataManager` table.
* `loadConfiguration`
  * `scriptName` name by which you will be requesting your configuration file.
  * `defaultConfig` default values for your config file. Should be a complete and valid config, as it will simply be used if no file is found.
* `loadData`
  * `scriptName` same as for configuration
  * `defaultData` value used for when the file isn't found.
* `saveData`
  * `scriptName`
  * `data` data to write to the file
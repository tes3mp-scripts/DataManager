local DataManager = {}

DataManager.configPrefix = "custom/__config_"
DataManager.dataPrefix = "custom/__data_"

function DataManager.getConfigPath(scriptName)
    return DataManager.configPrefix .. scriptName .. ".json"
end

function DataManager.saveConfiguration(scriptName, config)
    local filePath = DataManager.getConfigPath(scriptName)
    return jsonInterface.save(filePath, config)
end

function DataManager.loadConfiguration(scriptName, defaultConfig)
    local filePath = DataManager.getConfigPath(scriptName)
    local config = jsonInterface.load(filePath)
    if config == nil then
        config = defaultConfig
        DataManager.saveConfiguration(scriptName, config)
    end
    return config
end



function DataManager.getDataPath(scriptName)
    return DataManager.dataPrefix .. scriptName .. ".json"
end

function DataManager.saveData(scriptName, data)
    local filePath = DataManager.getDataPath(scriptName)
    return jsonInterface.save(filePath, data)
end

function DataManager.loadData(scriptName, defaultData)
    local filePath = DataManager.getDataPath(scriptName)
    local data = jsonInterface.load(filePath)
    if data == nil then
        data = defaultData
        DataManager.saveData(scriptName, data)
    end
    return data
end

return DataManager
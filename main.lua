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

function DataManager.checkForNils(t, d)
    for k, v in pairs(d) do
        if t[k] == nil then
            t[k] = v
        else
            if type(d[k]) == "table" then
                if type(t[k]) == "table" then
                    DataManager.checkForNils(t[k], d[k])
                else
                    t[k] = d[k]
                end
            end
        end
    end
    return t
end

function DataManager.loadConfiguration(scriptName, defaultConfig)
    local filePath = DataManager.getConfigPath(scriptName)
    local config = jsonInterface.load(filePath)
    if config == nil then
        config = defaultConfig
    end
    DataManager.saveConfiguration(scriptName, config)
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
    end
    DataManager.saveData(scriptName, data)
    return data
end

return DataManager
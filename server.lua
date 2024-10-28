-- Fonction pour obtenir les fichiers de langue dans le dossier "locales"
function getLangFiles()
    local resourceName = GetCurrentResourceName()
    local path = GetResourcePath(resourceName) .. "/locales/"
    local langs = {}

    for _, file in ipairs(GetDirFiles(path)) do
        if file:sub(-5) == '.json' then
            local data = LoadResourceFile(resourceName, "locales/" .. file)

            if data then
                langs[file:sub(0,-6)] = json.decode(data)
            end
        end
    end

    return langs
end

lib.callback.register('getLangFiles', function(source)
    return getLangFiles()
end)




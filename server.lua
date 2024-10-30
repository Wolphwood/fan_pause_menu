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

function getAnnouncesFile(targetFile)
    local resourceName = GetCurrentResourceName()
    local data = LoadResourceFile(resourceName, targetFile)

    if data then
        return json.decode(data)
    else 
        return {}
    end
end

function fetchAnnouncesData(url)
    local fetchPromise = promise.new()
    PerformHttpRequest(url, function(statusCode, response, headers)
        if statusCode == 200 then
            local data = json.decode(response)
            fetchPromise:resolve(data)
        else
            print("Erreur lors de la récupération des données, code de statut:", statusCode)
            fetchPromise:resolve({})
        end
    end, "GET")

    return Citizen.Await(fetchPromise);
end

lib.callback.register('fan_pause_menu:getLangFiles', function(source)
    return getLangFiles()
end)

lib.callback.register('fan_pause_menu:getAnnounces', function(source)
    local target = config.announces or '/data/announces.json';
    if (target:sub(1,4) == 'http') then
        return fetchAnnouncesData(target)
    else
        return getAnnouncesFile(target)
    end
end)

lib.callback.register('fan_pause_menu:disconnect', function(source)
    return DropPlayer(source, config.goodbye or "Se you later!")
end)

lib.callback.register('fan_pause_menu:getPlayerTotalPlayedTime', function(source)
    local identifier = GetPlayerIdentifierByType(source, 'fivem');
    local url = 'https://lambda.fivem.net/api/ticket/playtimes/'.. config.serverCode ..'?identifiers[]=' .. identifier;

    local fetchPromise = promise.new()
    PerformHttpRequest(url, function(statusCode, response, headers)
        if statusCode == 200 then
            local data = json.decode(response)
            fetchPromise:resolve(data[1].seconds)
        else
            print("Erreur lors de la récupération des données, code de statut:", statusCode)
            fetchPromise:resolve(0)
        end
    end, "GET")

    return Citizen.Await(fetchPromise);
end)


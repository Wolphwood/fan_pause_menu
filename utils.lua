-- Fonction auxiliaire pour lister les fichiers d'un dossier
function GetDirFiles(path)
    local files = {}
    for file in io.popen(isLinux() and ('ls -a "' .. path ..'"') or ('dir /b "' .. path .. '"') ):lines() do
        if file ~= "." and file ~= ".." then
            table.insert(files, file)
        end
    end
    return files
end

function isLinux()
    return os.getenv("HOME") ~= nil
end

function isWindows()
    return os.getenv("HOMEDRIVE") ~= nil
end
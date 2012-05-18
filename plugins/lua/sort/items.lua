local _ENV = mkmodule('plugins.sort.items')

local utils = require('utils')

orders = orders or {}

-- Relies on NULL being auto-translated to NULL, and then sorted
orders.exists = {
    key = function(item)
        return 1
    end
}

orders.type = {
    key = function(item)
        return item:getType()
    end
}

orders.description = {
    key = function(item)
        return dfhack.with_temp_object(
            df.new "string",
            function(str,item)
                item:getItemDescription(str,0)
                return str.value
            end,
            item
        )
    end
}

orders.quality = {
    key = function(item)
        return item:getQuality()
    end
}

orders.improvement = {
    key = function(item)
        return item:getImprovementQuality()
    end
}

orders.wear = {
    key = function(item)
        return item:getWear()
    end
}

orders.material = {
    key = function(item)
        local mattype = item:getActualMaterial()
        local matindex = item:getActualMaterialIndex()
        local info = dfhack.matinfo.decode(mattype, matindex)
        if info then
            return info:toString()
        end
    end
}

return _ENV
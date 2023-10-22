local U = {}

function U.removeDuplicates(list)
    local newList = {}
    local seen = {}  -- Temporary table to keep track of seen elements
    
    for _, element in ipairs(list) do
        if not seen[element] then  -- If element is not seen, add it to newList
            table.insert(newList, element)
            seen[element] = true  -- Mark the element as seen
        end
    end


    return newList
end

function U.normalize(tbl)
    local z = tbl[1] 
    local newTable = {}

    for i = 1, #tbl, 1 do
        local e = tbl[i] - z + 1
        if e <= 0 then e = e+12 end

        table.insert(newTable, e)        
    end
    return newTable
end

function U.moveFirstToLast(tbl, elementsToRemove)
    local firstElement = table.remove(tbl, 1)
    table.insert(tbl, firstElement)

    return tbl
end


return U


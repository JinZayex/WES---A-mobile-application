
local T = {}
local CHORD_TYPES = {}

CHORD_TYPES["1,5,8"]      = " "
CHORD_TYPES["1,4,8"]        = "m"                   --#01: m*
CHORD_TYPES["1,6,9"]        = "dim"
CHORD_TYPES["1,6,8"]        = "sus4"
CHORD_TYPES["1,6,8,11"]     = "7sus4"
CHORD_TYPES["1,5,8,0"]      = "M7"
CHORD_TYPES["1,4,8,0"]      = "mMa7"
CHORD_TYPES["1,4,8,11"]     = "m7**"
CHORD_TYPES["1,5,8,11"]     = "m7**"
CHORD_TYPES["1,6,9,2"]      = "dim7"
CHORD_TYPES["1,5,9,0"]      = "--#5Maj7"
CHORD_TYPES["1,5,9,11"]     = "--#57"
CHORD_TYPES["1,5,9"]        = "--#5"
CHORD_TYPES["1,6,9,11"]     = "m7b5"
CHORD_TYPES["1,5,7,11"]     = "M7b5"

CHORD_TYPES["1,3,5,8"]        = "add9*"
CHORD_TYPES["1,3,5,8,11"]    = "Maj7(9)"
CHORD_TYPES["1,3,5,8,10"]    = "7(9)"
CHORD_TYPES["1,4,8,3"]       = "add9*"
CHORD_TYPES["1,3,4,8,11"]    = "m9(Maj7)"
CHORD_TYPES["1,3,4,8,10"]    = "m7(9)"

CHORD_TYPES["1,5,7,8,11"]    = "Maj7(--#11)"
CHORD_TYPES["1,3,5,7,8,11"]  = "Maj9(--#11)"
CHORD_TYPES["1,5,7,8,10"]    = "7(--#11)"
CHORD_TYPES["1,3,5,7,8,10"]  = "9(--#11)"
CHORD_TYPES["1,5,8,10"]      = "7(13)"
CHORD_TYPES["1,3,5,8,10"]    = "9(13)"
CHORD_TYPES["1,2,5,8,11"]    = "7(b9)"
CHORD_TYPES["1,5,8,9,10"]    = "7(b13)"
CHORD_TYPES["1,2,5,8,9,10"]  = "7(b13b9)"
CHORD_TYPES["1,2,5,6,8,9,11"] = "7(b13b911)"
CHORD_TYPES["1,4,5,8,10"]    = "7(--#9)"
CHORD_TYPES["1,4,6,8,10"]    = "m7(11)"
CHORD_TYPES["1,3,4,6,8,10"]  = "m9(11)"
CHORD_TYPES["1,1,1"] = ""                           --Dummy

function T.ChordType(tonica, list)
    -- Transform the list into a comma-separated string
    local myKey = table.concat(list, ",")
    
    -- Now, use myKey as the key to access CHORD_TYPES
    local chordType = CHORD_TYPES[myKey]
    if chordType then
        --print("Your chord type is ---->", tonica, chordType)
        return chordType
    end

end


return T

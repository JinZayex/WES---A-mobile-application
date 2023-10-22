local A = {}
local utils = require("utils")
local TYPO = require("CHORD_TYPO")

local notesDiesis = {"A", "A#", "B", "C", "C#","D", "D#","E", "F", "F#", "G", "G#",}
local notesBemolle = {"A", "Bb", "B", "C", "Db","D", "Eb","E", "F", "Gb", "G", "Ab",}


function A.CurrentChord(ChordList)
    local n = #ChordList
end

function A.CurrentNotes(CurrentStringFret)
    --print("notes", CurrentStringFret)
    local cordaName;
    local corda;
    local NumericNotes = {}
    

    local CurrentNOTES = {}
    CurrentNOTES["e"] = nil
    CurrentNOTES["B"] = nil
    CurrentNOTES["G"] = nil
    CurrentNOTES["D"] = nil
    CurrentNOTES["A"] = nil
    CurrentNOTES["E"] = nil

    --print("EFGH",CurrentStringFret["0"],CurrentStringFret["1"],CurrentStringFret["2"],CurrentStringFret["3"],CurrentStringFret["4"],CurrentStringFret["5"])

    for key, value in pairs(CurrentStringFret) do

        if key == "0" then          corda = 8   cordaName = "e"
        elseif key == "1" then      corda = 3;  cordaName = "B"
        elseif key == "2" then      corda = 11; cordaName = "G"

        elseif key == "3" then      corda = 6;  cordaName = "D"
        elseif key == "4" then      corda = 1;  cordaName = "A"
        elseif key == "5" then      corda = 8;  cordaName = "E"
        else        print("errore bro")     end

        local notaNumero = (value+corda)%12 
        if (notaNumero == 0) then notaNumero = 12 end

        local notaName = notesDiesis[notaNumero];

        table.insert(NumericNotes, notaNumero)

        -----------------------------------------------------
        CurrentNOTES[cordaName] = notaName

    end 

    --print("Current NOTES", CurrentNOTES["E"],CurrentNOTES["A"],CurrentNOTES["D"],CurrentNOTES["G"],CurrentNOTES["B"],CurrentNOTES["e"])
    
    local NumericNotes = utils.removeDuplicates(NumericNotes)
    table.sort(NumericNotes)

    return CurrentNOTES, NumericNotes
end


function A.ChordAnalyser(NumericNOTES)
    -- NumericNOTES possiede n elementi (n note)
    local n = #NumericNOTES
    --print("my n", n)

    -- Dunque possiamo avere n possibili accordi

    -- Creiamo il dizionario PossibleChord_Numb
    -- Chiave: Nome della fondamentale dell'accordo
    -- Valore: Lista di numeri che indicano i rapporti fra le note
    -- Es.  {X:[0,4,7], ... }  Abbiamo l'accordo di X, 
                            -- La lista indica: La nota X (0, la fondamentale) la nota che si trova 4 semitoni dopo (la 4a maggiore) e la nota che si trova 7 semitoni dopo (la 5a giusta)
    -- Dunque X:[0,4,7] è l'accordo di X maggiore
    
    local PossibleChord_Numb = {}
    local lista = NumericNOTES
    for i=1, n, 1 do
        if i == 1 then
            lista = NumericNOTES
        else
            lista = utils.moveFirstToLast(lista,1)
        end

        local key_numeric = lista[1]
        local key = notesDiesis[key_numeric]

        local normList = utils.normalize(lista)
        PossibleChord_Numb[key] = normList
    end    



    
    local PossibleChord = {}
    for tonica, value in pairs(PossibleChord_Numb) do
        local chordType = TYPO.ChordType(tonica, value)
        if chordType ~= nil then
            local chordName = tonica .. chordType
            table.insert(PossibleChord, chordName)
        end
     end





     return PossibleChord
end



return A


-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-------------------------------
------------ MENU  ------------
------------       ------------
local render = require("render")
local option = require("option")
local analysis = require("analysis")


local WIDTH = display.actualContentWidth;
local HEIGHT = display.actualContentHeight;

local menuHeight = HEIGHT/10

print(WIDTH, HEIGHT)

local closeMenu = false;
local backgroundColor;
local background;


backgroundColor = display.setDefault("background", 230/255, 170/255, 100/255)
backgroundMargherita = display.newImageRect("Margherita.png", 300, 300)
backgroundMargherita.x = display.contentCenterX
backgroundMargherita.y = display.contentCenterY

local CurrentStringFret = {}
CurrentStringFret["0"] = nil
CurrentStringFret["1"] = nil
CurrentStringFret["2"] = nil
CurrentStringFret["3"] = nil
CurrentStringFret["4"] = nil
CurrentStringFret["5"] = nil

--indice dell'accordo trovato
local c_showed = 1

local function getCoordinates(event, CORNER_X, CORNER_Y, rectDistX, rectDistY, rectWidth, rectHeight)
    -- Input: Click dell'utente
    -- Output: Coordinate X, Y del punto fret-string

    if event.phase == "ended" then
        local X = math.ceil( (event.x - CORNER_X) / (rectWidth+ rectDistX))      -- Da -0 a 12
        local Y = math.floor(    (event.y - CORNER_Y) / (rectHeight/6) ) -- Da 0 a 5

        if (X < 13) and (-1 < Y) and (Y < 6) then
            return X, Y
        end
    end
end



local function textTouch(event)
    local target = event.target

    if event.phase == "ended" then
        print("Clicked on:", target.text)
    end
    return true  -- To stop the event from propagating to other objects
end


local function gameLoop(event)
    if event.phase == "began" then
        print("Loop started!")
        backgroundMargherita:removeSelf() -- Remove the image
        local myText_1, myText_2, myText_3, myText_4 = render.Menu(display, menuHeight, WIDTH, native)
		
		myText_1:addEventListener("touch", textTouch)
		myText_2:addEventListener("touch", textTouch)
		myText_3:addEventListener("touch", textTouch)
		myText_4:addEventListener("touch", textTouch)
		

        local CORNER_X, CORNER_Y, rectWidth, rectDistX, rectHeight = render.Rects(display, WIDTH, menuHeight)
		local rectDistY = render.Strings(display, CORNER_X, CORNER_Y, rectWidth, rectDistX, rectHeight)
        
        local triangleRight, triangleLeft = render.AnalysisBox(display, CORNER_X, CORNER_Y, rectWidth, rectDistX, rectHeight, menuHeight, nil)

        local clickedOnTriangle = false
        triangleRight:addEventListener("touch", function(event)
            if event.phase == "ended" then
                clickedOnTriangle = true
                c_showed = c_showed+1
                print("--> c_showed",c_showed)
            end
        end)
        triangleLeft:addEventListener("touch", function(event)
            if event.phase == "ended" then
                clickedOnTriangle = true
                c_showed = c_showed-1
                print("--> c_showed",c_showed)
            end
        end)

        display.getCurrentStage():addEventListener("touch", function(event)
            if event.phase == "ended" then
                local X, Y = getCoordinates(event, CORNER_X, CORNER_Y, rectDistX, rectDistY, rectWidth, rectHeight)

                if (clickedOnTriangle) then
                    --Resetto 
                else
                    c_showed = 1
                end
                clickedOnTriangle = false


                --Setta i valori di current string fret
                local currentX = CurrentStringFret[tostring(Y)]
                if (currentX == X) then
                    CurrentStringFret[tostring(Y)] = nil
                else
                    CurrentStringFret[tostring(Y)] = X
                end
                --------------
                -- CurrentNOTES     -- Dizionario:
                --      Chiavi -->  E, A, D, G, B, e    (Corda)
                --      Valore -->  Nota sulla corda corrispondente  (Scrittura alfabetica)
                --------------
                -- NumericNOTES     -- Lista:
                --      Valori ---> Numerici (corrispondenti alle note correnti)
                --                  I numeri hanno i seguenti valori--> A=1, A#=2, B=3  ... G#=12
                local CurrentNOTES, NumericNOTES = analysis.CurrentNotes(CurrentStringFret)

                --print("NumericNOTES -->", table.concat(NumericNOTES,", "))
                local PossibleChords = analysis.ChordAnalyser(NumericNOTES)
                for i=1, #PossibleChords, 1 do
                    print("Chord founded",PossibleChords[i])
                end

                -- Ridisegno rects e strings per coprire i disegni precedenti
                render.Rects(display, WIDTH, menuHeight)
                render.Strings(display, CORNER_X, CORNER_Y, rectWidth, rectDistX, rectHeight)
                -- Inserisci qui il numero di chord selezionato
                render.AnalysisBox(display, CORNER_X, CORNER_Y, rectWidth, rectDistX, rectHeight, menuHeight, PossibleChords[c_showed])
                
                triangleRight:addEventListener("touch", function(event)
                    if event.phase == "up" then 
                        c_showed = c_showed+1; print("--> c_showed",c_showed) end
                end)
                triangleLeft:addEventListener("touch", function(event)
                    if event.phase == "up" then 
                        c_showed = c_showed+1; print("--> c_showed",c_showed) end
                end)

                -- Ridisegna i 6 cerchi 
                local cordaName = {"e", "B", "G", "D", "A", "E" }
                for index, value in pairs(CurrentStringFret) do
                    --print("Hai appena cliccato su ------------->")
                    --print("Corda:", tonumber(index), "Tasto:", value, "Nota corrente")

                    local Y = tonumber(index)
                    local X = value

                    local corda = cordaName[tonumber(index)+1]
                    local nota = CurrentNOTES[corda]
                    --print("X e Y ",X, Y, "Corda e nota ", corda, nota)
                    render.Circle(display, X, Y, CORNER_X, CORNER_Y, rectDistX, rectDistY, rectWidth, rectHeight, nota)  
                end

            end
        end)


    end
    
end

-- Add a click event listener to the button
backgroundMargherita:addEventListener("touch", gameLoop)


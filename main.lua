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
background = display.newImageRect("Margherita.png", 300, 300)
background.x = display.contentCenterX
background.y = display.contentCenterY

local CurrentStringFret = {}
CurrentStringFret["0"] = nil
CurrentStringFret["1"] = nil
CurrentStringFret["2"] = nil
CurrentStringFret["3"] = nil
CurrentStringFret["4"] = nil
CurrentStringFret["5"] = nil


local function getCoordinates(event, CORNER_X, CORNER_Y, rectDistX, rectDistY, rectWidth, rectHeight)
    -- Input: Click dell'utente
    -- Output: Coordinate X, Y del punto fret-string

    if event.phase == "ended" then
        local X = math.ceil( event.x / (rectWidth+ rectDistX))      -- Da -0 a 12
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
        background:removeSelf() -- Remove the image
        local myText_1, myText_2, myText_3, myText_4 = render.Menu(display, menuHeight, WIDTH, native)
		
		myText_1:addEventListener("touch", textTouch)
		myText_2:addEventListener("touch", textTouch)
		myText_3:addEventListener("touch", textTouch)
		myText_4:addEventListener("touch", textTouch)
		

        local CORNER_X, CORNER_Y, rectWidth, rectDistX, rectHeight = render.Rects(display, WIDTH, menuHeight)
		local rectDistY = render.Strings(display, CORNER_X, CORNER_Y, rectWidth, rectDistX, rectHeight)
        
        display.getCurrentStage():addEventListener("touch", function(event)
            local X, Y = getCoordinates(event, CORNER_X, CORNER_Y, rectDistX, rectDistY, rectWidth, rectHeight)
            
            --print("You clicked", X, Y)
            -- Cambia il valore del tasto cliccato sulla data corda

            
            local currentX = CurrentStringFret[tostring(Y)]
            if (currentX == X) then
                CurrentStringFret[tostring(Y)] = nil
            else
                CurrentStringFret[tostring(Y)] = X
            end


            print("CurrentStringFret", CurrentStringFret["0"],CurrentStringFret["1"],CurrentStringFret["2"], CurrentStringFret["3"],CurrentStringFret["4"],CurrentStringFret["5"])
            

            -- Ridisegno rects e strings per coprire i disegni precedenti
            render.Rects(display, WIDTH, menuHeight)
            render.Strings(display, CORNER_X, CORNER_Y, rectWidth, rectDistX, rectHeight)
            render.AnalysisBox(display, CORNER_X, CORNER_Y, rectWidth, rectDistX, rectHeight, menuHeight)

            -- Ridisegna i 6 cerchi
            for index, value in pairs(CurrentStringFret) do
                print("Indice:", tonumber(index), "Valore:", value)
                local Y = tonumber(index)
                local X = value
                render.Circle(display, X, Y, CORNER_X, CORNER_Y, rectDistX, rectDistY, rectWidth, rectHeight)  
            end

            local CurrentNotes = analysis.NotesRetriever(CurrentStringFret)
            print("CurrentNotes in main",CurrentNotes["E"],CurrentNotes["A"],CurrentNotes["D"],CurrentNotes["G"],CurrentNotes["B"],CurrentNotes["e"])


        end)
    end
    
end

-- Add a click event listener to the button
background:addEventListener("touch", gameLoop)


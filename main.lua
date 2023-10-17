-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-------------------------------
------------ MENU  ------------
------------       ------------
local render = require("render")

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
    if event.phase == "ended" then
        --print("You clicked at X:", event.x, "Y:", event.y)
        local X = math.ceil( event.x / (rectWidth+ rectDistX))      -- Da -0 a 12
        local Y = math.floor(    (event.y - CORNER_Y) / (rectHeight/6) ) -- Da 0 a 5

        if (X < 13) and (-1 < Y) and (Y < 6) then

            print("(Inside function) Coord X e Y: ", X, Y) 
            return X, Y
        end
    end
end



local function textTouch(event)
    local target = event.target

    if event.phase == "ended" then
        -- Print the content of the text
        print("Clicked on:", target.text)
        -- You can add additional handling code here if needed
    end
    return true  -- To stop the event from propagating to other objects
end


local function gameLoop(event)
    if event.phase == "began" then
        print("Button Clicked! Loop started!")
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
            
            if ((X ~= nil) and (Y ~= nil)) then
                --print("You clicked", X, Y)
                CurrentStringFret[tostring(Y)] = X  -- Cambia il valore del tasto cliccato sulla data corda
                print("CurrentStringFret", CurrentStringFret["0"],CurrentStringFret["1"],CurrentStringFret["2"], CurrentStringFret["3"],CurrentStringFret["4"],CurrentStringFret["5"])
                
                for index, value in pairs(CurrentStringFret) do
                    print("Indice:", tonumber(index), "Valore:", value)
                    

                end
                render.Circle(display, X, Y, CORNER_X, CORNER_Y, rectDistX, rectDistY, rectWidth, rectHeight) 
            end
        end)
    end
end

-- Add a click event listener to the button
background:addEventListener("touch", gameLoop)


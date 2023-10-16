---@diagnostic disable: undefined-global
-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-------------------------------
------------ MENU  ------------
------------       ------------
local WIDTH = display.actualContentWidth;
local HEIGHT = display.actualContentHeight;

local menuHeight = HEIGHT/10

print(WIDTH, HEIGHT)

local closeMenu = false;
local backgroundColor;
local background;

backgroundColor = display.setDefault("background", 209/255, 205/255, 191/255)
background = display.newImageRect("Margherita.png", 300, 300)
background.x = display.contentCenterX
background.y = display.contentCenterY

local function renderMenu()
    local textDistancing = 10

    local menuBox = display.newRect(display.contentCenterX, menuHeight / 2, WIDTH, menuHeight)
    
    local myText_1 = display.newText("Strumming", 0, menuBox.height / 2 , native.systemFont, 16 )
    myText_1.x = menuBox.x - menuBox.width / 2 + myText_1.width/2   +textDistancing
    
    local myText_2 = display.newText("Arpeggio", 0, menuBox.height / 2 , native.systemFont, 16 )
    myText_2.x =  myText_1.x + myText_1.width / 2 + myText_2.width / 2 + textDistancing
    
    local myText_3 = display.newText("Save", 0, menuBox.height / 2 , native.systemFont, 16 )
    myText_3.x = myText_2.x + myText_2.width / 2 + myText_3.width / 2 + textDistancing
	
    local myText_4 = display.newText("Clear", 0, menuBox.height / 2 , native.systemFont, 16 )
    myText_4.x = myText_3.x + myText_3.width / 2 + myText_4.width / 2 + textDistancing

    menuBox:setFillColor( 0, 0, 0 ) -- Set the fill color to red
    myText_1:setFillColor( 1, 1, 1 )
    myText_2:setFillColor( 1, 1, 1 )
    myText_3:setFillColor( 1, 1, 1 )
	myText_4:setFillColor( 1, 1, 1 )
	
	return myText_1, myText_2, myText_3, myText_4
end

local function renderRects()
    --Distanza su asse x fra rettangoli
	local rectDist = 10
	
	-- Caratteristiche rettangoli (x,y,width,height, raggio degli angoli)
	local x_rect = nil
	local y_rect = display.contentCenterY+menuHeight/2
    local rectWidth = (WIDTH/14) -rectDist
	local rectHeight = 150
	local cornerRadius = 10  -- Adjust the corner radius as needed
	
	
	-- Guida (settata in trasparente)
    local guide1 = display.newRect(display.contentCenterX, y_rect, (WIDTH/14)*12, rectHeight)
    guide1:setFillColor( 0, 0, 1 ) -- Set the fill color to red
	
	--Loop per la creazione dei rettangoli
	for x_rect=0, 12*(rectWidth+rectDist), rectWidth+rectDist
	do 
		local rect = display.newRoundedRect((guide1.x - guide1.width/2)+x_rect, y_rect, rectWidth, rectHeight, cornerRadius)
		rect:setFillColor( 0, 0, 0)
	end
	
	return rectHeight
end

local function renderStrings(rectHeight)
	
	local stringWeight = 6
	local stringDist = (rectHeight - stringWeight)/ 7
	
	
	local line = display.newLine(50, 200, 250, 200)
	line:setStrokeColor( 0.8, 0.8, 0.8)  -- Set the stroke color to red
	line.strokeWidth = stringWeight  -- Set the stroke width
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
        myText_1, myText_2, myText_3, myText_4 = renderMenu()
		
		myText_1:addEventListener("touch", textTouch)
		myText_2:addEventListener("touch", textTouch)
		myText_3:addEventListener("touch", textTouch)
		myText_4:addEventListener("touch", textTouch)
		
        rectHeight = renderRects()
		renderStrings(rectHeight)
		
    end
end

-- Add a click event listener to the button
background:addEventListener("touch", gameLoop)
--myText_1:addEventListener("touch", textTouch)















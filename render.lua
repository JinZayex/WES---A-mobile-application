local R ={}

function R.Menu(display, menuHeight, WIDTH, native)
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


function R.Rects(display, WIDTH, menuHeight)
    --Distanza su asse x fra rettangoli
	local rectDistX = 10
	
	-- Caratteristiche rettangoli (x,y,width,height, raggio degli angoli)
	local x_rect = nil
	local y_rect = display.contentCenterY+menuHeight/2
    local rectWidth = (WIDTH/14) -rectDistX
	local rectHeight = 150
	local cornerRadius = 10  -- Adjust the corner radius as needed
	
	-- Guida (settata in trasparente)
    local guide1 = display.newRect(display.contentCenterX + rectWidth/2, y_rect, (WIDTH/14)*12, rectHeight)
    guide1:setFillColor( 0, 0, 1,0) -- Set the fill color to red
	
	--Loop per la creazione dei rettangoli
	for x_rect=1, 12*(rectWidth+rectDistX), rectWidth+rectDistX
	do 
		local rect = display.newRoundedRect((guide1.x - guide1.width/2)+x_rect , y_rect, rectWidth, rectHeight, cornerRadius)
		rect:setFillColor( 0, 0, 0)
	end

    -- Rettangolo della corda vuota (Non dovrebbe vedersi e il colore è settato UGUALE a quello dello sfondo)
    local rect_empty = display.newRoundedRect((guide1.x - guide1.width/2) - rectWidth - rectDistX, y_rect, rectWidth, rectHeight, cornerRadius)
    rect_empty:setFillColor( 230/255, 170/255, 100/255, 1)


    local CORNER_X = guide1.x - guide1.width/2 - rectWidth/2
    local CORNER_Y = y_rect - rectHeight/2 

    return CORNER_X, CORNER_Y, rectWidth, rectDistX, rectHeight
end


function R.Strings(display, CORNER_X, CORNER_Y, rectWidth, rectDistX, rectHeight)
	local stringWeight = 4
    local stringLength = 13*(rectWidth+rectDistX)
    local rectDistY = (rectHeight+stringWeight)/ 7
	
    for y=0, rectHeight-rectDistY, rectDistY
    do
        local line = display.newLine(CORNER_X, CORNER_Y+rectDistY  +y, CORNER_X+stringLength, CORNER_Y+rectDistY   +y)
        line:setStrokeColor(0.8, 0.8, 0.8)
        line.strokeWidth = stringWeight   

        if (y > 2*rectDistY) then
            line:setStrokeColor(0.7, 0.7, 0.7)
            line.strokeWidth = stringWeight + 2
        end
    end
    
    return rectDistY

end

function R.Circle(display, X, Y, CORNER_X, CORNER_Y, rectDistX, rectDistY, rectWidth, rectHeight, nota) 
    local centerX = CORNER_X - rectWidth/2    + (X)*rectWidth + (X-1)*rectDistX
    local centerY = CORNER_Y + rectDistY      + (Y)*rectDistY
    local radius = 10 -- Sostituisci con il raggio desiderato

    local cerchio = display.newCircle(centerX, centerY, radius)

    cerchio:setFillColor(1, 0, 0) -- Rosso

    -- Create a text object for the letter "A"
    local notaText = display.newText(tostring(nota), cerchio.x, cerchio.y, native.systemFont, 14)
    notaText:setFillColor(1,1,1) -- White

    
end 

function R.AnalysisBox(display, CORNER_X, CORNER_Y, rectWidth, rectDistX, rectHeight, menuHeight, myChord) 

    local rectBox = display.newRoundedRect(CORNER_X + 12*(rectWidth+rectDistX), 0, rectWidth*2, 50, 10)
    rectBox.y = menuHeight+  (CORNER_Y - menuHeight)/2

    --local rect = display.newRoundedRect(CORNER_X+(rectWidth+rectDistX) , CORNER_Y, rectWidth, rectHeight, cornerRadius)
    rectBox:setFillColor(0, 0, 0) -- Rosso  

    local font_size = 16

    if (myChord==nil) then
        myChord = "No chord\ndetected" 
        font_size = 12
    end
    local chordText = display.newText(tostring(myChord), rectBox.x, rectBox.y, native.systemFont, font_size)
    chordText:setFillColor(1,1,1) -- White

    


    local hypotenuse = 30
    local longness = 8
    local verticesRight = { 0, hypotenuse, longness, hypotenuse/2,  0,0 }
    local verticesLeft = { 0, hypotenuse, -longness, hypotenuse/2,  0,0 }

    local triangleRight_X = rectBox.x + (rectBox.width/2 + longness/2   +1)
    local triangleLeft_X = rectBox.x  - (rectBox.width/2 + longness/2   +1)
    local triangle_Y = menuHeight + CORNER_Y

    local triangleRight = display.newPolygon( triangleRight_X, triangle_Y * 0.5, verticesRight)
    local triangleLeft = display.newPolygon( triangleLeft_X, triangle_Y * 0.5, verticesLeft)

    triangleRight:setFillColor(1,0,0) -- White
    triangleLeft:setFillColor(0.9,0,0) -- White

    return triangleRight, triangleLeft
end 



return R

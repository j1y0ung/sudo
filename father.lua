-----------------------------------------------------------------------------------------
--
-- father.lua: 아빠 문자화면
--
-----------------------------------------------------------------------------------------
local composer = require( "composer" )
local scene = composer.newScene()
local widget = require( "widget" )
local font = "font/KM.ttf"

-- 단서노트 클릭
local function gotoCluenote()
    print("단서노트 클릭")
    composer.removeScene("father")
    composer.gotoScene("clueNote")
end

-- 홈버튼 클릭
local function gotoHome()
    print("홈버튼 클릭")
    composer.removeScene("father")
    composer.gotoScene("game_main")
end

-- 뒤로가기 버튼 클릭
local function gotoBack()
    print("뒤로가기 버튼 클릭")
    composer.removeScene("father")
    composer.gotoScene("message_main")
end

function scene:create( event )
	local sceneGroup = self.view

	local background = display.newRect( display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight )
	background:setFillColor( 0.8 )	-- white

	local function scrollListener( event )
 
    local phase = event.phase
    if ( phase == "began" ) then print( "Scroll view was touched" )
    elseif ( phase == "moved" ) then print( "Scroll view was moved" )
    elseif ( phase == "ended" ) then print( "Scroll view was released" )
    end
 
    -- In the event a scroll limit is reached...
    if ( event.limitReached ) then
        if ( event.direction == "up" ) then print( "Reached bottom limit" )
        elseif ( event.direction == "down" ) then print( "Reached top limit" )
        elseif ( event.direction == "left" ) then print( "Reached right limit" )
        elseif ( event.direction == "right" ) then print( "Reached left limit" )
        end
    end
 
    return true
end

local scrollView = widget.newScrollView(
    {
        top = 200,
        left = 10,
        width = 2000,
        height = 1000,
        scrollWidth = 10,
        scrollHeight = 10,
        horizontalScrollDisabled = true,
        hideBackground = true,
        listener = scrollListener,
        scrollBarOptions = {
            sheet = scrollBarSheet,
            topFrame = 1,
            middleFrame = 2,
            bottomFrame = 3
        }
    }
)

 	--문자내용
 	local text1 = display.newImageRect("text/f.png",750, 6500)
	text1.x, text1.y = 370, 3250
	scrollView:insert( text1 )
	--기본
	local person = display.newImageRect("001-user.png", 80, 80)
	person.x, person.y = 350, 125

	local name = display.newText("아버지", 350, 177, font, 35)
    name:setFillColor( 0 )

    local line_b = display.newRect( 600, 200, 1400, 10 )
	line_b:setFillColor( 0 )   

	local function tapListener( event )
    	local object = event.target

    	if ( event.phase == "began" ) then
        	display.getCurrentStage():setFocus( object )
    	elseif ( event.phase == "ended" or event.phase == "cancelled" ) then
        	display.getCurrentStage():setFocus( nil )
    	end

    	print( object.name .. " TAP" )
	end
 
	-- Touch listener function
	local function touchListener( event )
    	local object = event.target

    	if ( event.phase == "began" ) then
        	display.getCurrentStage():setFocus( object )
    	elseif ( event.phase == "ended" or event.phase == "cancelled" ) then
        	display.getCurrentStage():setFocus( nil )
    	end

    	print( object.name .. " TOUCH (" .. event.phase .. ")" )
	end
 
	scrollView:addEventListener( "touch", touchListener )
	scrollView:addEventListener( "tap", function() return true; end )

	--------------------------------------------------------------------------------------------

	-- 하단바(단서노트, 홈버튼, 뒤로가기)
	local bottombar = display.newRect(display.contentCenterX, 1220, display.contentWidth, 120)
	bottombar:setFillColor( 0 )

	-- 단서노트
	local noteBtn = widget.newButton(
		{
			id = "notebtn",
			left = 110,
			top = 1170,
			width = 100,
			height = 100,
			defaultFile = "imgsources/clueNote.png",
			onRelease = gotoCluenote
		}
	)

	-- 홈버튼
	local homeBtn = widget.newButton(
		{
			id = "homebtn",
			left = 325,
			top = 1180,
			width = 80,
			height = 80,
			defaultFile = "imgsources/w_home.png",
			onRelease = gotoHome
		}
	)

	-- 뒤로가기
	local backBtn = widget.newButton(
		{
			id = "backbtn",
			left = 540,
			top = 1180,
			width = 80,
			height = 80,
			defaultFile = "imgsources/w_back.png",
			onRelease = gotoBack
		}
	)

    sceneGroup:insert(background)
    sceneGroup:insert(scrollView)
    sceneGroup:insert(person)
    sceneGroup:insert(name)
    sceneGroup:insert(line_b)
    sceneGroup:insert(bottombar)
    sceneGroup:insert(noteBtn)
    sceneGroup:insert(homeBtn)
    sceneGroup:insert(backBtn)
end

function scene:show( event )
end

function scene:hide( event )
--    local sceneGroup = self.view
--	local phase = event.phase
--	local parent = event.parent  -- Reference to the parent scene object
 
--	if ( phase == "will" ) then
        -- Call the "resumeGame()" function in the parent scene
  --      parent:resumeGame()
   -- end
end

function scene:destroy( event )
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene

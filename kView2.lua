-----------------------------------------------------------------------------------------
--
-- kView2.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local widget = require("widget")
local scene = composer.newScene()
local font = "font/KM.ttf"

-- 단서노트 클릭
local function gotoCluenote()
    print("단서노트 클릭")
    composer.removeScene("kView2")
    composer.gotoScene("clueNote")
end

-- 홈버튼 클릭
local function gotoHome()
    print("홈버튼 클릭")
    composer.removeScene("kView2")
    composer.gotoScene("game_main")
end

-- 뒤로가기 버튼 클릭
local function gotoBack()
    print("뒤로가기 버튼 클릭")
    composer.removeScene("kView2")
    composer.gotoScene("game_main")
end

function scene:create( event )
	local sceneGroup = self.view
	
	local background = display.newRect( display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight )
	background:setFillColor( 1 )	-- white

	local title = display.newText("친구목록", 150, 125, native.systemFont, 75 )
	title:setFillColor( 0, 0, 0)

	local bottomBar = display.newRect(display.contentCenterX, display.contentCenterY + 485, display.contentWidth, 150)
	bottomBar:setFillColor(0.8, 0.8, 0.8)

	-- Function to handle button e
	-- Create the widgetvents
	local function handleButtonEvent(event)
		composer.gotoScene( "kView1" )		
	end

	--icon 
	local man = display.newImageRect("images/man_full.png", 120, 120)
	man.x = 250
	man.y = bottomBar.y - 17

	local bubbleButton = widget.newButton(
		{
			width = man.width-10,
			height = man.height-10,
			defaultFile = "images/speechbubble_blank.png",
			overFile = "images/speechbubble_full.png",
			onPress = handleButtonEvent
		}
	)
	bubbleButton.x = 500
	bubbleButton.y = bottomBar.y - 17

	-- user profile
	--local profile = display.newImageRect("images/profile.png", 160, 80)
	--profile.x = display.contentCenterX/1.7
	--profile.y = display.contentCenterY/2.2

	-- 구분선
	--local line1 = display.newLine(5, display.contentCenterY/1.5, display.contentWidth-5, display.contentCenterY/1.5)
	--line1:setStrokeColor(0.7, 0.7, 0.7)

	-- 친구목록 
	-- ScrollView listener

	-- ScrollView listener
	local function scrollListener( event )
	 
	    local phase = event.phase
	    if ( phase == "began" ) then print( "Scroll view was touched" )
	    elseif ( phase == "moved" ) then print( "Scroll view was moved" )
	    elseif ( phase == "ended" ) then print( "Scroll view was released" )
	    end
	 
	    return true
	end

	-- Create the widget
	local scrollView = widget.newScrollView(
		{
			top = 200,
			left = 10,
			width = display.contentWidth,
			height = 850,
			isBounceEnabled = false,
			listener = scrollListener
		}
	)
 
	-- Create a image and insert it into the scroll view
	local chatting = display.newImageRect("images/frList_2.png", display.contentWidth, 900)
	chatting.x = display.contentCenterX
	chatting.y = 460

	scrollView:insert( chatting )

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

	sceneGroup:insert( background )
	sceneGroup:insert( title )
	sceneGroup:insert( bottomBar )
	sceneGroup:insert( man )
	sceneGroup:insert( bubbleButton )
	sceneGroup:insert( scrollView )
	--sceneGroup:insert( profile )
	--sceneGroup:insert( line1 )
	sceneGroup:insert( bottombar )
	sceneGroup:insert( noteBtn )
	sceneGroup:insert( homeBtn )
	sceneGroup:insert( backBtn )
end

function scene:show( event )
end

function scene:hide( event )
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

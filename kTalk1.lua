-----------------------------------------------------------------------------------------
--
-- kTalk1.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local widget = require("widget")
local scene = composer.newScene()
local font = "font/KM.ttf"

-- 단서노트 클릭
local function gotoCluenote()
    print("단서노트 클릭")
    composer.removeScene("kTalk1")
    composer.gotoScene("clueNote")
end

-- 홈버튼 클릭
local function gotoHome()
    print("홈버튼 클릭")
    composer.removeScene("kTalk1")
    composer.gotoScene("game_main")
end

-- 뒤로가기 버튼 클릭
local function gotoBack()
    print("뒤로가기 버튼 클릭")
    composer.removeScene("kTalk1")
    composer.gotoScene("kView1")
end

function scene:create( event )
	local sceneGroup = self.view


	local background = display.newRect( display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight )
	background:setFillColor(0.9, 0.9, 0.9)	--gray

	local topBar = display.newRect(display.contentCenterX, display.contentCenterY /9.5, display.contentWidth, 50)
	topBar:setFillColor(0.9, 0.9, 0.9)

	local title = display.newText("학부모들", display.contentCenterX, 145, font, 70 )
	title:setFillColor( 0, 0, 0)

	-- 구분선
	local line1 = display.newLine(0, topBar.y+25, display.contentWidth, topBar.y+25)
	line1:setStrokeColor(0.7, 0.7, 0.7)

	--[[
	local function handleBackEvent( event )
		composer.gotoScene("kView1")
	end

	--back button
	local backButton = widget.newButton(
		{
			width = 45,
			height = 40,
			defaultFile = "images/arrow.png",
			onPress = handleBackEvent
		}
	)
	backButton.x = 20
	backButton.y = topBar.y
	
	--]]

	local bottomBar = display.newRect(display.contentCenterX, display.contentCenterY*1.9, display.contentWidth, 50)
	bottomBar:setFillColor(1)

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
			left = 0,
			width = display.contentWidth,
			height = display.contentHeight - (topBar.height + bottomBar.height) - 200,
			isBounceEnabled = false,
			listener = scrollListener
		}
	)
 
	-- Create a image and insert it into the scroll view
	local chatting = display.newImageRect("images/chatContents_2.png", display.contentWidth, 4800)
	chatting.x = display.contentCenterX
	chatting.y = 2400

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
	sceneGroup:insert( topBar )
	sceneGroup:insert( title )
	sceneGroup:insert( bottomBar )
	sceneGroup:insert( scrollView )
	sceneGroup:insert(bottombar)
    sceneGroup:insert(noteBtn)
    sceneGroup:insert(homeBtn)
    sceneGroup:insert(backBtn)
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

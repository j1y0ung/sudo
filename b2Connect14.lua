-----------------------------------------------------------------------------------------
--
-- b2Connect14.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local widget = require("widget")
local scene = composer.newScene()

-- 단서노트 클릭
local function gotoCluenote()
    print("단서노트 클릭")
    composer.removeScene("b2Connect14")
    composer.gotoScene("clueNote")
end

-- 홈버튼 클릭
local function gotoHome()
    print("홈버튼 클릭")
    composer.removeScene("b2Connect14")
    composer.gotoScene("game_main")
end

-- 뒤로가기 버튼 클릭
local function gotoBack()
    print("뒤로가기 버튼 클릭")
    composer.removeScene("b2Connect14")
    composer.gotoScene("bView2")
end

function scene:create( event )
	local sceneGroup = self.view
	
	local background = display.newRect( display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight )
	background:setFillColor( 1 )	-- white

	local topBar = display.newImageRect("images/connect2Top.png", display.contentWidth, 150)
	topBar.x = display.contentCenterX
	topBar.y = 100

	-- 취소 버튼(뒤로 가기)
	local function goBack(event)
		composer.gotoScene("bView2")	
	end

	local cancelButton = widget.newButton(
		{
			width = 60,
			height = 60,
			defaultFile = "images/cancel.png",
			onPress = goBack
		}
	)
	cancelButton.x = 60
	cancelButton.y = 120

	local bottomBar = display.newImageRect("images/connectBottom.png", display.contentWidth, 150)
	bottomBar.x = display.contentCenterX
	bottomBar.y = 1132

	-- 내용 부분(길어서 스크롤 넣어야 함)
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
			top = 180,
			left = 0,
			width = display.contentWidth,
			height = 887,
			isBounceEnabled = false,
			listener = scrollListener,
			horizontalScrollDisabled = true
		}
	)
 
	-- Create a image and insert it into the scroll view
	local content = display.newImageRect("images/connect2C14.png", display.contentWidth, 1150)
	content.x = display.contentCenterX
	content.y = 625

	scrollView:insert( content )

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

	-- all objects must be added to group (e.g. self.view)
	sceneGroup:insert( background )
	sceneGroup:insert( topBar )
	sceneGroup:insert( cancelButton )
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

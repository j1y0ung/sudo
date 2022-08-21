-----------------------------------------------------------------------------------------
--
-- kView1.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local widget = require("widget")
local scene = composer.newScene()
local font = "font/KM.ttf"

local sqlite3 = require( "sqlite3" )
local path = system.pathForFile( "data.db", system.DocumentsDirectory )
local db = sqlite3.open( path )

-- 단서노트 클릭
local function gotoCluenote()
    print("단서노트 클릭")
    composer.removeScene("kView1")
    composer.gotoScene("clueNote")
end

-- 홈버튼 클릭
local function gotoHome()
    print("홈버튼 클릭")
    composer.removeScene("kView1")
    composer.gotoScene("game_main")
end

-- 뒤로가기 버튼 클릭
local function gotoBack()
    print("뒤로가기 버튼 클릭")
    composer.removeScene("kView1")
    composer.gotoScene("game_main")
end

-- db랑 연결할 부분
local function dbClick( event )
 	if event.name == "timer" then
 		print("dbClick_연락처,비밀번호(톡톡)completed+"..event.name)
 		db:exec([[UPDATE clue SET opened = 'TRUE' WHERE name = '연락처' AND content = '비밀번호(톡톡)';]])  
 	end
end

-- 조건 : kView1이 열린지 1초가 되면 true만들기
timer.performWithDelay(1000, dbClick)

function scene:create( event )
	local sceneGroup = self.view

	local background = display.newRect( display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight )
	background:setFillColor( 1 )	-- white

	local title = display.newText("채팅목록", 130, 125, font, 60 )
	title:setFillColor( 0, 0, 0)

	local bottomBar = display.newRect(display.contentCenterX, display.contentCenterY + 485, display.contentWidth, 150)
	bottomBar:setFillColor(0.8, 0.8, 0.8)

	-- Function to handle button events
	local function handleButtonEvent(event)
		composer.gotoScene( "kView2" )		--여기 바꿔야 함
	end

	-- Create the widget
	local manButton = widget.newButton(
		{
			width = 120,
			height = 120,
			defaultFile = "images/man_blank.png",
			overFile = "images/man_full.png",
			onPress = handleButtonEvent
		}
	)
	manButton.x = 250
	manButton.y = bottomBar.y - 17

	--icon 
	local speechbubble = display.newImageRect("images/speechbubble_full.png", manButton.width - 10, manButton.height - 10)
	speechbubble.x = 500
	speechbubble.y = bottomBar.y - 17

	--Function to handle chatting events
	local function handleChttingEvent( event )
		composer.removeScene("kView1")
		composer.gotoScene("kTalk1")				--여기 바꿔야 함
	end

	-- chatting rooms_button
	local chattingImage1 = widget.newButton(
		{
			width = display.contentWidth,
			height = 180,
			defaultFile = "images/chatting_2.png",
			overFile = "images/chatting_on_2.png",
			onPress = handleChttingEvent
		}
	)
	chattingImage1.x = display.contentCenterX
	chattingImage1.y = 466

	--Function to handle chatting events
	local function handleChttingEvent2( event )
		composer.removeScene("kView1")
		composer.gotoScene("kTalk2")				--여기 바꿔야 함
	end

	-- chatting rooms_button
	local chattingImage2 = widget.newButton(
		{
			width = display.contentWidth,
			height = 180,
			defaultFile = "images/chatting2.png",
			overFile = "images/chatting2_on.png",
			onPress = handleChttingEvent2
		}
	)
	chattingImage2.x = display.contentCenterX
	chattingImage2.y = 290

	--local chattingImage1 = display.newImageRect("images/chatting.png", display.contentWidth, 80)
	--chattingImage1.x = display.contentCenterX
	--chattingImage1.y = display.contentCenterY/2
	
	--------------------------------------------------------------------------------------------



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
	sceneGroup:insert( title )
	sceneGroup:insert( bottomBar )
	sceneGroup:insert( manButton )
	sceneGroup:insert( speechbubble )
	sceneGroup:insert( chattingImage1 )
	sceneGroup:insert( chattingImage2 )
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

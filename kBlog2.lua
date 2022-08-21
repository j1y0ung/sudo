-----------------------------------------------------------------------------------------
--
-- kBlog2.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local widget = require("widget")
local scene = composer.newScene()
local font = "font/KM.ttf"
local bold = "font/KB.ttf"

local sqlite3 = require( "sqlite3" )
local path = system.pathForFile( "data.db", system.DocumentsDirectory )
local db = sqlite3.open( path )

-- 단서노트 클릭
local function gotoCluenote()
    print("단서노트 클릭")
    composer.removeScene("kBlog2")
    composer.gotoScene("clueNote")
end

-- 홈버튼 클릭
local function gotoHome()
    print("홈버튼 클릭")
    composer.removeScene("kBlog2")
    composer.gotoScene("game_main")
end

-- 뒤로가기 버튼 클릭
local function gotoBack()
    print("뒤로가기 버튼 클릭")
    composer.removeScene("kBlog2")
    composer.gotoScene("kBlog")
end

-- db랑 연결할 부분
local function dbClick( event )
	print("dbClick completed!!!+"..event.name)
	db:exec([[UPDATE clue SET opened = 'TRUE' WHERE name = '톡톡' AND content = '비밀번호(비밀갤러리)';]]) 
 end 

function scene:create( event )
	local sceneGroup = self.view
	
	local background = display.newRect( display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight )
	background:setFillColor(1)	

	local topBar = display.newRect(display.contentCenterX, display.contentCenterY /9.5, display.contentWidth, 50)
	topBar:setFillColor(1)

	local logo = display.newImageRect("images/kBlogLogo.png", 620, 120)
	logo.x = display.contentCenterX
	logo.y = 100


	-- 구분선
	local line1 = display.newLine(0, topBar.y+25, display.contentWidth, topBar.y+25)
	line1:setStrokeColor(0.7, 0.7, 0.7)

	--[[
	local function handleBackEvent( event )
		composer.gotoScene("kBlog")
	end

	--back button
	local backButton = widget.newButton(
		{
			width = 30,
			height = 20,
			defaultFile = "images/arrow_an.png",
			onPress = handleBackEvent
		}
	)
	backButton.x = 20
	backButton.y = 20
	--]]

	-- ScrollView listener
	local function scrollListener( event )
	 
	    local phase = event.phase
	    if ( phase == "began" ) then print( "Scroll view was touched" )
	    elseif ( phase == "moved" ) then print( "Scroll view was moved" )
	    elseif ( phase == "ended" ) then print( "Scroll view was released" )
	    end
	 	
	    if ( event.limitReached ) then
        	if ( event.direction == "up" ) then 
        		print( "Reached bottom limit" )
        		local event = {name = "limitBottom"}
        		dbClick(event)
        	end
        end

	    return true
	end

	-- Create the widget
	local scrollView = widget.newScrollView(
		{
			top = 35,
			left = 0,
			width = display.contentWidth,
			height = display.contentHeight,
			isBounceEnabled = false,
			listener = scrollListener
		}
	)
 
	-- Create a image and insert it into the scroll view
	local chatting = display.newImageRect("images/kBlog2Content.png", display.contentWidth,4000)
	chatting.x = display.contentCenterX
	chatting.y = 2250

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

	scrollView:insert( chatting )
	scrollView:insert( topBar )
	scrollView:insert( logo )
	--scrollView:insert( backButton )
	sceneGroup:insert( background )
	sceneGroup:insert( topBar )
	sceneGroup:insert( line1 )
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

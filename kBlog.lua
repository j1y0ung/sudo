-----------------------------------------------------------------------------------------
--
-- kBlog.lua
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
    composer.removeScene("kBlog")
    composer.gotoScene("clueNote")
end

-- 홈버튼 클릭
local function gotoHome()
    print("홈버튼 클릭")
    composer.removeScene("kBlog")
    composer.gotoScene("game_main")
end

-- 뒤로가기 버튼 클릭
local function gotoBack()
    print("뒤로가기 버튼 클릭")
    composer.removeScene("kBlog")
    composer.gotoScene("kTalk2")
end

-- db랑 연결할 부분
local function dbClick( event )
 	print("dbClick completed!!!+"..event.name)
 	db:exec([[UPDATE clue SET opened = 'TRUE' WHERE name = '톡톡' AND content = '사이비';]])
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

	local function handleBackEvent( event )
		composer.gotoScene("kTalk2")
	end

	--[[
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
        		
        		-- 조건 : 스크롤이 맨 아래까지 닿았을 때
				local event = {name="scrollOut"}
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
	local chatting = display.newImageRect("images/kBlogContent.png", display.contentWidth, 6000)
	chatting.x = display.contentCenterX
	chatting.y = 3200

	local comment1 = display.newText("이 블로그                  의  이전 글", display.contentCenterX+1, 6010, font, 40)
	comment1:setFillColor(0.3, 0.3, 0.3)		

	local comment2 = display.newText("메종드 퓨어", display.contentCenterX, 6010, bold, 40)
	comment2:setFillColor(1, 0.85, 0)		

	local function goToBlog2Event( event )
		composer.gotoScene("kBlog2")
	end

	--button
	local commentButton = widget.newButton(
		{
			width = display.contentWidth+2,
			height = 170,
			defaultFile = "images/kBlogCommentButton.png",
			onPress = goToBlog2Event
		}
	)
	commentButton.x = display.contentCenterX-2
	commentButton.y = 6120

	scrollView:insert( chatting )
	scrollView:insert( topBar )
	scrollView:insert( logo )
	--scrollView:insert( backButton )
	scrollView:insert( comment1 )
	scrollView:insert( comment2 )
	scrollView:insert( commentButton )

	--------------------------------------------------------------------------------------------
	
	-- 조건 : kTalk2에서 kBlog로 가는 버튼을 눌렀을 시
	commentButton:addEventListener("touch", dbClick)

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

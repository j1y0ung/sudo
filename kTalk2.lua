-----------------------------------------------------------------------------------------
--
-- kTalk2.lua
--
-----------------------------------------------------------------------------------------

-- 모녀 대화

local composer = require( "composer" )
local widget = require("widget")
local scene = composer.newScene()
local num = 0
local font = "font/KM.ttf"

local sqlite3 = require( "sqlite3" )
local path = system.pathForFile( "data.db", system.DocumentsDirectory )
local db = sqlite3.open( path )

-- 단서노트 클릭
local function gotoCluenote()
    print("단서노트 클릭")
    composer.removeScene("kTalk2")
    composer.gotoScene("clueNote")
end

-- 홈버튼 클릭
local function gotoHome()
    print("홈버튼 클릭")
    composer.removeScene("kTalk2")
    composer.gotoScene("game_main")
end

-- 뒤로가기 버튼 클릭
local function gotoBack()
    print("뒤로가기 버튼 클릭")
    composer.removeScene("kTalk2")
    composer.gotoScene("kView1")
end

-- db랑 연결할 부분
local function dbClick( event )
 	if event.name == "timer" then
 		print("dbClick completed!!!+"..event.name)
 		db:exec([[UPDATE clue SET opened = 'TRUE' WHERE name = '톡톡' AND content = '딸';]])  
 	elseif event.target.id == "moveButtonToBlog" then
 		print("dbClick completed!!!+"..event.target.id)	
 		db:exec([[UPDATE clue SET opened = 'TRUE' WHERE name = '톡톡' AND content = '링크';]])
 	elseif event.target.id == "water" then
 		print("dbClick completed!!!+"..event.target.id)
 		db:exec([[UPDATE clue SET opened = 'TRUE' WHERE name = '톡톡' AND content = '물';]])
 	elseif event.target.id == "mental" then
 		print("dbClick completed!!!+"..event.target.id)
 		db:exec([[UPDATE clue SET opened = 'TRUE' WHERE name = '톡톡' AND content = '정신교육';]])
 	elseif event.target.id == "drug" then
 		print("dbClick completed!!!+"..event.target.id)
 		db:exec([[UPDATE clue SET opened = 'TRUE' WHERE name = '톡톡' AND content = '총명탕';]])
 	end
end

-- 조건 : kView1이 열린지 7초가 되면 true만들기
timer.performWithDelay(7000, dbClick)

function scene:create( event )
	local sceneGroup = self.view
	
	local background = display.newRect( display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight )
	background:setFillColor(0.9, 0.9, 0.9)	--gray

	local topBar = display.newRect(display.contentCenterX, display.contentCenterY /9.5, display.contentWidth, 50)
	topBar:setFillColor(0.9, 0.9, 0.9)

	local title = display.newText("큰딸", display.contentCenterX, 145, font, 70 )
	title:setFillColor( 0, 0, 0)

	-- 구분선
	local line1 = display.newLine(0, topBar.y+25, display.contentWidth, topBar.y+25)
	line1:setStrokeColor(0.7, 0.7, 0.7)

	local function handleBackEvent( event )
		composer.gotoScene("kView1")
	end

	--[[
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

	local function scrollListener( event )
	 
	    local phase = event.phase
	    if ( phase == "began" ) then print( "Scroll view was touched" )
	    elseif ( phase == "moved" ) then print( "Scroll view was moved" )
	    elseif ( phase == "ended" ) then print( "Scroll view was released" )
	    end
	 
	    return true
	end


local scrollView = widget.newScrollView(
  {
        top = 200,
        left = 0,
        width = 2000,
        height = 960,
        horizontalScrollDisabled = true,
        listener = scrollListener,
        backgroundColor = {0.47}
    }
)
 	
	--local chat2Bg = display.newImageRect("images/chat2Bg.png", display.contentWidth, 30000)
	--chat2Bg.x = display.contentCenterX
	--chat2Bg.y = 5400

	-- Create a image and insert it into the scroll view
	local chatting1 = display.newImageRect("images/chat2Contents1.png", display.contentWidth, 1750)
	chatting1.x = display.contentCenterX
	chatting1.y = 930

	local chatting2 = display.newImageRect("images/chat2Contents2.png", display.contentWidth, 1650)
	chatting2.x = display.contentCenterX
	chatting2.y = 2640

	
	local chatting3 = display.newImageRect("images/chat2Contents3.png", display.contentWidth, 1900)
	chatting3.x = display.contentCenterX
	chatting3.y = 4460
	
	local chatting4 = display.newImageRect("images/chat2Contents4.png", display.contentWidth, 1750)
	chatting4.x = display.contentCenterX
	chatting4.y = 6330
	
	local chatting5 = display.newImageRect("images/chat2Contents5.png", display.contentWidth, 1800)
	chatting5.x = display.contentCenterX
	chatting5.y = 8120
	
	local chatting6 = display.newImageRect("images/chat2Contents6.png", display.contentWidth, 1800)
	chatting6.x = display.contentCenterX
	chatting6.y = 9980
	
	local chatting7 = display.newImageRect("images/chat2Contents7.png", display.contentWidth, 1900)
	chatting7.x = display.contentCenterX
	chatting7.y = 11880
	
	local chatting8 = display.newImageRect("images/chat2Contents8.png", display.contentWidth, 1850)
	chatting8.x = display.contentCenterX
	chatting8.y = 13830
	
	local chatting9 = display.newImageRect("images/chat2Contents9.png", display.contentWidth, 1550)
	chatting9.x = display.contentCenterX
	chatting9.y = 15500
	
	local chatting10 = display.newImageRect("images/chat2Contents10.png", display.contentWidth, 1700)
	chatting10.x = display.contentCenterX
	chatting10.y = 17200
	
	local chatting11 = display.newImageRect("images/chat2Contents11.png", display.contentWidth, 1530)
	chatting11.x = display.contentCenterX
	chatting11.y = 18830
	
	local chatting12 = display.newImageRect("images/chat2Contents12.png", display.contentWidth, 1800)
	chatting12.x = display.contentCenterX
	chatting12.y = 20565
	
	local chatting13 = display.newImageRect("images/chat2Contents13.png", display.contentWidth, 1500)
	chatting13.x = display.contentCenterX
	chatting13.y = 22230
	
	local chatting14 = display.newImageRect("images/chat2Contents14.png", display.contentWidth, 820)
	chatting14.x = display.contentCenterX
	chatting14.y = 23420

	-- 블로그로 이동 버튼
	local function moveToBlog(event)
		composer.gotoScene("kBlog")		
	end

	local moveButton = widget.newButton(
		{
			id = "moveButtonToBlog",
			width = 365,
			height = 160,
			defaultFile = "images/chatBlogButton.png",
			onPress = moveToBlog
		}
	)
	moveButton.x = 302
	moveButton.y = 20580

	--------------------------------------------------------------------------------------------
	
	-- 조건 : kTalk2에서 kBlog로 가는 버튼을 눌렀을 시
	moveButton:addEventListener("touch", dbClick)

	-- 조건 : 큰딸과의 톡톡방(ktalk2)를 열고 스크롤을 3번 했을 때 
	-->그 부분에 투명상자를 하나 만들어서 클릭하면 실행되도록 한다. 
	local clickBox_water = display.newRect(520, 3370, 400, 380)
	clickBox_water.id = "water"
	clickBox_water.alpha = 0.01

	clickBox_water:addEventListener("touch", dbClick)

	-- 조건 : 큰딸과의 톡톡방(ktalk2)를 열고 스크롤을 9번 했을 때 
	-->그 부분에 투명상자를 하나 만들어서 클릭하면 실행되도록 한다. 
	local clickBox_mental = display.newRect(520, 9400, 400, 480)
	clickBox_mental.id = "mental"
	clickBox_mental.alpha = 0.01

	clickBox_mental:addEventListener("touch", dbClick)

	-- 조건 : 큰딸과의 톡톡방(ktalk2)를 열고 스크롤을 16번 했을 때 
	-->그 부분에 투명상자를 하나 만들어서 클릭하면 실행되도록 한다. 
	local clickBox_drug = display.newRect(200, 17250, 550, 400)
	clickBox_drug.id = "drug"
	clickBox_drug.alpha = 0.01

	clickBox_drug:addEventListener("touch", dbClick)

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

	--scrollView:insert( chat2Bg )
	scrollView:insert( chatting1 )
	scrollView:insert( chatting2 )
	scrollView:insert( chatting3 )
	scrollView:insert( chatting4 )
	scrollView:insert( chatting5 )
	scrollView:insert( chatting6 )
	scrollView:insert( chatting7 )
	scrollView:insert( chatting8 )
	scrollView:insert( chatting9 )
	scrollView:insert( chatting10 )
	scrollView:insert( chatting11 )
	scrollView:insert( chatting12 )
	scrollView:insert( chatting13 )
	scrollView:insert( chatting14 )

	scrollView:insert( moveButton )

	-- db연결을 위한 임의 상자
	scrollView:insert( clickBox_water )
	scrollView:insert( clickBox_mental )
	scrollView:insert( clickBox_drug )

	sceneGroup:insert( background )
	sceneGroup:insert( topBar )
	sceneGroup:insert( title )
	sceneGroup:insert( line1 )
	--sceneGroup:insert( backButton )
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

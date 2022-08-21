-----------------------------------------------------------------------------------------
--
-- bView1.lua
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
    composer.removeScene("bView1")
    composer.gotoScene("clueNote")
end

-- 홈버튼 클릭
local function gotoHome()
    print("홈버튼 클릭")
    composer.removeScene("bView1")
    composer.gotoScene("game_main")
end

-- 뒤로가기 버튼 클릭
local function gotoBack()
    print("뒤로가기 버튼 클릭")
    composer.removeScene("bView1")
    composer.gotoScene("bTitle")
end

-- db랑 연결할 부분
local function dbClick( event )
 	if event.target.id == "clue1" then
 		print("dbClick completed!!!+"..event.target.id)	
 		db:exec([[UPDATE clue SET opened = 'TRUE' WHERE name = '밴드' AND content = '지령1';]]) 
 	elseif event.target.id == "clue2" then
 		print("dbClick completed!!!+"..event.target.id)
 		db:exec([[UPDATE clue SET opened = 'TRUE' WHERE name = '밴드' AND content = '지령2';]]) 
 	elseif event.target.id == "clue3" then
 		print("dbClick completed!!!+"..event.target.id)
 		db:exec([[UPDATE clue SET opened = 'TRUE' WHERE name = '밴드' AND content = '지령3';]]) 
 	elseif event.target.id == "clue4" then
 		print("dbClick completed!!!+"..event.target.id)
 		db:exec([[UPDATE clue SET opened = 'TRUE' WHERE name = '밴드' AND content = '지령4';]]) 
 	end
end

function scene:create( event )
	local sceneGroup = self.view
	
	local background = display.newRect( display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight )
	background:setFillColor( 1 )

	 -- 상단바
    local topbar = display.newRect(display.contentCenterX, 40, display.contentWidth, 80)
    topbar:setFillColor( 0 )

    -- 시계
    local currentTime = os.date("*t")
    local h = currentTime.hour
    local m = currentTime.min
    local time = display.newText(h..":"..m, 80, 40, font)

    local function clock()
        currentTime = os.date("*t")
        h = currentTime.hour
        m = currentTime.min
        
        -- print("현재시간 = "..currentTime.hour..":"..currentTime.min)
        -- print("clock 호출됨")
        local clockDisplay = string.format("%d:%d", h, m)
        -- print(clockDisplay)
        if h < 12 then
            if m < 10 then
                clockDisplay = string.format("0%d:0%d", h, m)
                time.text = clockDisplay
            elseif m >= 10 then
                clockDisplay = string.format("0%d:%d", h, m)
                time.text = clockDisplay
            end
        elseif h >= 12 then
            if m < 10 then
                clockDisplay = string.format("%d:0%d", h, m)
                time.text = clockDisplay
            elseif m >= 10 then
                clockDisplay = string.format("%d:%d", h, m)
                time.text = clockDisplay
            end
        end
    end
    local clock1 = clock()
    local clock2 = timer.performWithDelay(5000, clock, -1) -- 5초마다 시계 갱신

    -- 와이파이 아이콘
    local wifi = display.newImageRect("imgsources/w_wifi.png", 60, 45)
    wifi.x, wifi.y = 500, 35

    -- 배터리 아이콘
    local battery_t = display.newText("34%", 585, 40, font)
    local battery = display.newImageRect("imgsources/w_battery.png", 70, 45)
    battery.x, battery.y = 650, 40


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
			top = 30,
			left = 0,
			width = display.contentWidth,
			height = 1160,
			isBounceEnabled = false,
			listener = scrollListener,
			horizontalScrollDisabled = true
		}
	)
 
	-- Create a image and insert it into the scroll view
	local connectFrame = display.newImageRect("images/connectView1Frame.png", display.contentWidth, 5000)
	connectFrame.x = display.contentCenterX-1
	connectFrame.y = 2550

	--[[
	-- 뒤로가기 버튼
	-- Function to handle button events
	local function handleButtonEvent(event)
		local phase = event.phase
 
	    if ( phase == "moved" ) then
	        local dy = math.abs( ( event.y - event.yStart ) )
	        -- If the touch on the button has moved more than 10 pixels,
	        -- pass focus back to the scroll view so it can continue scrolling
	        if ( dy > 10 ) then
	            scrollView:takeFocus( event )
	        end
	    end
	    composer.gotoScene("bTitle")
	    
	    return true
	end

	-- Create the widget
	local backButton = widget.newButton(
		{
			width = 40,
			height = 40,
			defaultFile = "images/arrow.png",
			onPress = handleButtonEvent
		}
	)
	backButton.x = 25
	backButton.y = 40
	--]]


	-- 더보기 버튼1
	local function moveToConnect1(event)
		composer.gotoScene("bConnect1")		--2020년 1월 2일
	end

	local button_more_1 = widget.newButton(
		{
			width = 120,
			height = 60,
			defaultFile = "images/button_more.png",
			onPress = moveToConnect1
		}
	)
	button_more_1.x = 630
	button_more_1.y = 1040

	-- 더보기 버튼2
	local function moveToConnect2(event)
		composer.gotoScene("bConnect2")		--2019년 12월 15일
	end

	local button_more_2 = widget.newButton(
		{
			id = "clue1",
			width = 120,
			height = 60,
			defaultFile = "images/button_more.png",
			onPress = moveToConnect2
		}
	)
	button_more_2.x = 630
	button_more_2.y = 1465

	-- 조건 : bView1에서 bConnect2를 클릭했을 때
	button_more_2:addEventListener("touch", dbClick)


	-- 더보기 버튼3
	local function moveToConnect3(event)
		composer.gotoScene("bConnect3")		--2019년 11월 13일
	end

	local button_more_3 = widget.newButton(
		{
			width = 120,
			height = 60,
			defaultFile = "images/button_more.png",
			onPress = moveToConnect3
		}
	)
	button_more_3.x = 630
	button_more_3.y = 1905

	-- 더보기 버튼4
	local function moveToConnect4(event)
		composer.gotoScene("bConnect4")		--2019년 10월 15일
	end

	local button_more_4 = widget.newButton(
		{
			id = "clue2",
			width = 120,
			height = 60,
			defaultFile = "images/button_more.png",
			onPress = moveToConnect4
		}
	)
	button_more_4.x = 630
	button_more_4.y = 2360

	-- 조건 : bView1에서 bConnect4를 클릭했을 때
	button_more_4:addEventListener("touch", dbClick)

	-- 더보기 버튼5
	local function moveToConnect5(event)
		composer.gotoScene("bConnect5")		--2019년 9월 16일
	end

	local button_more_5 = widget.newButton(
		{
			id = "clue3",
			width = 120,
			height = 60,
			defaultFile = "images/button_more.png",
			onPress = moveToConnect5
		}
	)
	button_more_5.x = 630
	button_more_5.y = 2855

	-- 조건 : bView1에서 bConnect5를 클릭했을 때
	button_more_5:addEventListener("touch", dbClick)

	-- 더보기 버튼6
	local function moveToConnect6(event)
		composer.gotoScene("bConnect6")		--2019년 8월 27일
	end

	local button_more_6 = widget.newButton(
		{
			id = "clue4",
			width = 120,
			height = 60,
			defaultFile = "images/button_more.png",
			onPress = moveToConnect6
		}
	)
	button_more_6.x = 630
	button_more_6.y = 3290

	-- 조건 : bView1에서 bConnect6를 클릭했을 때
	button_more_6:addEventListener("touch", dbClick)

	-- 더보기 버튼7
	local function moveToConnect7(event)
		composer.gotoScene("bConnect7")		--2019년 7월 6일
	end

	local button_more_7 = widget.newButton(
		{
			width = 120,
			height = 60,
			defaultFile = "images/button_more.png",
			onPress = moveToConnect7
		}
	)
	button_more_7.x = 630
	button_more_7.y = 3725

	-- 더보기 버튼8
	local function moveToConnect8(event)
		composer.gotoScene("bConnect8")		--2019년 6월 14일
	end

	local button_more_8 = widget.newButton(
		{
			width = 120,
			height = 60,
			defaultFile = "images/button_more.png",
			onPress = moveToConnect8
		}
	)
	button_more_8.x = 630
	button_more_8.y = 4160

	-- 더보기 버튼, 댓글쓰기 버튼9
	local function moveToConnect9(event)
		composer.gotoScene("bConnect9")		--2019년 6월 14일
	end

	local button_more_9 = widget.newButton(
		{
			width = 120,
			height = 60,
			defaultFile = "images/button_more.png",
			onPress = moveToConnect9
		}
	)
	button_more_9.x = 630
	button_more_9.y = 4605

	local button_wr_9 = widget.newButton(
		{
			width = 120,
			height = 60,
			defaultFile = "images/button_wr.png",
			onPress = moveToConnect9
		}
	)
	button_wr_9.x = 630
	button_wr_9.y = 4670


	scrollView:insert( connectFrame )
	--scrollView:insert( backButton )
	
	scrollView:insert( button_more_1 )
	scrollView:insert( button_more_2 )
	scrollView:insert( button_more_3 )
	scrollView:insert( button_more_4 )
	scrollView:insert( button_more_5 )
	scrollView:insert( button_more_6 )
	scrollView:insert( button_more_7 )
	scrollView:insert( button_more_8 )
	scrollView:insert( button_more_9 )
	scrollView:insert( button_wr_9 )

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

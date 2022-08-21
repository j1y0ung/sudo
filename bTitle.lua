-----------------------------------------------------------------------------------------
--
-- bTitle.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local widget = require("widget")
local scene = composer.newScene()
local font = "font/KM.ttf"

-- 단서노트 클릭
local function gotoCluenote()
    print("단서노트 클릭")
    composer.removeScene("bTitle")
    composer.gotoScene("clueNote")
end

-- 홈버튼 클릭
local function gotoHome()
    print("홈버튼 클릭")
    composer.removeScene("bTitle")
    composer.gotoScene("game_main")
end

-- 뒤로가기 버튼 클릭
local function gotoBack()
    print("뒤로가기 버튼 클릭")
    composer.removeScene("bTitle")
    composer.gotoScene("game_main")
end

function scene:create( event )
	local sceneGroup = self.view
	
	local background = display.newRect( display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight )
	background:setFillColor( 1 )	-- white
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
    local clock2 = timer.performWithDelay(500, clock, -1) -- 5초마다 시계 갱신

    -- 와이파이 아이콘
    local wifi = display.newImageRect("imgsources/w_wifi.png", 60, 45)
    wifi.x, wifi.y = 500, 35

    -- 배터리 아이콘
    local battery_t = display.newText("34%", 585, 40, font)
    local battery = display.newImageRect("imgsources/w_battery.png", 70, 45)
    battery.x, battery.y = 650, 40



	--버튼 제외하고는 그림임. 틀이 있음
	local outFrame = display.newImageRect("images/connectContents.png", 720, 1020)
	outFrame.x = display.contentCenterX + 5
	outFrame.y = display.contentCenterY

	-- 사이비 커넥트로 가는 버튼 만들기
	
	-- Function to handle button events
	local function handleButtonEvent_1(event)
		composer.gotoScene( "bView1" )		
	end

	-- Create the widget
	local button1 = widget.newButton(
		{
			width = 320,
			height = 310,
			defaultFile = "images/connect_button1.png",
			--overFile = "images/man_full.png",
			onPress = handleButtonEvent_1
		}
	)
	button1.x = 180
	button1.y = 610

	-- 쿠키클래스 커넥트로 가는 버튼 만들기
	
	-- Function to handle button events
	local function handleButtonEvent_2(event)
		composer.gotoScene( "bView2" ) 		
	end

	-- Create the widget
	local button2 = widget.newButton(
		{
			width = 320,
			height = 310,
			defaultFile = "images/connect_button2.png",
			--overFile = "images/man_full.png",
			onPress = handleButtonEvent_2
		}
	)
	button2.x = 520
	button2.y = 610


    -- all ob
    
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
	sceneGroup:insert( outFrame )
	sceneGroup:insert( button1 )
	sceneGroup:insert( button2 )
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

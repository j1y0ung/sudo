-----------------------------------------------------------------------------------------
--
-- kIntro.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local widget = require("widget")
local scene = composer.newScene()
local font = "font/KM.ttf"

-- 단서노트 클릭
local function gotoCluenote()
    print("단서노트 클릭")
    composer.removeScene("kIntro")
    composer.gotoScene("clueNote")
end

-- 홈버튼 클릭
local function gotoHome()
    print("홈버튼 클릭")
    composer.removeScene("kIntro")
    composer.gotoScene("game_main")
end

-- 뒤로가기 버튼 클릭
local function gotoBack()
    print("뒤로가기 버튼 클릭")
    composer.removeScene("kIntro")
    composer.gotoScene("game_main")
end

function scene:create( event )
	local sceneGroup = self.view
	
	-- Variable
	local background
	local topbar
	local currentTime
	local h
	local m
	local time
	local clock1
	local clock2
	local wifi
	local battery_t
	local battery
	local icon
	local clockDisplay;
	local myTimer

	-- Function
	local Main = {}
	local clock = {}
	local handleSceneListener = {}
	local restart = {}

	function Main()
		background = display.newRect( display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight )
		background:setFillColor( 1 )	-- white

		 -- 상단바
	    topbar = display.newRect(display.contentCenterX, 40, display.contentWidth, 80)
	    topbar:setFillColor( 0 )

	    -- 시계
	    currentTime = os.date("*t")
	    h = currentTime.hour
	    m = currentTime.min
	    time = display.newText(h..":"..m, 80, 40, font)

	    clock1 = clock()
	    clock2 = timer.performWithDelay(5000, clock, -1) -- 5초마다 시계 갱신

	    -- 와이파이 아이콘
	    wifi = display.newImageRect("imgsources/w_wifi.png", 60, 45)
	    wifi.x, wifi.y = 500, 35

	    -- 배터리 아이콘
	    battery_t = display.newText("34%", 585, 40, font)
	    battery = display.newImageRect("imgsources/w_battery.png", 70, 45)
	    battery.x, battery.y = 650, 40

		
		icon = display.newImageRect("images/icon_talk.png", 200, 200)
		icon.x = display.contentCenterX
		icon.y = display.contentCenterY - 80

		myTimer = timer.performWithDelay(1000, handleSceneListener, 1)
	end

	function clock()
        currentTime = os.date("*t")
        h = currentTime.hour
        m = currentTime.min
        
        -- print("현재시간 = "..currentTime.hour..":"..currentTime.min)
        -- print("clock 호출됨")
        clockDisplay = string.format("%d:%d", h, m)
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

    function handleSceneListener(event)
        composer.removeScene( "kIntro" )
		composer.gotoScene( "kView1" )
	end


	function restart()
    	Main()
	end


	restart()
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
	sceneGroup:insert( icon )
	sceneGroup:insert( bottombar )
	sceneGroup:insert( noteBtn )
	sceneGroup:insert( homeBtn )
	sceneGroup:insert( backBtn )
	--sceneGroup:insert( myTimer )
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

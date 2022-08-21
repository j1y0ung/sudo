-----------------------------------------------------------------------------------------
--
-- bView2.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local widget = require("widget")
local scene = composer.newScene()
local font = "font/KM.ttf"

-- 단서노트 클릭
local function gotoCluenote()
    print("단서노트 클릭")
    composer.removeScene("bView2")
    composer.gotoScene("clueNote")
end

-- 홈버튼 클릭
local function gotoHome()
    print("홈버튼 클릭")
    composer.removeScene("bView2")
    composer.gotoScene("game_main")
end

-- 뒤로가기 버튼 클릭
local function gotoBack()
    print("뒤로가기 버튼 클릭")
    composer.removeScene("bView2")
    composer.gotoScene("bTitle")
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
			top = 0,
			left = 2,
			width = display.contentWidth-2,
			height = display.contentHeight,
			isBounceEnabled = false,
			listener = scrollListener,
			horizontalScrollDisabled = true
		}
	)
 
	-- Create a image and insert it into the scroll view
	--너무 커서 글씨가 뭉개지네요.. 그래서 나눠서 넣음
	local connectFrame1 = display.newImageRect("images/connectView2Frame1.png", display.contentWidth, 2400)
	connectFrame1.x = display.contentCenterX-1
	connectFrame1.y = 1280

	local connectFrame2 = display.newImageRect("images/connectView2Frame2.png", display.contentWidth, 2400)
	connectFrame2.x = display.contentCenterX-1
	connectFrame2.y = 3700
	
	local connectFrame3 = display.newImageRect("images/connectView2Frame3.png", display.contentWidth, 2100)
	connectFrame3.x = display.contentCenterX-1
	connectFrame3.y = 5980
	
	local connectFrame4 = display.newImageRect("images/connectView2Frame4.png", display.contentWidth, 2300)
	connectFrame4.x = display.contentCenterX-1
	connectFrame4.y = 8200
	
	local connectFrame5 = display.newImageRect("images/connectView2Frame5.png", display.contentWidth, 2100)
	connectFrame5.x = display.contentCenterX-1
	connectFrame5.y = 10430
	
	local connectFrame6 = display.newImageRect("images/connectView2Frame6.png", display.contentWidth, 2000)
	connectFrame6.x = display.contentCenterX-1
	connectFrame6.y = 12500
	
	local connectFrame7 = display.newImageRect("images/connectView2Frame7.png", display.contentWidth, 2400)
	connectFrame7.x = display.contentCenterX-1
	connectFrame7.y = 14710
	
	local connectFrame8 = display.newImageRect("images/connectView2Frame8.png", display.contentWidth, 2000)
	connectFrame8.x = display.contentCenterX-1
	connectFrame8.y = 16920
	
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
			width = 60,
			height = 55,
			defaultFile = "images/arrow.png",
			onPress = handleButtonEvent
		}
	)
	backButton.x = 60
	backButton.y = 80
	--]]
	
	-- 더보기 버튼, 댓글쓰기 버튼1
	local function moveToConnect1(event)
		composer.gotoScene("b2Connect1")		--2020년 1월 18일
	end

	local button_more_1 = widget.newButton(
		{
			width = 140,
			height = 60,
			defaultFile = "images/button_more.png",
			onPress = moveToConnect1
		}
	)
	button_more_1.x = 580
	button_more_1.y = 945

	local button_wr_1 = widget.newButton(
		{
			width = 140,
			height = 60,
			defaultFile = "images/button_wr.png",
			onPress = moveToConnect1
		}
	)
	button_wr_1.x = 580
	button_wr_1.y = 1015

	-- 댓글쓰기 버튼2
	local function moveToConnect2(event)
		composer.gotoScene("b2Connect2")		--2019년 12월 25일
	end

	local button_wr_2 = widget.newButton(
		{
			width = 140,
			height = 60,
			defaultFile = "images/button_wr.png",
			onPress = moveToConnect2
		}
	)
	button_wr_2.x = 580
	button_wr_2.y = 1720

	-- 더보기 버튼, 댓글쓰기 버튼3
	local function moveToConnect3(event)
		composer.gotoScene("b2Connect3")		--2020년 12월 3일
	end

	local button_more_3 = widget.newButton(
		{
			width = 140,
			height = 60,
			defaultFile = "images/button_more.png",
			onPress = moveToConnect3
		}
	)
	button_more_3.x = 580
	button_more_3.y = 2363

	local button_wr_3 = widget.newButton(
		{
			width = 140,
			height = 60,
			defaultFile = "images/button_wr.png",
			onPress = moveToConnect3
		}
	)
	button_wr_3.x = 580
	button_wr_3.y = 2433

	-- 더보기 버튼, 댓글쓰기 버튼4
	local function moveToConnect4(event)
		composer.gotoScene("b2Connect4")		--2020년 10월 19일
	end

	local button_more_4 = widget.newButton(
		{
			width = 140,
			height = 60,
			defaultFile = "images/button_more.png",
			onPress = moveToConnect4
		}
	)
	button_more_4.x = 620
	button_more_4.y = 2748

	local button_wr_4 = widget.newButton(
		{
			width = 140,
			height = 60,
			defaultFile = "images/button_wr.png",
			onPress = moveToConnect4
		}
	)
	button_wr_4.x = 580
	button_wr_4.y = 2818

	-- 댓글쓰기 버튼5
	local function moveToConnect5(event)
		composer.gotoScene("b2Connect5")		--2019년 9월 30일
	end

	local button_wr_5 = widget.newButton(
		{
			width = 140,
			height = 60,
			defaultFile = "images/button_wr.png",
			onPress = moveToConnect5
		}
	)
	button_wr_5.x = 580
	button_wr_5.y = 3530

	-- 댓글쓰기 버튼6
	local function moveToConnect6(event)
		composer.gotoScene("b2Connect6")		--2019년 9월 18일
	end

	local button_wr_6 = widget.newButton(
		{
			width = 140,
			height = 60,
			defaultFile = "images/button_wr.png",
			onPress = moveToConnect6
		}
	)
	button_wr_6.x = 580
	button_wr_6.y = 4209

	-- 더보기 버튼, 댓글쓰기 버튼7
	local function moveToConnect7(event)
		composer.gotoScene("b2Connect7")		--2019년 8월 22일
	end

	local button_more_7 = widget.newButton(
		{
			width = 140,
			height = 60,
			defaultFile = "images/button_more.png",
			onPress = moveToConnect7
		}
	)
	button_more_7.x = 580
	button_more_7.y = 4790

	local button_wr_7 = widget.newButton(
		{
			width = 140,
			height = 60,
			defaultFile = "images/button_wr.png",
			onPress = moveToConnect7
		}
	)
	button_wr_7.x = 580
	button_wr_7.y = 4860

	-- 댓글쓰기 버튼8
	local function moveToConnect8(event)
		composer.gotoScene("b2Connect8")		--2019년 8월 13일
	end

	local button_wr_8 = widget.newButton(
		{
			width = 140,
			height = 60,
			defaultFile = "images/button_wr.png",
			onPress = moveToConnect8
		}
	)
	button_wr_8.x = 580
	button_wr_8.y = 5160

	-- 댓글쓰기 버튼9
	local function moveToConnect9(event)
		composer.gotoScene("b2Connect9")		--2019년 6월 21일
	end

	local button_wr_9 = widget.newButton(
		{
			width = 140,
			height = 60,
			defaultFile = "images/button_wr.png",
			onPress = moveToConnect9
		}
	)
	button_wr_9.x = 580
	button_wr_9.y = 5596

	-- 댓글쓰기 버튼10
	local function moveToConnect10(event)
		composer.gotoScene("b2Connect10")		--2019년 5월 9일
	end

	local button_wr_10 = widget.newButton(
		{
			width = 140,
			height = 60,
			defaultFile = "images/button_wr.png",
			onPress = moveToConnect10
		}
	)
	button_wr_10.x = 580
	button_wr_10.y = 6753

	-- 댓글쓰기 버튼11
	local function moveToConnect11(event)
		composer.gotoScene("b2Connect11")		--2019년 5월 2일
	end

	local button_wr_11 = widget.newButton(
		{
			width = 140,
			height = 60,
			defaultFile = "images/button_wr.png",
			onPress = moveToConnect11
		}
	)
	button_wr_11.x = 580
	button_wr_11.y = 7705

	-- 댓글쓰기 버튼12
	local function moveToConnect12(event)
		composer.gotoScene("b2Connect12")		--2019년 4월 6일
	end

	local button_wr_12 = widget.newButton(
		{
			width = 140,
			height = 60,
			defaultFile = "images/button_wr.png",
			onPress = moveToConnect12
		}
	)
	button_wr_12.x = 580
	button_wr_12.y = 8322

	-- 댓글쓰기 버튼13
	local function moveToConnect13(event)
		composer.gotoScene("b2Connect13")		--2019년 3월 22일
	end

	local button_wr_13 = widget.newButton(
		{
			width = 140,
			height = 60,
			defaultFile = "images/button_wr.png",
			onPress = moveToConnect13
		}
	)
	button_wr_13.x = 580
	button_wr_13.y = 9060

	-- 더보기 버튼, 댓글쓰기 버튼14
	local function moveToConnect14(event)
		composer.gotoScene("b2Connect14")		--2019년 3월 5일
	end

	local button_more_14 = widget.newButton(
		{
			width = 140,
			height = 60,
			defaultFile = "images/button_more.png",
			onPress = moveToConnect14
		}
	)
	button_more_14.x = 580
	button_more_14.y = 9663

	local button_wr_14 = widget.newButton(
		{
			width = 140,
			height = 60,
			defaultFile = "images/button_wr.png",
			onPress = moveToConnect14
		}
	)
	button_wr_14.x = 580
	button_wr_14.y = 9733

	-- 댓글쓰기 버튼15
	local function moveToConnect15(event)
		composer.gotoScene("b2Connect15")		--2019년 2월 27일
	end

	local button_wr_15 = widget.newButton(
		{
			width = 140,
			height = 60,
			defaultFile = "images/button_wr.png",
			onPress = moveToConnect15
		}
	)
	button_wr_15.x = 580
	button_wr_15.y = 10710

	-- 더보기 버튼, 댓글쓰기 버튼16
	local function moveToConnect16(event)
		composer.gotoScene("b2Connect16")		--2019년 2월 8일
	end

	local button_more_16 = widget.newButton(
		{
			width = 140,
			height = 60,
			defaultFile = "images/button_more.png",
			onPress = moveToConnect16
		}
	)
	button_more_16.x = 580
	button_more_16.y = 11383

	local button_wr_16 = widget.newButton(
		{
			width = 140,
			height = 60,
			defaultFile = "images/button_wr.png",
			onPress = moveToConnect16
		}
	)
	button_wr_16.x = 580
	button_wr_16.y = 11453

	-- 댓글쓰기 버튼17
	local function moveToConnect17(event)
		composer.gotoScene("b2Connect17")		--2018년 12월 22일
	end

	local button_wr_17 = widget.newButton(
		{
			width = 140,
			height = 60,
			defaultFile = "images/button_wr.png",
			onPress = moveToConnect17
		}
	)
	button_wr_17.x = 580
	button_wr_17.y = 11803

	-- 댓글쓰기 버튼18
	local function moveToConnect18(event)
		composer.gotoScene("b2Connect18")		--2018년 11월 17일
	end

	local button_wr_18 = widget.newButton(
		{
			width = 140,
			height = 60,
			defaultFile = "images/button_wr.png",
			onPress = moveToConnect18
		}
	)
	button_wr_18.x = 580
	button_wr_18.y = 12848

	-- 더보기 버튼, 댓글쓰기 버튼19
	local function moveToConnect19(event)
		composer.gotoScene("b2Connect19")		--2019년 10월 2일
	end

	local button_more_19 = widget.newButton(
		{
			width = 140,
			height = 60,
			defaultFile = "images/button_more.png",
			onPress = moveToConnect19
		}
	)
	button_more_19.x = 580
	button_more_19.y = 13399

	local button_wr_19 = widget.newButton(
		{
			width = 140,
			height = 60,
			defaultFile = "images/button_wr.png",
			onPress = moveToConnect19
		}
	)
	button_wr_19.x = 580
	button_wr_19.y = button_more_19.y + 70

	-- 댓글쓰기 버튼20
	local function moveToConnect20(event)
		composer.gotoScene("b2Connect20")		--2018년 8월 10일
	end

	local button_wr_20 = widget.newButton(
		{
			width = 140,
			height = 60,
			defaultFile = "images/button_wr.png",
			onPress = moveToConnect20
		}
	)
	button_wr_20.x = 580
	button_wr_20.y = 13850

	-- 댓글쓰기 버튼21
	local function moveToConnect21(event)
		composer.gotoScene("b2Connect21")		--2018년 8월 6일
	end

	local button_wr_21 = widget.newButton(
		{
			width = 140,
			height = 60,
			defaultFile = "images/button_wr.png",
			onPress = moveToConnect21
		}
	)
	button_wr_21.x = 580
	button_wr_21.y = 15003

	-- 더보기 버튼, 댓글쓰기 버튼22
	local function moveToConnect22(event)
		composer.gotoScene("b2Connect22")		--2019년 7월 30일
	end

	local button_more_22 = widget.newButton(
		{
			width = 140,
			height = 60,
			defaultFile = "images/button_more.png",
			onPress = moveToConnect22
		}
	)
	button_more_22.x = 580
	button_more_22.y = 15570

	local button_wr_22 = widget.newButton(
		{
			width = 140,
			height = 60,
			defaultFile = "images/button_wr.png",
			onPress = moveToConnect22
		}
	)
	button_wr_22.x = 580
	button_wr_22.y = button_more_22.y + 70

	-- 댓글쓰기 버튼23
	local function moveToConnect23(event)
		composer.gotoScene("b2Connect23")		--2018년 7월 13일
	end

	local button_wr_23 = widget.newButton(
		{
			width = 140,
			height = 60,
			defaultFile = "images/button_wr.png",
			onPress = moveToConnect23
		}
	)
	button_wr_23.x = 580
	button_wr_23.y = 16613

	-- 더보기 버튼, 댓글쓰기 버튼24
	local function moveToConnect24(event)
		composer.gotoScene("b2Connect24")		--2019년 6월 20일
	end

	local button_more_24 = widget.newButton(
		{
			width = 140,
			height = 60,
			defaultFile = "images/button_more.png",
			onPress = moveToConnect24
		}
	)
	button_more_24.x = 580
	button_more_24.y = 17209

	local button_wr_24 = widget.newButton(
		{
			width = 140,
			height = 60,
			defaultFile = "images/button_wr.png",
			onPress = moveToConnect24
		}
	)
	button_wr_24.x = 580
	button_wr_24.y = button_more_24.y + 70

	-- 댓글쓰기 버튼25
	local function moveToConnect25(event)
		composer.gotoScene("b2Connect25")		--2018년 6월 3일
	end

	local button_wr_25 = widget.newButton(
		{
			width = 140,
			height = 60,
			defaultFile = "images/button_wr.png",
			onPress = moveToConnect25
		}
	)
	button_wr_25.x = 580
	button_wr_25.y = 17610

	scrollView:insert( connectFrame1 )
	scrollView:insert( connectFrame2 )
	scrollView:insert( connectFrame3 )
	scrollView:insert( connectFrame4 )
	scrollView:insert( connectFrame5 )
	scrollView:insert( connectFrame6 )
	scrollView:insert( connectFrame7 )
	scrollView:insert( connectFrame8 )

	--scrollView:insert( backButton )

	scrollView:insert( button_more_1 )
	scrollView:insert( button_wr_1 )
	scrollView:insert( button_wr_2 )
	scrollView:insert( button_more_3 )
	scrollView:insert( button_wr_3 )
	scrollView:insert( button_more_4 )
	scrollView:insert( button_wr_4 )
	scrollView:insert( button_wr_5 )
	scrollView:insert( button_wr_6 )
	scrollView:insert( button_more_7 )
	scrollView:insert( button_wr_7 )
	scrollView:insert( button_wr_8 )
	scrollView:insert( button_wr_9 )
	scrollView:insert( button_wr_10 )
	scrollView:insert( button_wr_11 )
	scrollView:insert( button_wr_12 )
	scrollView:insert( button_wr_13 )
	scrollView:insert( button_more_14 )
	scrollView:insert( button_wr_14 )
	scrollView:insert( button_wr_15 )
	scrollView:insert( button_more_16 )
	scrollView:insert( button_wr_16 )
	scrollView:insert( button_wr_17 )
	scrollView:insert( button_wr_18 )
	scrollView:insert( button_more_19 )
	scrollView:insert( button_wr_19 )
	scrollView:insert( button_wr_20 )
	scrollView:insert( button_wr_21 )
	scrollView:insert( button_more_22 )
	scrollView:insert( button_wr_22 )
	scrollView:insert( button_wr_23 )
	scrollView:insert( button_more_24 )
	scrollView:insert( button_wr_24 )
	scrollView:insert( button_wr_25 )


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

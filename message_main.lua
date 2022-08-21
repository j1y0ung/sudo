-----------------------------------------------------------------------------------------
--
-- message_main.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()
local widget = require( "widget" )
local Num = 0
local font = "font/KM.ttf"

local sqlite3 = require( "sqlite3" )
local path = system.pathForFile( "data.db", system.DocumentsDirectory )
local db = sqlite3.open( path )

-- 단서노트 클릭
local function gotoCluenote()
    print("단서노트 클릭")
    composer.removeScene("message_main")
    composer.gotoScene("clueNote")
end

-- 홈버튼 클릭
local function gotoHome()
    print("홈버튼 클릭")
    composer.removeScene("message_main")
    composer.gotoScene("game_main")
end

-- 뒤로가기 버튼 클릭
local function gotoBack()
    print("뒤로가기 버튼 클릭")
    composer.removeScene("message_main")
    composer.gotoScene("game_main")
end

local function dbClick(event)
	if event.target.id == 'yang' then
		print("지영맘")
		db:exec([[UPDATE clue SET opened = 'TRUE' WHERE name = '문자' AND content = '지영맘';]]) 
	elseif event.target.id == 'debt' then
		print("빠른캐시")
		db:exec([[UPDATE clue SET opened = 'TRUE' WHERE name = '문자' AND content = '빠른캐시';]]) 
	end
end

function scene:create( event )
	local sceneGroup = self.view
	
	local background = display.newRect( display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight )
	background:setFillColor( 0.8 )	-- white

	local background_m = display.newRect( 500, 100, 1000, 200 )
	background_m:setFillColor( 0.8 )   
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


	local line = display.newRect( 300, 200, 1400, 10 )
	line:setFillColor( 0 )   

	local app_N = display.newText("메시지", 130, 130, font, 100)
    app_N:setFillColor( 0 )



    local function scrollListener( event )
 
    local phase = event.phase
    if ( phase == "began" ) then print( "Scroll view was touched" )
    elseif ( phase == "moved" ) then print( "Scroll view was moved" )
    elseif ( phase == "ended" ) then print( "Scroll view was released" )
    end
 
    -- In the event a scroll limit is reached...
    if ( event.limitReached ) then
       if ( event.direction == "up" ) then print( "Reached bottom limit" )
        elseif ( event.direction == "down" ) then print( "Reached top limit" )
        elseif ( event.direction == "left" ) then print( "Reached right limit" )
        elseif ( event.direction == "right" ) then print( "Reached left limit" )
        end
    end
 
    return true
end

local scrollView = widget.newScrollView(
    {
        top = 200,
        left = 0,
        width = 2000,
        height = 1000,
        scrollWidth = 10,
        scrollHeight = 10,
        horizontalScrollDisabled = true,
        hideBackground = true,
        listener = scrollListener,
        scrollBarOptions = {
            sheet = scrollBarSheet,
            topFrame = 1,
            middleFrame = 2,
            bottomFrame = 3
        }
    }
)

    local Yang = display.newRect( 300, 105, 1000, 200 )
    Yang.id = "yang"
	Yang:setFillColor( 0.8 )   -- white
	local person_y = display.newImageRect("001-user.png", 150, 150, 100, 100)
	person_y.x, person_y.y = 125, 105
	scrollView:insert( Yang )
	scrollView:insert( person_y )
	local n_y = display.newText("지영맘", 305, 50, font, 70)
    n_y:setFillColor( 0 )
    scrollView:insert( n_y )

    local Card = display.newRect( 300, 305, 1000, 200 )
	Card:setFillColor( 0.5 )   -- white
	local person_c = display.newImageRect("001-user.png", 150, 150, 100, 100)
	person_c.x, person_c.y = 125, 305
	local n_c = display.newText("1588-1588", 325, 250, font, 50)
    n_c:setFillColor( 0 )
	scrollView:insert( Card )
	scrollView:insert( person_c )
	scrollView:insert( n_c )

	local Debt = display.newRect( 300, 505, 1000, 200 )
	Debt.id = "debt"
	Debt:setFillColor( 0.8 )   -- white
	local person_d = display.newImageRect("001-user.png", 150, 150, 100, 100)
	person_d.x, person_d.y = 125, 505
	local n_d = display.newText("빠른캐시", 315, 450, font, 70)
    n_d:setFillColor( 0 )
	scrollView:insert( Debt )
	scrollView:insert( person_d )
	scrollView:insert( n_d )

	local Father = display.newRect(300, 705, 1000, 200 )
	Father:setFillColor( 0.5 )   -- white
	local person_f = display.newImageRect("001-user.png",150, 150, 100, 100)
	person_f.x, person_f.y = 125, 705
	local n_f = display.newText("아버지", 305, 650, font, 70)
    n_f:setFillColor( 0 )
	scrollView:insert( Father )
	scrollView:insert( person_f )
	scrollView:insert( n_f )


	local dEli = display.newRect(300, 905, 1000, 200 )
	dEli:setFillColor( 0.8)   -- white
	local person_e = display.newImageRect("001-user.png",150, 150, 100, 100)
	person_e.x, person_e.y = 125, 905
	local n_d = display.newText("010-1234-5678", 385, 850, font, 50)
    n_d:setFillColor( 0 )
	scrollView:insert( dEli )
	scrollView:insert( person_e )
	scrollView:insert( n_d )

	local Hus = display.newRect(300, 1105, 1000, 200 )
	Hus:setFillColor( 0.5 )   -- white
	local person_h = display.newImageRect("001-user.png",150, 150, 100, 100)
	person_h.x, person_h.y = 125, 1105
	local n_h = display.newText("남편", 265, 1050, font, 70)
    n_h:setFillColor( 0 )
	scrollView:insert( Hus )
	scrollView:insert( person_h )
	scrollView:insert( n_h )

	--local curscene = composer.showOverlay("yang", options)
	local function gotoM_B_Y(event)
		dbClick(event)
        composer.removeScene("message_main")
		composer.gotoScene("yang")
		print("양")
	end

	local function gotoM_B_C()
		composer.removeScene("message_main")
        composer.gotoScene("bank")
		print("카드")
	end

	local function gotoM_B_D(event)
		dbClick(event)
		composer.removeScene("message_main")
        	composer.gotoScene("debt")
		print("빠른캐시")
	end

	local function gotoM_B_H()
		composer.removeScene("message_main")
        composer.gotoScene("hus")
	end

	local function gotoM_B_E()
		composer.removeScene("message_main")
        composer.gotoScene("deli")
	end

	local function gotoM_B_F()
		composer.removeScene("message_main")
        composer.gotoScene("father")
	end

	Yang:addEventListener("tap", gotoM_B_Y)
	Card:addEventListener("tap", gotoM_B_C)
	Debt:addEventListener("tap", gotoM_B_D)
	Hus:addEventListener("tap", gotoM_B_H)
	Father:addEventListener("tap", gotoM_B_F)
	dEli:addEventListener("tap", gotoM_B_E)


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
    
    sceneGroup:insert(background)
    sceneGroup:insert(background_m)
    sceneGroup:insert(line)
    sceneGroup:insert(app_N)
    sceneGroup:insert(scrollView)
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
composer.hideOverlay( true, "fade", 400 )
-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene

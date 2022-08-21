-----------------------------------------------------------------------------------------
--
-- recorder.lua
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
    composer.removeScene("recorder")
    composer.gotoScene("clueNote")
end

-- 홈버튼 클릭
local function gotoHome()
    print("홈버튼 클릭")
    composer.removeScene("recorder")
    composer.gotoScene("game_main")
end

-- 뒤로가기 버튼 클릭
local function gotoBack()
    print("뒤로가기 버튼 클릭")
    composer.removeScene("recorder")
    composer.gotoScene("game_main")
end

-- db랑 연결할 부분
local function dbClick( event )
    if event.name == "recPsw" then
        print("dbClick completed!!!+"..event.name)
        db:exec([[UPDATE clue SET opened = 'TRUE' WHERE name = '밴드' AND content = '비밀번호(녹음)';]]) 
    elseif event.name == "recDebt" then
        print("dbClick completed!!!+"..event.name)
        db:exec([[UPDATE clue SET opened = 'TRUE' WHERE name = '녹음' AND content = '빠른캐시';]]) 
    end
end 

 -- 조건: 톡톡, 커넥트가 오픈되어 있고 녹음앱이 실행되었을때
 -- 낰낰 코드 참고
local band_data
for row in db:nrows("SELECT * FROM status WHERE name = '밴드'") do
    band_data = row.opened
    --print("밴드 찾음")
end

local talk_data
for row in db:nrows("SELECT * FROM status WHERE name = '톡톡'") do
    talk_data = row.opened
    --print("톡톡 찾음")
end

if talk_data == 'TRUE' and band_data == 'TRUE' then
    local event = {name = "recPsw"}
    dbClick(event)
end

-- 조건 : 녹음-빠른캐시 : ‘녹음’ 앱 비밀번호가 해지되면 true로 바뀜
local record_data
for row in db:nrows("SELECT * FROM status WHERE name = '녹음'") do
    record_data = row.opened
    --print("녹음 찾음")
end

if record_data == 'TRUE' then
    local event = {name = "recDebt"}
    dbClick(event)
end


-- 녹음 내역으로 가기
local function gotoReList(e)
    local id = e.target.id
    local recordNum = 0

    if id == '200201' then
        print("200201 클릭")
        recordNum = 0
    elseif id == '200127' then
        print("200127 클릭")
        recordNum = 1
    elseif id == '200115' then
        print("200115 클릭")
        recordNum = 2
    elseif id == '200109' then
        print("200109 클릭")
        recordNum = 3
    elseif id == '191229' then
        print("191229 클릭")
        recordNum = 4    
    elseif  id == '191207' then
        print("191207 클릭")
        recordNum = 5
    elseif id == '191022' then
        print("191022 클릭")
        recordNum = 6   
    elseif id == '190917' then
        print("190917 클릭")
        recordNum = 7         
    elseif id == '190824' then
        print("190824 클릭")
        recordNum = 8  
    elseif id == '190815' then
        print("190815 클릭")
        recordNum = 9  
    end
    print(recordNum)

    composer.setVariable("recordNum", recordNum)
    composer.removeScene("recorder")
    composer.gotoScene("reList")
end

-- 홈버튼 클릭
local function gotoHome()
    print("홈버튼 클릭")
    composer.removeScene("recorder")
    composer.gotoScene("game_main")
end

-- 뒤로가기 버튼 클릭
local function gotoBack()
    print("뒤로가기 버튼 클릭")
    composer.removeScene("recorder")
    composer.gotoScene("game_main")
end


function scene:create( event )
    local sceneGroup = self.view
    
    local background = display.newRect( display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight )
    background:setFillColor( 0.1, 0.1, 0.1 ) -- 어두운 회색
    
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
            top = 80,
            left = 0,
            width = display.contentWidth,
            height = 1080,
            isBounceEnabled = false,
            listener = scrollListener,
            horizontalScrollDisabled = true,
            backgroundColor = {0.1, 0.1, 0.1}
        }
    )
    
   -- local bg = display.newRect(display.contentCenterX, display.contentCenterY, display.contentWidth, 1800)
    --bg:setFillColor( 0.1, 0.1, 0.1 ) -- 어두운 회색

    local title = display.newText("녹음 목록", 180, 70, font, 50)

    local reList1 = widget.newButton(
        {
            id = "200201",
            left = 20,
            top = 150,
            width = display.contentWidth-40,
            height = 160,
            defaultFile = "images/button_rec200201.png",
            onRelease = gotoReList
        }
    )

    local reList2 = widget.newButton(
        {
            id = "200127",
            left = 20,
            top = 350,
            width = display.contentWidth-40,
            height = 160,
            defaultFile = "images/button_rec200127.png",
            onRelease = gotoReList
        }
    )

    local reList3 = widget.newButton(
        {
            id = "200115",
            left = 20,
            top = 550,
            width = display.contentWidth-40,
            height = 160,
            defaultFile = "images/button_rec200115.png",
            onRelease = gotoReList
        }
    )

    local reList4 = widget.newButton(
        {
            id = "200109",
            left = 20,
            top = 750,
            width = display.contentWidth-40,
            height = 160,
            defaultFile = "images/button_rec200109.png",
            onRelease = gotoReList
        }
    )

    local reList5 = widget.newButton(
        {
            id = "191229",
            left = 20,
            top = 950,
            width = display.contentWidth-40,
            height = 160,
            defaultFile = "images/button_rec191229.png",
            onRelease = gotoReList
        }
    )

    local reList6 = widget.newButton(
        {
            id = "191207",
            left = 20,
            top = 1150,
            width = display.contentWidth-40,
            height = 160,
            defaultFile = "images/button_rec191207.png",
            onRelease = gotoReList
        }
    )

    local reList7 = widget.newButton(
        {
            id = "191022",
            left = 20,
            top = 1350,
            width = display.contentWidth-40,
            height = 160,
            defaultFile = "images/button_rec191022.png",
            onRelease = gotoReList
        }
    )

    local reList8 = widget.newButton(
        {
            id = "190917",
            left = 20,
            top = 1550,
            width = display.contentWidth-40,
            height = 160,
            defaultFile = "images/button_rec190917.png",
            onRelease = gotoReList
        }
    )

    local reList9 = widget.newButton(
        {
            id = "190824",
            left = 20,
            top = 1750,
            width = display.contentWidth-40,
            height = 160,
            defaultFile = "images/button_rec190824.png",
            onRelease = gotoReList
        }
    )

    local reList10 = widget.newButton(
        {
            id = "190815",
            left = 20,
            top = 1950,
            width = display.contentWidth-40,
            height = 160,
            defaultFile = "images/button_rec190815.png",
            onRelease = gotoReList
        }
    )

    --scrollView:insert( bg )
    scrollView:insert( title )
    scrollView:insert( reList1 )
    scrollView:insert( reList2 )
    scrollView:insert( reList3 )
    scrollView:insert( reList4 )
    scrollView:insert( reList5 )
    scrollView:insert( reList6 )
    scrollView:insert( reList7 )
    scrollView:insert( reList8 )
    scrollView:insert( reList9 )
    scrollView:insert( reList10 )

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

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene

-----------------------------------------------------------------------------------------
--
-- game_main.lua -- 홈화면
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local widget = require("widget")
local scene = composer.newScene()
local font = "font/KM.ttf"
local time = os.date( '*t' )
local start = composer.getVariable("start")
local i = 1
local dorian = {}
dorian[1] = composer.getVariable("dorian_m")
dorian[2] = composer.getVariable("dorian_b")
dorian[3] = composer.getVariable("dorian_g")
dorian[4] = 1

for i = 1, 3, 1 do
    if dorian[i] == 1 then
            dorian[4] = dorian[4] + 1
    end
    if dorian[4] == 4 then
        start = dorian[4]
    end
end

-- 밴드 클릭
local function gotoBand()
    print("밴드 클릭")
    composer.removeScene("game_main" )
	composer.gotoScene("band_password")
end

-- 은행 클릭
local function gotoBank()
    print("은행 클릭")
    composer.removeScene("game_main" )
	composer.gotoScene("bank_password")
end

-- 캘린더 클릭
local function gotoCalendar()
    print("캘린더 클릭")
    composer.removeScene("game_main")
	composer.gotoScene("view1")
end

-- 갤러리 클릭
local function gotoGallery()
    print("갤러리 클릭")
    composer.removeScene("game_main")
	composer.gotoScene("gallery_main")
end

-- 전화 클릭
local function gotoCall()
	print("전화 클릭")
    composer.removeScene("game_main")
	composer.gotoScene("cView2")
end

-- 메시지 클릭
local function gotoMessage()
    print("메시지 클릭")
    composer.removeScene("game_main")
	composer.gotoScene("message_main")
end

-- 톡톡 클릭
local function gotoTalk()
    print("톡톡 클릭")
    composer.removeScene("game_main")
	composer.gotoScene("talk_password")
end

-- 녹음 클릭
local function gotoRecorder()
    print("녹음 클릭")
    composer.removeScene("game_main")
    composer.gotoScene("recorder_password")
end

-- 단서노트 클릭
local function gotoCluenote()
    print("단서노트 클릭")
    composer.removeScene(composer.getSceneName( "current" ))
    composer.gotoScene("clueNote")
end

-- 홈버튼 클릭
local function gotoHome()
    print("홈으로가기")
    composer.removeScene(composer.getSceneName( "current" ))
    composer.gotoScene("game_main")
end

-- 뒤로가기 버튼 클릭
local function gotoBack()
    print("뒤로가기")
    composer.removeScene(composer.getSceneName( "current" ))
    composer.gotoScene(composer.getSceneName( "previous" ))
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
    local time = display.newText(h..":"..m, 80, 40, defaultFont)

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
    local battery_t = display.newText("34%", 585, 40, defaultFont)
    local battery = display.newImageRect("imgsources/w_battery.png", 70, 45)
    battery.x, battery.y = 650, 40

    --------------------------------------------------------------------------------------------

    -- 홈화면 앱들
    -- 밴드
    local bandBtn = widget.newButton(
        {
            id = "bandbtn",
            left = 30,
            top = 120,
            width = 150,
            height = 150,
            defaultFile = "imgsources/b_band.png",
            onRelease = gotoBand
        }
    )
    local band_t = display.newText("CONNECT", 107, 290, defaultFont)
    
    -- 은행
    local bankBtn = widget.newButton(
        {
            id = "bankbtn",
            left = 200,
            top = 120,
            width = 150,
            height = 150,
            defaultFile = "imgsources/b_bank.png",
            onRelease = gotoBank
        }
    )
    local bank_t = display.newText("M뱅크", 280, 290, defaultFont)

    -- 캘린더
    local calendarBtn = widget.newButton(
        {
            id = "calendarbtn",
            left = 370,
            top = 120,
            width = 150,
            height = 150,
            defaultFile = "imgsources/b_calendar.png",
            onRelease = gotoCalendar
        }
    )
    local calnendar_t = display.newText("캘린더", 445, 290, defaultFont)

    -- 갤러리
    local galleryBtn = widget.newButton(
        {
            id = "calendarbtn",
            left = 540,
            top = 120,
            width = 150,
            height = 150,
            defaultFile = "imgsources/b_gallery.png",
            onRelease = gotoGallery
        }
    )
    local gallery_t = display.newText("갤러리", 615, 290, defaultFont)
    
    -- 전화
    local callBtn = widget.newButton(
        {
            id = "callbtn",
            left = 30,
            top = 950,
            width = 150,
            height = 150,
            defaultFile = "imgsources/b_call.png",
            onRelease = gotoCall
        }
    )
    local call_t = display.newText("전화", 107, 1120, defaultFont)
    
    -- 메세지
    local messageBtn = widget.newButton(
        {
            id = "messagebtn",
            left = 200,
            top = 950,
            width = 150,
            height = 150,
            defaultFile = "imgsources/b_message.png",
            onRelease = gotoMessage
        }
    )
    local message_t = display.newText("메시지", 275, 1120, defaultFont)
    
    -- 톡톡
    local talkBtn = widget.newButton(
        {
            id = "talkbtn",
            left = 370,
            top = 950,
            width = 150,
            height = 150,
            defaultFile = "imgsources/b_talk.png",
            onRelease = gotoTalk
        }
    )
    local talk_t = display.newText("톡톡", 445, 1120, defaultFont)

    -- 녹음
    local recorderBtn = widget.newButton(
        {
            id = "recorderbtn",
            left = 547,
            top = 955,
            width = 135,
            height = 135,
            defaultFile = "imgsources/b_recorder.png",
            onRelease = gotoRecorder
        }
    )
    local recorder_t = display.newText("녹음", 615, 1120, defaultFont)
    
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
    sceneGroup:insert(bankBtn)
    sceneGroup:insert(bank_t)
    sceneGroup:insert(bandBtn)
    sceneGroup:insert(band_t)
    sceneGroup:insert(calendarBtn)
    sceneGroup:insert(calnendar_t)
    sceneGroup:insert(galleryBtn)
    sceneGroup:insert(gallery_t)
    sceneGroup:insert(callBtn)
    sceneGroup:insert(call_t)
    sceneGroup:insert(messageBtn)
    sceneGroup:insert(message_t)
    sceneGroup:insert(talkBtn)
    sceneGroup:insert(talk_t)
    sceneGroup:insert(recorderBtn)
    sceneGroup:insert(recorder_t)
    sceneGroup:insert(bottombar)
    sceneGroup:insert(noteBtn)
    sceneGroup:insert(homeBtn)
    sceneGroup:insert(backBtn)
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
	elseif phase == "did" then
	end	
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then
	elseif phase == "did" then
	end
end

function scene:destroy( event )
	local sceneGroup = self.view
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene
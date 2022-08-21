-----------------------------------------------------------------------------------------
--
-- gallery_main.lua -- 갤러리 메인화면
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local widget = require("widget")
local scene = composer.newScene()
local font = "font/KM.ttf"

-- 일반 앨범 클릭
local function gotoAlbum()
    print("일반앨범 클릭")
    composer.removeScene("gallery_main")
    composer.gotoScene("album")
end

-- 잠긴 앨범 클릭
local function gotoLockedAlbum()
    print("잠긴앨범 클릭")
    composer.removeScene("gallery_main")
    composer.gotoScene("albumPwd")
end

-- 단서노트 클릭
local function gotoCluenote()
    print("단서노트 클릭")
    composer.removeScene("gallery_main")
    composer.gotoScene("clueNote")
end

-- 홈버튼 클릭
local function gotoHome()
    print("홈으로가기")
    composer.removeScene("gallery_main")
    composer.gotoScene("game_main")
end

-- 뒤로가기 버튼 클릭
local function gotoBack()
    print("뒤로가기")
    composer.removeScene("gallery_main")
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

    --------------------------------------------------------------------------------------------

    -- 갤러리 내부
    -- 일반 앨범
    local album = widget.newButton(
        {
            id = "albumbtn",
            left = 40,
            top = 150,
            width = 300,
            height = 300,
            defaultFile = "imgsources/albumcover.png",
            onRelease = gotoAlbum
        }
    )
    local album_t = display.newText("사진", 190, 480, font, 45)

    -- 잠긴 앨범
    local lockedAlbum = widget.newButton(
        {
            id = "lockedAlbumbtn",
            left = 390,
            top = 150,
            width = 300,
            height = 300,
            defaultFile = "imgsources/lockedAlbumcover.png",
            onRelease = gotoLockedAlbum
        }
    )
    local locked_album_t = display.newText("잠긴 앨범", 540, 480, font, 45)
    
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
    sceneGroup:insert(topbar)
    sceneGroup:insert(album)
    sceneGroup:insert(album_t)
    sceneGroup:insert(locked_album_t)
    sceneGroup:insert(lockedAlbum)
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
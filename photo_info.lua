-----------------------------------------------------------------------------------------
--
-- photo_info.lua -- 사진 상세정보
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local widget = require("widget")
local scene = composer.newScene()
local font = "font/KM.ttf"

local infoN = composer.getVariable("infoNum") -- photo.lua 에서 받아온 인자
print("photo.lua에서 받아온 infoNum값", infoN)

-- 단서노트 클릭
local function gotoCluenote()
    print("단서노트 클릭")
    composer.removeScene("photo_info")
    composer.gotoScene("clueNote")
end

-- 홈버튼 클릭
local function gotoHome()
    print("홈버튼 클릭")
    composer.removeScene("photo_info")
    composer.gotoScene("game_main")
end

-- 뒤로가기 버튼 클릭
local function gotoBack()
    print("뒤로가기 버튼 클릭")
    composer.removeScene("photo_info")
    composer.gotoScene("photo")
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
    
    -- 사진 & 상세정보
    local photo0 = display.newImageRect("photo/pray_photo.jpg", 720, 700)
    photo0.alpha = 0
    photo0.x, photo0.y = 360, 640
    local photo0_info = display.newImageRect("photo/pray_info.png", 500, 200)
    photo0_info.x, photo0_info.y = 280, 640
    photo0_info.alpha = 0
    local photo1 = display.newImageRect("photo/pig_photo.jpg", 720, 700)
    photo1.alpha = 0
    photo1.x, photo1.y = 360, 640
    local photo1_info = display.newImageRect("photo/pig_info.png", 500, 200)
    photo1_info.x, photo1_info.y = 280, 640
    photo1_info.alpha = 0
    local photo2 = display.newImageRect("photo/bible_photo.jpg", 720, 700)
    photo2.alpha = 0
    photo2.x, photo2.y = 360, 640
    local photo2_info = display.newImageRect("photo/bible_info.png", 500, 200)
    photo2_info.x, photo2_info.y = 280, 640
    photo2_info.alpha = 0
    local photo3 = display.newImageRect("photo/flower_photo.jpg", 720, 700)
    photo3.alpha = 0
    photo3.x, photo3.y = 360, 640
    local photo3_info = display.newImageRect("photo/flower_info.png", 500, 200)
    photo3_info.x, photo3_info.y = 280, 640
    photo3_info.alpha = 0
    local photo4 = display.newImageRect("photo/market_photo.jpg", 720, 700)
    photo4.alpha = 0
    photo4.x, photo4.y = 360, 640
    local photo4_info = display.newImageRect("photo/market_info.png", 500, 200)
    photo4_info.x, photo4_info.y = 280, 640
    photo4_info.alpha = 0
    local photo5 = display.newImageRect("photo/plant_photo.jpg", 720, 700)
    photo5.alpha = 0
    photo5.x, photo5.y = 360, 640
    local photo5_info = display.newImageRect("photo/plant_info.png", 500, 200)
    photo5_info.x, photo5_info.y = 280, 640
    photo5_info.alpha = 0
    local photo6 = display.newImageRect("photo/flowerPattern_photo.jpg", 720, 700)
    photo6.alpha = 0
    photo6.x, photo6.y = 360, 640
    local photo6_info = display.newImageRect("photo/flowerPattern_info.png", 500, 200)
    photo6_info.x, photo6_info.y = 280, 640
    photo6_info.alpha = 0
    local photo7 = display.newImageRect("photo/walk_photo.jpg", 720, 700)
    photo7.alpha = 0
    photo7.x, photo7.y = 360, 640
    local photo7_info = display.newImageRect("photo/walk_info.png", 500, 200)
    photo7_info.x, photo7_info.y = 280, 640
    photo7_info.alpha = 0
    local photo8 = display.newImageRect("photo/gwanghwa_photo.jpg", 720, 700)
    photo8.alpha = 0
    photo8.x, photo8.y = 360, 640
    local photo8_info = display.newImageRect("photo/gwanghwa_info.png", 500, 200)
    photo8_info.x, photo8_info.y = 280, 640
    photo8_info.alpha = 0
    local photo9 = display.newImageRect("photo/stream_photo.jpg", 720, 700)
    photo9.alpha = 0
    photo9.x, photo9.y = 360, 640
    local photo9_info = display.newImageRect("photo/stream_info.png", 500, 200)
    photo9_info.x, photo9_info.y = 280, 640
    photo9_info.alpha = 0
    local photo10 = display.newImageRect("photo/horse_photo.jpg", 720, 700)
    photo10.alpha = 0
    photo10.x, photo10.y = 360, 640
    local photo10_info = display.newImageRect("photo/horse_info.png", 500, 200)
    photo10_info.x, photo10_info.y = 280, 640
    photo10_info.alpha = 0
    local photo11 = display.newImageRect("photo/city_photo.jpg", 720, 700)
    photo11.alpha = 0
    photo11.x, photo11.y = 360, 640
    local photo11_info = display.newImageRect("photo/city_info.png", 500, 200)
    photo11_info.x, photo11_info.y = 280, 640
    photo11_info.alpha = 0
    local photo12 = display.newImageRect("photo/children_photo.png", 720, 700)
    photo12.alpha = 0
    photo12.x, photo12.y = 360, 640
    local photo12_info = display.newImageRect("photo/children_info.png", 500, 200)
    photo12_info.x, photo12_info.y = 280, 640
    photo12_info.alpha = 0
    local photo13 = display.newImageRect("photo/mombirthday_photo.jpg", 720, 700)
    photo13.alpha = 0
    photo13.x, photo13.y = 360, 640
    local photo13_info = display.newImageRect("photo/mombirthday_info.png", 500, 200)
    photo13_info.x, photo13_info.y = 280, 640
    photo13_info.alpha = 0
    local photo14 = display.newImageRect("photo/three_photo.jpg", 720, 700)
    photo14.alpha = 0
    photo14.x, photo14.y = 360, 640
    local photo14_info = display.newImageRect("photo/three_info.png", 500, 200)
    photo14_info.x, photo14_info.y = 280, 640
    photo14_info.alpha = 0
    local photo15 = display.newImageRect("photo/baby_photo.jpg", 720, 700)
    photo15.alpha = 0
    photo15.x, photo15.y = 360, 640
    local photo15_info = display.newImageRect("photo/baby_info.png", 500, 200)
    photo15_info.x, photo15_info.y = 280, 640
    photo15_info.alpha = 0
    local photo16 = display.newImageRect("photo/child_photo.jpg", 720, 700)
    photo16.alpha = 0
    photo16.x, photo16.y = 360, 640
    local photo16_info = display.newImageRect("photo/child_info.png", 500, 200)
    photo16_info.x, photo16_info.y = 280, 640
    photo16_info.alpha = 0
    local photo17 = display.newImageRect("photo/man_photo.jpg", 720, 700)
    photo17.alpha = 0
    photo17.x, photo17.y = 360, 640
    local photo17_info = display.newImageRect("photo/man_info.png", 500, 200)
    photo17_info.x, photo17_info.y = 280, 640
    photo17_info.alpha = 0
    local photo18 = display.newImageRect("photo/candles_photo.jpg", 720, 700)
    photo18.alpha = 0
    photo18.x, photo18.y = 360, 640
    local photo18_info = display.newImageRect("photo/candles_info.png", 500, 200)
    photo18_info.x, photo18_info.y = 280, 640
    photo18_info.alpha = 0
    local photo19 = display.newImageRect("photo/childAbuse_photo.jpg", 720, 700)
    photo19.alpha = 0
    photo19.x, photo19.y = 360, 640
    local photo19_info = display.newImageRect("photo/childAbuse_info.png", 500, 200)
    photo19_info.x, photo19_info.y = 280, 640
    photo19_info.alpha = 0
    local photo20 = display.newImageRect("photo/childInjury_photo.png", 720, 700)
    photo20.alpha = 0
    photo20.x, photo20.y = 360, 640
    local photo20_info = display.newImageRect("photo/childInjury_info.png", 500, 200)
    photo20_info.x, photo20_info.y = 280, 640
    photo20_info.alpha = 0
    local photo21 = display.newImageRect("photo/worship_photo.jpg", 720, 700)
    photo21.alpha = 0
    photo21.x, photo21.y = 360, 640
    local photo21_info = display.newImageRect("photo/worship_info.png", 500, 200)
    photo21_info.x, photo21_info.y = 280, 640
    photo21_info.alpha = 0

    -- 상세정보 보이기
    if infoN == 0 then
        photo0.alpha = 0
        photo0_info.alpha = 1
    elseif infoN == 1 then
        photo1.alpha = 0
        photo1_info.alpha = 1
    elseif infoN == 2 then
        photo2.alpha = 0
        photo2_info.alpha = 1
    elseif infoN == 3 then
        photo3.alpha = 0
        photo3_info.alpha = 1
    elseif infoN == 4 then
        photo4.alpha = 0
        photo4_info.alpha = 1
    elseif infoN == 5 then
        photo5.alpha = 0
        photo5_info.alpha = 1
    elseif infoN == 6 then
        photo6.alpha = 0
        photo6_info.alpha = 1
    elseif infoN == 7 then
        photo7.alpha = 0
        photo7_info.alpha = 1
    elseif infoN == 8 then
        photo8.alpha = 0
        photo8_info.alpha = 1
    elseif infoN == 9 then
        photo9.alpha = 0
        photo9_info.alpha = 1
    elseif infoN == 10 then
        photo10.alpha = 0
        photo10_info.alpha = 1
    elseif infoN == 11 then
        photo11.alpha = 0
        photo11_info.alpha = 1
    elseif infoN == 12 then
        photo12.alpha = 0
        photo12_info.alpha = 1
    elseif infoN == 13 then
        photo13.alpha = 0
        photo13_info.alpha = 1
    elseif infoN == 14 then
        photo14.alpha = 0
        photo14_info.alpha = 1
    elseif infoN == 15 then
        photo15.alpha = 0
        photo15_info.alpha = 1
    elseif infoN == 16 then
        photo16.alpha = 0
        photo16_info.alpha = 1
    elseif infoN == 17 then
        photo17.alpha = 0
        photo17_info.alpha = 1
    elseif infoN == 18 then
        photo18.alpha = 0
        photo18_info.alpha = 1
    elseif infoN == 19 then
        photo19.alpha = 0
        photo19_info.alpha = 1
    elseif infoN == 20 then
        photo20.alpha = 0
        photo20_info.alpha = 1
    elseif infoN == 21 then
        photo21.alpha = 0
        photo21_info.alpha = 1
    end

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
    sceneGroup:insert(photo0)
    sceneGroup:insert(photo0_info)
    sceneGroup:insert(photo1)
    sceneGroup:insert(photo1_info)
    sceneGroup:insert(photo2)
    sceneGroup:insert(photo2_info)
    sceneGroup:insert(photo3)
    sceneGroup:insert(photo3_info)
    sceneGroup:insert(photo4)
    sceneGroup:insert(photo4_info)
    sceneGroup:insert(photo5)
    sceneGroup:insert(photo5_info)
    sceneGroup:insert(photo6)
    sceneGroup:insert(photo6_info)
    sceneGroup:insert(photo7)
    sceneGroup:insert(photo7_info)
    sceneGroup:insert(photo8)
    sceneGroup:insert(photo8_info)
    sceneGroup:insert(photo9)
    sceneGroup:insert(photo9_info)
    sceneGroup:insert(photo10)
    sceneGroup:insert(photo10_info)
    sceneGroup:insert(photo11)
    sceneGroup:insert(photo11_info)
    sceneGroup:insert(photo12)
    sceneGroup:insert(photo12_info)
    sceneGroup:insert(photo13)
    sceneGroup:insert(photo13_info)
    sceneGroup:insert(photo14)
    sceneGroup:insert(photo14_info)
    sceneGroup:insert(photo15)
    sceneGroup:insert(photo15_info)
    sceneGroup:insert(photo16)
    sceneGroup:insert(photo16_info)
    sceneGroup:insert(photo17)
    sceneGroup:insert(photo17_info)
    sceneGroup:insert(photo18)
    sceneGroup:insert(photo18_info)
    sceneGroup:insert(photo19)
    sceneGroup:insert(photo19_info)
    sceneGroup:insert(photo20)
    sceneGroup:insert(photo20_info)
    sceneGroup:insert(photo21)
    sceneGroup:insert(photo21_info)
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
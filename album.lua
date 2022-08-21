-----------------------------------------------------------------------------------------
--
-- album.lua -- album 내부
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local widget = require("widget")
local scene = composer.newScene()
local font = "font/KM.ttf"

-- 사진 클릭
local function gotoPhoto(e)
    local id = e.target.id
    local photoNum = 0

    if id == 'pray_photo' then
        print("기도사진 클릭")
        photoNum = 0
    elseif id == 'pig_photo' then
        print("외식사진 클릭")
        photoNum = 1
    elseif id == 'bible_photo' then
        print("성경사진 클릭")
        photoNum = 2
    elseif id == 'flower_photo' then
        print("꽃사진 클릭")
        photoNum = 3
    elseif id == 'market_photo' then
        print("재료준비사진 클릭")
        photoNum = 4
    elseif id == 'plant_photo' then
        print("화초들사진 클릭")
        photoNum = 5
    elseif id == 'flowerPattern_photo' then
        print("꽃자수사진 클릭")
        photoNum = 6
    elseif id == 'walk_photo' then
        print("대장정사진 클릭")
        photoNum = 7
    elseif id == 'gwanghwa_photo' then
        print("집회사진 클릭")
        photoNum = 8
    elseif id == 'stream_photo' then
        print("청계천나들이사진 클릭")
        photoNum = 9
    elseif id == 'horse_photo' then
        print("가족휴가사진 클릭")
        photoNum = 10
    elseif id == 'city_photo' then
        print("우리동네사진 클릭")
        photoNum = 11
    elseif id == 'children_photo' then
        print("아이들사진 클릭")
        photoNum = 12
    elseif id == 'mombirthday_photo' then
        print("엄마생신사진 클릭")
        photoNum = 13
    elseif id == 'three_photo' then
        print("행복했던시간사진 클릭")
        photoNum = 14
    elseif id == 'baby_photo' then
        print("둘째애기때사진사진 클릭")
        photoNum = 15
    elseif id == 'child_photo' then
        print("첫째애기때사진 클릭")
        photoNum = 16
    elseif id == 'man_photo' then
        print("남편사진 클릭")
        photoNum = 17
    end
    print(photoNum)

    composer.setVariable("photoNum", photoNum)
    composer.removeScene("album")
    composer.gotoScene("photo")
end

-- 단서노트 클릭
local function gotoCluenote()
    print("단서노트 클릭")
    composer.removeScene("album")
    composer.gotoScene("clueNote")
end

-- 홈버튼 클릭
local function gotoHome()
    print("홈버튼 클릭")
    composer.removeScene("album")
    composer.gotoScene("game_main")
end

-- 뒤로가기 버튼 클릭
local function gotoBack()
    print("뒤로가기 버튼 클릭")
    composer.removeScene("album")
    composer.gotoScene("gallery_main")
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

    -- 앨범 내부
    -- 앨범 바
    local albumbar = display.newRect(display.contentCenterX, 145, display.contentWidth, 125)
    albumbar:setFillColor( 0.166, 0.166, 0.166 )
    local album_name = display.newText("사진", 100, albumbar.y, native.systemFont, 60)
    
    -- 사진들
    -- 첫째줄
    local pray_photo = widget.newButton(
        {
            id = "pray_photo",
            left = 10,
            top = 220,
            width = 165,
            height = 165,
            defaultFile = "photo/pray_photo.jpg",
            onRelease = gotoPhoto
        }
    )
    local pig_photo = widget.newButton(
        {
            id = "pig_photo",
            left = 190,
            top = 220,
            width = 165,
            height = 165,
            defaultFile = "photo/pig_photo.jpg",
            onRelease = gotoPhoto
        }
    )

    local bible_photo = widget.newButton(
        {
            id = "bible_photo",
            left = 370,
            top = 220,
            width = 165,
            height = 165,
            defaultFile = "photo/bible_photo.jpg",
            onRelease = gotoPhoto
        }
    )

    local flower_photo = widget.newButton(
        {
            id = "flower_photo",
            left = 545,
            top = 220,
            width = 165,
            height = 165,
            defaultFile = "photo/flower_photo.jpg",
            onRelease = gotoPhoto
        }
    )
    -- 둘째줄
    local market_photo = widget.newButton(
        {
            id = "market_photo",
            left = 10,
            top = 395,
            width = 165,
            height = 165,
            defaultFile = "photo/market_photo.jpg",
            onRelease = gotoPhoto
        }
    )
    local plant_photo = widget.newButton(
        {
            id = "plant_photo",
            left = 190,
            top = 395,
            width = 165,
            height = 165,
            defaultFile = "photo/plant_photo.jpg",
            onRelease = gotoPhoto
        }
    )

    local flowerPattern_photo = widget.newButton(
        {
            id = "flowerPattern_photo",
            left = 370,
            top = 395,
            width = 165,
            height = 165,
            defaultFile = "photo/flowerPattern_photo.jpg",
            onRelease = gotoPhoto
        }
    )

    local walk_photo = widget.newButton(
        {
            id = "walk_photo",
            left = 545,
            top = 395,
            width = 165,
            height = 165,
            defaultFile = "photo/walk_photo.jpg",
            onRelease = gotoPhoto
        }
    )
    -- 셋째줄
    local gwanghwa_photo = widget.newButton(
        {
            id = "gwanghwa_photo",
            left = 10,
            top = 570,
            width = 165,
            height = 165,
            defaultFile = "photo/gwanghwa_photo.jpg",
            onRelease = gotoPhoto
        }
    )
    local stream_photo = widget.newButton(
        {
            id = "stream_photo",
            left = 190,
            top = 570,
            width = 165,
            height = 165,
            defaultFile = "photo/stream_photo.jpg",
            onRelease = gotoPhoto
        }
    )

    local horse_photo = widget.newButton(
        {
            id = "horse_photo",
            left = 370,
            top = 570,
            width = 165,
            height = 165,
            defaultFile = "photo/horse_photo.jpg",
            onRelease = gotoPhoto
        }
    )

    local city_photo = widget.newButton(
        {
            id = "city_photo",
            left = 545,
            top = 570,
            width = 165,
            height = 165,
            defaultFile = "photo/city_photo.jpg",
            onRelease = gotoPhoto
        }
    )
    -- 넷째줄
    local children_photo = widget.newButton(
        {
            id = "children_photo",
            left = 10,
            top = 745,
            width = 165,
            height = 165,
            defaultFile = "photo/children_photo.png",
            onRelease = gotoPhoto
        }
    )
    local mombirthday_photo = widget.newButton(
        {
            id = "mombirthday_photo",
            left = 190,
            top = 745,
            width = 165,
            height = 165,
            defaultFile = "photo/mombirthday_photo.jpg",
            onRelease = gotoPhoto
        }
    )

    local three_photo = widget.newButton(
        {
            id = "three_photo",
            left = 370,
            top = 745,
            width = 165,
            height = 165,
            defaultFile = "photo/three_photo.jpg",
            onRelease = gotoPhoto
        }
    )

    local baby_photo = widget.newButton(
        {
            id = "baby_photo",
            left = 545,
            top = 745,
            width = 165,
            height = 165,
            defaultFile = "photo/baby_photo.jpg",
            onRelease = gotoPhoto
        }
    )
    -- 다섯째줄
    local child_photo = widget.newButton(
        {
            id = "child_photo",
            left = 10,
            top = 920,
            width = 165,
            height = 165,
            defaultFile = "photo/child_photo.jpg",
            onRelease = gotoPhoto
        }
    )
    local man_photo = widget.newButton(
        {
            id = "man_photo",
            left = 190,
            top = 920,
            width = 165,
            height = 165,
            defaultFile = "photo/man_photo.jpg",
            onRelease = gotoPhoto
        }
    )

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
    sceneGroup:insert(albumbar)
    sceneGroup:insert(album_name)
    sceneGroup:insert(pray_photo)
    sceneGroup:insert(pig_photo)
    sceneGroup:insert(bible_photo)
    sceneGroup:insert(flower_photo)
    sceneGroup:insert(market_photo)
    sceneGroup:insert(plant_photo)
    sceneGroup:insert(flowerPattern_photo)
    sceneGroup:insert(walk_photo)
    sceneGroup:insert(gwanghwa_photo)
    sceneGroup:insert(stream_photo)
    sceneGroup:insert(horse_photo)
    sceneGroup:insert(city_photo)
    sceneGroup:insert(children_photo)
    sceneGroup:insert(mombirthday_photo)
    sceneGroup:insert(three_photo)
    sceneGroup:insert(baby_photo)
    sceneGroup:insert(child_photo)
    sceneGroup:insert(man_photo)
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
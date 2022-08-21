-----------------------------------------------------------------------------------------
--
-- photo.lua -- 사진 한장
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local widget = require("widget")
local scene = composer.newScene()
local font = "font/KM.ttf"

local sqlite3 = require( "sqlite3" )
local path = system.pathForFile( "data.db", system.DocumentsDirectory )
local db = sqlite3.open( path )

local photoN = composer.getVariable("photoNum") -- album.lua 에서 받아온 인자
print("album.lua에서 받아온 photoNum값", photoN)

-- db 반영 사항
local function dbClick(num)
    if num == 1 then
        -- 갤러리 - 엄마생신 오픈하는 쿼리 넣으면 됨
        db:exec([[UPDATE clue SET opened = 'TRUE' WHERE name = '갤러리' AND content = '엄마생신';]])
    elseif num == 2 then
        -- 비밀갤러리 - 아이들사진 오픈하는 쿼리 넣으면 됨
        db:exec([[UPDATE clue SET opened = 'TRUE' WHERE name = '비밀갤러리' AND content = '아이들사진';]])
    elseif num == 3 then
        -- 비밀갤러리 - 예배사진 오픈하는 쿼리 넣으면 됨        
        db:exec([[UPDATE clue SET opened = 'TRUE' WHERE name = '비밀갤러리' AND content = '예배사진';]])
    end
end
-- 상세정보 버튼 클릭
local function gotoInfo()
    local infoNum = 0
    
    if photoN == 0 then
        print("기도사진 상세정보 클릭")
        infoNum = 0
    elseif photoN == 1 then
        print("외식 사진 상세정보 클릭")
        infoNum = 1
        dbClick(1)
    elseif photoN == 2 then
        print("성경사진 상세정보 클릭")
        infoNum = 2
    elseif photoN == 3 then
        print("꽃 사진 상세정보 클릭")
        infoNum = 3
    elseif photoN == 4 then
        print("재료준비 사진 상세정보 클릭")
        infoNum = 4
    elseif photoN == 5 then
        print("화초들 사진 상세정보 클릭")
        infoNum = 5
    elseif photoN == 6 then
        print("꽃자수 사진 상세정보 클릭")
        infoNum = 6
    elseif photoN == 7 then
        print("대장정 사진 상세정보 클릭")
        infoNum = 7
    elseif photoN == 8 then
        print("집회 사진 상세정보 클릭")
        infoNum = 8
    elseif photoN == 9 then
        print("청계천나들이 사진 상세정보 클릭")
        infoNum = 9
    elseif photoN == 10 then
        print("가족휴가 사진 상세정보 클릭")
        infoNum = 10
    elseif photoN == 11 then
        print("우리동네 사진 상세정보 클릭")
        infoNum = 11
    elseif photoN == 12 then
        print("아이들 사진 상세정보 클릭")
        infoNum = 12
    elseif photoN == 13 then
        print("엄마생신 사진 상세정보 클릭")
        infoNum = 13
        dbClick(1)
    elseif photoN == 14 then
        print("행복했던시간 사진 상세정보 클릭")
        infoNum = 14
    elseif photoN == 15 then
        print("둘째애기때사진 사진 상세정보 클릭")
        infoNum = 15
    elseif photoN == 16 then
        print("첫째애기때사진 사진 상세정보 클릭")
        infoNum = 16
    elseif photoN == 17 then
        print("남편 사진 상세정보 클릭")
        infoNum = 17
    elseif photoN == 18 then
        print("빛 사진 상세정보 클릭")
        infoNum = 18
    elseif photoN == 19 then
        print("교주님제출용 사진 상세정보 클릭")
        infoNum = 19
        dbClick(2)
    elseif photoN == 20 then
        print("상처인증 사진 상세정보 클릭")
        infoNum = 20
    elseif photoN == 21 then
        print("예배 사진 상세정보 클릭")
        infoNum = 21
        dbClick(3)
    end

    composer.setVariable("infoNum", infoNum)
    composer.removeScene("photo")
   composer.gotoScene("photo_info")
end

-- 단서노트 클릭
local function gotoCluenote()
    print("단서노트 클릭")
    composer.removeScene("photo")
    composer.gotoScene("clueNote")
end

-- 홈버튼 클릭
local function gotoHome()
    print("홈버튼 클릭")
    composer.removeScene("photo")
    composer.gotoScene("game_main")
end

-- 뒤로가기 버튼 클릭
local function gotoBack()
    print("뒤로가기 버튼 클릭")
    if photoN < 18 then
        composer.removeScene("photo")
        composer.gotoScene("album")
    elseif photoN >= 18 then
        composer.removeScene("photo")
        composer.gotoScene("lockedAlbum")
    end
end

local sqlite3 = require( "sqlite3" )
local path = system.pathForFile( "data.db", system.DocumentsDirectory )
local db = sqlite3.open( path )

local dialog = {}
dialog[0] = {
    "경악스럽다.",
    "믿을 수가 없다.",
    "내가 본 것이 아니라고, 누군가가 조작한 것이라고 믿고 싶다.",
    "도대체 왜 이런 짓을 한단 말인가?",
    "내가 아는 아내는 이런 일을 벌일 사람이 아니다.",
    "그게 아니라면 지금까지 내가 보아 온 모습은 모두 허상이었던가."
}

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

    -- 상세정보 버튼
    local info = widget.newButton(
        {
            left = 600,
            top = 150,
            width = 80,
            height = 80,
            defaultFile = "imgsources/info.png",
            onRelease = gotoInfo
        }
    )
   
    -- 사진들
    local photo_0 = display.newImageRect("photo/pray_photo.jpg", 720, 700)
    photo_0.x, photo_0.y = 360, 640
    photo_0.alpha = 0
    local photo_1 = display.newImageRect("photo/pig_photo.jpg", 720, 700)
    photo_1.x, photo_1.y = 360, 640
    photo_1.alpha = 0
    local photo_2 = display.newImageRect("photo/bible_photo.jpg", 720, 700)
    photo_2.x, photo_2.y = 360, 640
    photo_2.alpha = 0
    local photo_3 = display.newImageRect("photo/flower_photo.jpg", 720, 700)
    photo_3.x, photo_3.y = 360, 640
    photo_3.alpha = 0
    local photo_4 = display.newImageRect("photo/market_photo.jpg", 720, 700)
    photo_4.x, photo_4.y = 360, 640
    photo_4.alpha = 0
    local photo_5 = display.newImageRect("photo/plant_photo.jpg", 720, 700)
    photo_5.x, photo_5.y = 360, 640
    photo_5.alpha = 0
    local photo_6 = display.newImageRect("photo/flowerPattern_photo.jpg", 720, 700)
    photo_6.x, photo_6.y = 360, 640
    photo_6.alpha = 0
    local photo_7 = display.newImageRect("photo/walk_photo.jpg", 720, 700)
    photo_7.x, photo_7.y = 360, 640
    photo_7.alpha = 0
    local photo_8 = display.newImageRect("photo/gwanghwa_photo.jpg", 720, 700)
    photo_8.x, photo_8.y = 360, 640
    photo_8.alpha = 0
    local photo_9 = display.newImageRect("photo/stream_photo.jpg", 720, 700)
    photo_9.x, photo_9.y = 360, 640
    photo_9.alpha = 0
    local photo_10 = display.newImageRect("photo/horse_photo.jpg", 720, 700)
    photo_10.x, photo_10.y = 360, 640
    photo_10.alpha = 0
    local photo_11 = display.newImageRect("photo/city_photo.jpg", 720, 700)
    photo_11.x, photo_11.y = 360, 640
    photo_11.alpha = 0
    local photo_12 = display.newImageRect("photo/children_photo.png", 720, 700)
    photo_12.x, photo_12.y = 360, 640
    photo_12.alpha = 0
    local photo_13 = display.newImageRect("photo/mombirthday_photo.jpg", 720, 700)
    photo_13.x, photo_13.y = 360, 640
    photo_13.alpha = 0
    local photo_14 = display.newImageRect("photo/three_photo.jpg", 720, 700)
    photo_14.x, photo_14.y = 360, 640
    photo_14.alpha = 0
    local photo_15 = display.newImageRect("photo/baby_photo.jpg", 720, 700)
    photo_15.x, photo_15.y = 360, 640
    photo_15.alpha = 0
    local photo_16 = display.newImageRect("photo/child_photo.jpg", 720, 700)
    photo_16.x, photo_16.y = 360, 640
    photo_16.alpha = 0
    local photo_17 = display.newImageRect("photo/man_photo.jpg", 720, 700)
    photo_17.x, photo_17.y = 360, 640
    photo_17.alpha = 0
    local photo_18 = display.newImageRect("photo/candles_photo.jpg", 720, 700)
    photo_18.x, photo_18.y = 360, 640
    photo_18.alpha = 0
    local photo_19 = display.newImageRect("photo/childAbuse_photo.jpg", 720, 700)
    photo_19.x, photo_19.y = 360, 640
    photo_19.alpha = 0
    local photo_20 = display.newImageRect("photo/childInjury_photo.png", 720, 700)
    photo_20.x, photo_20.y = 360, 640
    photo_20.alpha = 0
    local photo_21 = display.newImageRect("photo/worship_photo.jpg", 720, 700)
    photo_21.x, photo_21.y = 360, 640
    photo_21.alpha = 0

    if photoN == 0 then
        photo_0.alpha = 1
    elseif photoN == 1 then
        photo_1.alpha = 1
    elseif photoN == 2 then
        photo_2.alpha = 1
    elseif photoN == 3 then
        photo_3.alpha = 1
    elseif photoN == 4 then
        photo_4.alpha = 1
    elseif photoN == 5 then
        photo_5.alpha = 1
    elseif photoN == 6 then
        photo_6.alpha = 1
    elseif photoN == 7 then
        photo_7.alpha = 1
    elseif photoN == 8 then
        photo_8.alpha = 1
    elseif photoN == 9 then
        photo_9.alpha = 1
    elseif photoN == 10 then
        photo_10.alpha = 1
    elseif photoN == 11 then
        photo_11.alpha = 1
    elseif photoN == 12 then
        photo_12.alpha = 1
    elseif photoN == 13 then
        photo_13.alpha = 1
    elseif photoN == 14 then
        photo_14.alpha = 1
    elseif photoN == 15 then
        photo_15.alpha = 1
    elseif photoN == 16 then
        photo_16.alpha = 1
    elseif photoN == 17 then
        photo_17.alpha = 1
    elseif photoN == 18 then
        photo_18.alpha = 1
    elseif photoN == 19 then
        photo_19.alpha = 1
    elseif photoN == 20 then
        photo_20.alpha = 1
    elseif photoN == 21 then
        photo_21.alpha = 1
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

    sceneGroup:insert( background )
   sceneGroup:insert( topbar )
   sceneGroup:insert( info )
   sceneGroup:insert( photo_0 )
   sceneGroup:insert( photo_1 )
   sceneGroup:insert( photo_2 )
   sceneGroup:insert( photo_3 )
   sceneGroup:insert( photo_4 )
   sceneGroup:insert( photo_5 )
   sceneGroup:insert( photo_6 )
   sceneGroup:insert( photo_7 )
   sceneGroup:insert( photo_8 )
   sceneGroup:insert( photo_9 )
   sceneGroup:insert( photo_10 )
   sceneGroup:insert( photo_11 )
   sceneGroup:insert( photo_12 )
   sceneGroup:insert( photo_13 )
   sceneGroup:insert( photo_14 )
   sceneGroup:insert( photo_15 )
   sceneGroup:insert( photo_16 )
   sceneGroup:insert( photo_17 )
   sceneGroup:insert( photo_18 )
   sceneGroup:insert( photo_19 )
   sceneGroup:insert( photo_20 )
   sceneGroup:insert( photo_21 )
   sceneGroup:insert( bottombar )
   sceneGroup:insert( noteBtn )
   sceneGroup:insert( homeBtn )
   sceneGroup:insert( backBtn )

    i = 1
    local data
    local dIndex = 1
    local aIndex = 0

    local chatUI = {}
    chatUI[1] = display.newRect(display.contentWidth/2, display.contentHeight-150, display.contentWidth, 300)
    chatUI[1]:setFillColor(0, 0, 0, 0.75)
    chatUI[2] = display.newText("대충 대사라는 뜻", chatUI[1].x, chatUI[1].y, chatUI[1].width-100, chatUI[1].height-100, font, 36)
    chatUI[3] = display.newText("▶ 다음", display.contentWidth-100, display.contentHeight-75, 128, 36, font, 36)
    chatUI[3]:setFillColor(1, 1, 0)

    function nextDialog()
        backBtn.alpha = 0
        if (dIndex <= #dialog[aIndex]) then
            chatUI[3].alpha = 0
            chatUI[2].text = dialog[aIndex][dIndex]
            if (dIndex == 1) then
                chatUI[1].alpha = 0
                chatUI[2].alpha = 0
                transition.to( chatUI[1], {time=500, delay=0, alpha=1} )
                transition.to( chatUI[2], {time=1000, delay=250, alpha=1} ) 
            end
            dIndex = dIndex + 1
            transition.to( chatUI[3], {delay=500, alpha=1} )
        elseif (dIndex == #dialog[aIndex] + 1) then
            transition.to( chatUI[1], {time=1000, delay=250, alpha=0} )
            transition.to( chatUI[2], {time=500, alpha=0} )
            transition.to( chatUI[3], {time=500, alpha=0} )
            aIndex = aIndex + 1
            backBtn.alpha = 1
        end
    end
    chatUI[3]:addEventListener( "tap", nextDialog )

    for row in db:nrows("SELECT * FROM clue WHERE name = '독백' AND content = '5비밀갤러리'") do
        data = row.opened
    end

    if data == 'FALSE' and photo_20.alpha == 1 then
        nextDialog()
        db:exec([[UPDATE clue SET opened = 'TRUE' WHERE name = '독백' AND content = '5비밀갤러리';]])
    else
        for i = 1, #chatUI, 1 do chatUI[i].alpha = 0 end
    end

    for i = 1, #chatUI, 1 do
        sceneGroup:insert( chatUI[i] )
    end
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
-----------------------------------------------------------------------------------------
--
-- clueNote.lua -- 단서노트
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local widget = require("widget")
local scene = composer.newScene()

local sqlite3 = require( "sqlite3" )
local path = system.pathForFile( "data.db", system.DocumentsDirectory )
local db = sqlite3.open( path )

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

----------------------------------------------------------------------------------------------------
-- db관련

-- 검정단어 쿼리
local blackName = {}
blackName[1] = "문자"
blackName[2] = "캘린더"
blackName[3] = "갤러리"
blackName[4] = "연락처"
blackName[5] = "톡톡"
blackName[6] = "은행"
blackName[7] = "밴드"
blackName[8] = "쿠킹클래스"
blackName[9] = "비밀갤러리"
blackName[10] = "녹음"

local query
-- 검정단어 오픈됐는지 확인하는 함수
function blackQuery(num) 
    query = "SELECT * FROM status WHERE name = '"..blackName[num].."' AND opened = 'TRUE'"
    
    for row in db:nrows(query) do
        print("검정 단어 오픈됨")
        print(blackName[num])
        return true
    end
    return false
end

-- 파란단어 쿼리
local blueContent = {}
blueContent[1] = "빠른캐시"
blueContent[2] = "4월"
blueContent[3] = "지영맘"
blueContent[4] = "엄마생신"
blueContent[5] = "두리안카페"
blueContent[6] = "딸"
blueContent[7] = "양혜지"
blueContent[8] = "빠른캐시"
blueContent[9] = "아이들사진"
blueContent[10] = "예배사진"
blueContent[11] = "지영맘"
blueContent[12] = "빠른캐시"

-- 파란단어 오픈됐는지 확인하는 함수
function blueQuery(num) 
    if num == 1 then
        query = "SELECT * FROM clue WHERE name = '문자' AND content = '빠른캐시' AND opened = 'TRUE'"
    elseif num == 8 then
        query = "SELECT * FROM clue WHERE name = '은행' AND content = '빠른캐시' AND opened = 'TRUE'"
    elseif num == 12 then
        query = "SELECT * FROM clue WHERE name = '녹음' AND content = '빠른캐시' AND opened = 'TRUE'"
    elseif num ~= 1 and num ~= 8 and num ~= 12 then
        query = "SELECT * FROM clue WHERE content = '"..blueContent[num].."' and opened = 'TRUE'"
    end

    for row in db:nrows(query) do
        print("파란단어 오픈")
        print(blueContent[num])
        return true
    end
    return false
end

-- 빨간단어 쿼리
local redContent = {}
redContent[1] = "링크"
redContent[2] = "물"
redContent[3] = "정신교육"
redContent[4] = "총명탕"

-- 빨간단어 오픈됐는지 확인하는 함수
function redQuery(num) 
    query = "SELECT name FROM clue WHERE content = '"..redContent[num].."' AND opened = 'TRUE'"

    for row in db:nrows(query) do
        return true
    end
    return false
end

-- 남색단어 쿼리
local indigoContent = {}
indigoContent[1] = "지령1"
indigoContent[2] = "지령2"
indigoContent[3] = "지령3"
indigoContent[4] = "지령4"

-- 남색단어 오픈됐는지 확인하는 함수
function indigoQuery(num) 
    query = "SELECT name FROM clue WHERE content = '".. indigoContent[num].."' AND opened = 'TRUE'"

    for row in db:nrows(query) do
        return true
    end
    return false
end

-- 연결선 그릴 수 있는지 확인하는 함수들
function drawLine1()
    local isOpened = false
    local query = "SELECT * FROM clue WHERE name = '문자' AND content = '빠른캐시' and opened = 'TRUE'"

    for row in db:nrows(query) do
        return true
    end
    return false
end
function drawLine2()
    local isOpened = false
    local query = "SELECT * FROM clue WHERE name = '문자' AND content = '지영맘' and opened = 'TRUE'"

    for row in db:nrows(query) do
        return true
    end
    return false
end
function drawLine3()
    local isOpened = false
    local query = "SELECT * FROM clue WHERE name = '캘린더' AND content = '4월' and opened = 'TRUE'"

    for row in db:nrows(query) do
        return true
    end
    return false
end
function drawLine4()
    local isOpened = false
    local query = "SELECT * FROM clue WHERE name = '갤러리' AND content = '엄마생신' and opened = 'TRUE'"

    for row in db:nrows(query) do
        return true
    end
    return false
end
function drawLine5()
    local isOpened = false
    local query = "SELECT * FROM clue WHERE name = '연결선' AND content = '톡톡' and opened = 'TRUE'"

    for row in db:nrows(query) do
        return true
    end
    return false
end
function drawLine6()
    local isOpened = false
    local query = "SELECT * FROM clue WHERE name = '은행' AND content = '엄마생신' and opened = 'TRUE'"

    for row in db:nrows(query) do
        return true
    end
    return false
end
function drawLine7()
    local isOpened = false
    local query = "SELECT * FROM clue WHERE name = '은행' AND content = '두리안카페' and opened = 'TRUE'"

    for row in db:nrows(query) do
        return true
    end
    return false
end
function drawLine8()
    local isOpened = false
    local query = "SELECT * FROM clue WHERE name = '은행' AND content = '양혜지' and opened = 'TRUE'"

    for row in db:nrows(query) do
        return true
    end
    return false
end
function drawLine9()
    local isOpened = false
    local query = "SELECT * FROM clue WHERE name = '은행' AND content = '빠른캐시' and opened = 'TRUE'"

    for row in db:nrows(query) do
        return true
    end
    return false
end
function drawLine10()
    local isOpened = false
    local query = "SELECT * FROM clue WHERE name = '톡톡' AND content = '딸' and opened = 'TRUE'"

    for row in db:nrows(query) do
        return true
    end
    return false
end
function drawLine11()
    local isOpened = false
    local query = "SELECT * FROM clue WHERE name = '톡톡' AND content = '비밀갤러리' and opened = 'TRUE'"

    for row in db:nrows(query) do
        return true
    end
    return false
end
function drawLine12()
    local isOpened = false
    local query = "SELECT * FROM clue WHERE name = '밴드(교주)' AND content = '지령1' and opened = 'TRUE'"

    for row in db:nrows(query) do
        return true
    end
    return false
end
function drawLine13()
    local isOpened = false
    local query = "SELECT * FROM clue WHERE name = '밴드(교주)' AND content = '지령2' and opened = 'TRUE'"

    for row in db:nrows(query) do
        return true
    end
    return false
end
function drawLine14()
    local isOpened = false
    local query = "SELECT * FROM clue WHERE name = '밴드(교주)' AND content = '지령3' and opened = 'TRUE'"

    for row in db:nrows(query) do
        return true
    end
    return false
end
function drawLine15()
    local isOpened = false
    local query = "SELECT * FROM clue WHERE name = '밴드(교주)' AND content = '지령4' and opened = 'TRUE'"

    for row in db:nrows(query) do
        return true
    end
    return false
end
function drawLine16()
    local isOpened = false
    local query = "SELECT * FROM clue WHERE name = '밴드(교주)' AND content = '예배사진' and opened = 'TRUE'"

    for row in db:nrows(query) do
        return true
    end
    return false
end
function drawLine17()
    local isOpened = false
    local query = "SELECT * FROM clue WHERE name = '밴드(교주)' AND content = '녹음' and opened = 'TRUE'"

    for row in db:nrows(query) do
        return true
    end
    return false
end
function drawLine18()
    local isOpened = false
    local query = "SELECT * FROM clue WHERE name = '비밀갤러리' AND content = '아이들사진' and opened = 'TRUE'"

    for row in db:nrows(query) do
        return true
    end
    return false
end
function drawLine19()
    local isOpened = false
    local query = "SELECT * FROM clue WHERE name = '비밀갤러리' AND content = '예배사진' and opened = 'TRUE'"

    for row in db:nrows(query) do
        return true
    end
    return false
end
function drawLine20()
    local isOpened = false
    local query = "SELECT * FROM clue WHERE name = '녹음' AND content = '지영맘' and opened = 'TRUE'"

    for row in db:nrows(query) do
        return true
    end
    return false
end
function drawLine21()
    local isOpened = false
    local query = "SELECT * FROM clue WHERE name = '녹음' AND content = '빠른캐시' and opened = 'TRUE'"

    for row in db:nrows(query) do
        return true
    end
    return false
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

    -- 단서노트 배경
    local noteBackground = display.newImageRect("imgsources/note.png", 720, 1070)
    noteBackground.x, noteBackground.y = display.contentCenterX, display.contentCenterY - 20

    local black_word = {"문자", "캘린더", "갤러리", "연락처", "톡톡", "은행", "커넥트(교주)", "커넥트(클래스)", "비밀갤러리", "녹음"}
    local blue_word = {"빠른캐시", "4월", "지영맘", "엄마생신", "두리안카페", "딸", "양혜지", "빠른캐시", "아이들사진", "예배사진", "지영맘", "빠른캐시"}
    local red_word = {"링크", "물", "정신교육", "총명탕"}
    local indigo_word = {"지령1", "지령2", "지령3", "지령4"}
    local yellow_word = {"사이비"}

    -- 각 단어 배치
    local blackText = {}
    blackText[1] = display.newText(black_word[1], 340, 200, defaultFont) -- 문자
    blackText[2] = display.newText(black_word[2], 500, 200, defaultFont) -- 캘린더
    blackText[3] = display.newText(black_word[3], 430, 300, defaultFont) -- 갤러리
    blackText[4] = display.newText(black_word[4], 100, 340, defaultFont) -- 연락처
    blackText[5] = display.newText(black_word[5], 80, 440, defaultFont) -- 톡톡
    blackText[6] = display.newText(black_word[6], 500, 400, defaultFont) -- 은행
    blackText[7] = display.newText(black_word[7], 100, 800, defaultFont) -- 밴드(교주)
    blackText[8] = display.newText(black_word[8], 500, 600, defaultFont) -- 밴드(클래스)
    blackText[9] = display.newText(black_word[9], 500, 800, defaultFont) -- 비밀갤러리
    blackText[10] = display.newText(black_word[10], 100, 1000, defaultFont) -- 녹음

    for i = 1, #blackText, 1 do
        blackText[i]:setFillColor(black)
        blackText[i].size = 35
        blackText[i].alpha = 0
    end

    -- 검정 단어에 해당하는 단서 찾을 때마다 해당 단어 alpha = 1
    for i = 1, #blackText, 1 do
        local bkQ = blackQuery(i)
        if bkQ then
            blackText[i].alpha = 1
        end
    end

    local blueText = {}
    blueText[1] = display.newText(blue_word[1], 200, 230, defaultFont) -- 빠른캐시
    blueText[2] = display.newText(blue_word[2], 660, 230, defaultFont) -- 4월
    blueText[3] = display.newText(blue_word[3], 280, 300, defaultFont) -- 지영맘
    blueText[4] = display.newText(blue_word[4], 600, 300, defaultFont) -- 엄마 생신
    blueText[5] = display.newText(blue_word[5], 340, 400, defaultFont) -- 두리안카페
    blueText[6] = display.newText(blue_word[6], 150, 500, defaultFont) -- 딸
    blueText[7] = display.newText(blue_word[7], 440, 500, defaultFont) -- 양혜지
    blueText[8] = display.newText(blue_word[8], 600, 500, defaultFont) -- 빠른캐시
    blueText[9] = display.newText(blue_word[9], 480, 700, defaultFont) -- 아이들사진
    blueText[10] = display.newText(blue_word[10], 280, 900, defaultFont) -- 예배사진
    blueText[11] = display.newText(blue_word[11], 280, 1000, defaultFont) -- 지영맘
    blueText[12] = display.newText(blue_word[12], 100, 1100, defaultFont) -- 빠른캐시

    for i = 1, #blueText, 1 do
        blueText[i]:setFillColor(0, 0, 1)
        blueText[i].size = 35
        blueText[i].alpha = 0
    end

    -- 파란 단어에 해당하는 단서 찾을 때마다 해당 단어 alpha = 1
    for i = 1, #blueText, 1 do
        local blQ = blueQuery(i)
        if blQ then
            blueText[i].alpha = 1
        end
    end

    local redText = {}
    redText[1] = display.newText(red_word[1], 200, 440, defaultFont) -- 링크
    redText[2] = display.newText(red_word[2], 100, 550, defaultFont) -- 물
    redText[3] = display.newText(red_word[3], 200, 600, defaultFont) -- 정신교육
    redText[4] = display.newText(red_word[4], 320, 550, defaultFont) -- 총명탕

    for i = 1, #redText, 1 do
        redText[i]:setFillColor(1, 0, 0)
        redText[i].size = 35
        redText[i].alpha = 0
    end

    -- 빨간 단어에 해당하는 단서 찾을 때마다 해당 단어 alpha = 1
    for i = 1, #redText, 1 do
        if redQuery(i) then
            redText[i].alpha = 1
        end
    end

    local indigoText = {}
    indigoText[1] = display.newText(indigo_word[1], 100, 700, defaultFont) -- 지령1
    indigoText[2] = display.newText(indigo_word[2], 250, 700, defaultFont) -- 지령2
    indigoText[3] = display.newText(indigo_word[3], 350, 750, defaultFont) -- 지령3
    indigoText[4] = display.newText(indigo_word[4], 80, 900, defaultFont) -- 지령4

    for i = 1, #indigoText, 1 do
        indigoText[i]:setFillColor(0.05, 0.0, 0.153)
        indigoText[i].size = 35
        indigoText[i].alpha = 0
    end

    -- 남색 단어에 해당하는 단서 찾을 때마다 해당 단어 alpha = 1
    for i = 1, #indigoText, 1 do
        if indigoQuery(i) then
            indigoText[i].alpha = 1
        end
    end

    local yellowText = {}
    yellowText[1] = display.newText(yellow_word[1], 200, 390, defaultFont) -- 사이비
    yellowText[1]:setFillColor(0.9, 0.7, 0)
    yellowText[1].size = 35
    yellowText[1].alpha = 0 -- 모든 단서 찾았을 경우 노란 단어 alpha = 1

    -- 연결선
    -- '문자'와 연결된 단어들
    -- '빠른캐시'
    local line1 = display.newLine(blackText[1].x - 20, blackText[1].y + 20, blueText[1].x + 50, blueText[1].y)
    line1.strokeWidth = 3
    line1:setStrokeColor(0, 0, 0)
    line1.alpha = 0 -- '문자', '빠른캐시' 모두 찾았을 경우 해당 연결선 alpha = 1

    -- '지영맘'
    local line2 = display.newLine(blackText[1].x - 20, blackText[1].y + 20, blueText[3].x, blueText[3].y - 20)
    line2.strokeWidth = 3
    line2:setStrokeColor(0, 0, 0)
    line2.alpha = 0 -- '문자', '지영맘' 모두 찾았을 경우 해당 연결선 alpha = 1

    -- '캘린더'와 연결된 단어들
    -- '4월'
    local line3 = display.newLine(blackText[2].x + 20, blackText[2].y, blueText[2].x - 20, blueText[2].y + 10)
    line3.strokeWidth = 3
    line3:setStrokeColor(0, 0, 0)
    line3.alpha = 0 -- '캘린더', '4월' 모두 찾았을 경우 해당 연결선 alpha = 1

    -- '갤러리'와 연결된 단어들
    -- '엄마생신'
    local line4 = display.newLine(blackText[3].x + 40, blackText[3].y, blueText[4].x - 45, blueText[4].y)
    line4.strokeWidth = 3
    line4:setStrokeColor(0, 0, 0)
    line4.alpha = 0 -- '갤러리', '엄마생신' 모두 찾았을 경우 해당 연결선 alpha = 1

    -- '연락처'와 연결된 단어들
    -- '톡톡'
    local line5 = display.newLine(blackText[4].x, blackText[4].y + 20, blackText[5].x, blackText[5].y - 20)
    line5.strokeWidth = 3
    line5:setStrokeColor(0, 0, 0)
    line5.alpha = 0 -- '연결선', '톡톡' 모두 찾았을 경우 해당 연결선 alpha = 1

    -- '은행'과 연결된 단어들
    -- '엄마 생신'
    local line6 = display.newLine(blackText[6].x, blackText[6].y - 20, blueText[4].x, blueText[4].y + 20)
    line6.strokeWidth = 3
    line6:setStrokeColor(0, 0, 0)
    line6.alpha = 0 -- '은행', '엄마 생신' 모두 찾았을 경우 해당 연결선 alpha = 1

    -- '두리안카페'
    local line7 = display.newLine(blackText[6].x - 25, blackText[6].y, blueText[5].x + 60, blueText[5].y)
    line7.strokeWidth = 3
    line7:setStrokeColor(0, 0, 0)
    line7.alpha = 0 -- '은행', '두리안카페' 모두 찾았을 경우 해당 연결선 alpha = 1

    -- '양혜지'
    local line8 = display.newLine(blackText[6].x, blackText[6].y + 20, blueText[7].x, blueText[7].y - 20)
    line8.strokeWidth = 3
    line8:setStrokeColor(0, 0, 0)
    line8.alpha = 0 -- '은행', '양혜지' 모두 찾았을 경우 해당 연결선 alpha = 1

    -- '빠른캐시'
    local line9 = display.newLine(blackText[6].x + 10, blackText[6].y + 20, blueText[8].x, blueText[8].y - 20)
    line9.strokeWidth = 3
    line9:setStrokeColor(0, 0, 0)
    line9.alpha = 0 -- '은행', '빠른캐시' 모두 찾았을 경우 해당 연결선 alpha = 1


    -- '톡톡'과 연결된 단어들
    -- '딸'
    local line10 = display.newLine(blackText[5].x + 10, blackText[5].y + 20, blueText[6].x - 20, blueText[6].y)
    line10.strokeWidth = 3
    line10:setStrokeColor(0, 0, 0)
    line10.alpha = 0 -- '톡톡', '딸' 모두 찾았을 경우 해당 연결선 alpha = 1

    -- '비밀갤러리'
    local line11 = display.newLine(blackText[5].x + 10, blackText[5].y + 20, blackText[9].x - 60, blackText[9].y)
    line11.strokeWidth = 3
    line11:setStrokeColor(0, 0, 0)
    line11.alpha = 0 -- '톡톡', '비밀갤러리' 모두 찾았을 경우 해당 연결선 alpha = 1


    -- '밴드(교주)'와 연결된 단어들
    -- '지령1'
    local line12 = display.newLine(blackText[7].x, blackText[7].y - 20, indigoText[1].x, indigoText[1].y + 20)
    line12.strokeWidth = 3
    line12:setStrokeColor(0, 0, 0)
    line12.alpha = 0 -- '밴드(교주)', '지령1' 모두 찾았을 경우 해당 연결선 alpha = 1

    -- '지령2'
    local line13 = display.newLine(blackText[7].x, blackText[7].y - 20, indigoText[2].x, indigoText[2].y + 20)
    line13.strokeWidth = 3
    line13:setStrokeColor(0, 0, 0)
    line13.alpha = 0 -- '밴드(교주)', '지령2' 모두 찾았을 경우 해당 연결선 alpha = 1

    -- '지령3'
    local line14 = display.newLine(blackText[7].x + 60, blackText[7].y, indigoText[3].x, indigoText[3].y + 20)
    line14.strokeWidth = 3
    line14:setStrokeColor(0, 0, 0)
    line14.alpha = 0 -- '밴드(교주)', '지령3' 모두 찾았을 경우 해당 연결선 alpha = 1

    -- '지령4'
    local line15 = display.newLine(blackText[7].x, blackText[7].y + 20, indigoText[4].x, indigoText[4].y - 20)
    line15.strokeWidth = 3
    line15:setStrokeColor(0, 0, 0)
    line15.alpha = 0 -- '밴드(교주)', '지령4' 모두 찾았을 경우 해당 연결선 alpha = 1

    -- '예배사진'
    local line16 = display.newLine(blackText[7].x, blackText[7].y + 20, blueText[10].x - 20, blueText[10].y - 10)
    line16.strokeWidth = 3
    line16:setStrokeColor(0, 0, 0)
    line16.alpha = 0 -- '밴드(교주)', '예배사진' 모두 찾았을 경우 해당 연결선 alpha = 1

    -- '녹음'
    local line17 = display.newLine(blackText[7].x, blackText[7].y + 20, blackText[10].x, blackText[10].y - 20)
    line17.strokeWidth = 3
    line17:setStrokeColor(0, 0, 0)
    line17.alpha = 0 -- '밴드(교주)', '녹음' 모두 찾았을 경우 해당 연결선 alpha = 1


    -- '비밀갤러리'와 연결된 단어들
    -- '아이들사진'
    local line18 = display.newLine(blackText[9].x, blackText[9].y - 20, blueText[9].x, blueText[9].y + 20)
    line18.strokeWidth = 3
    line18:setStrokeColor(0, 0, 0)
    line18.alpha = 0 -- '비밀갤러리', '아이들사진' 모두 찾았을 경우 해당 연결선 alpha = 1

    -- '예배사진'
    local line19 = display.newLine(blackText[9].x, blackText[9].y + 20, blueText[10].x, blueText[10].y - 20)
    line19.strokeWidth = 3
    line19:setStrokeColor(0, 0, 0)
    line19.alpha = 0 -- '비밀갤러리', '예배사진' 모두 찾았을 경우 해당 연결선 alpha = 1


    -- '녹음'과 연결된 단어들
    -- '지영맘'
    local line20 = display.newLine(blackText[10].x + 20, blackText[10].y, blueText[11].x - 20, blueText[11].y)
    line20.strokeWidth = 3
    line20:setStrokeColor(0, 0, 0)
    line20.alpha = 0 -- '녹음', '지영맘' 모두 찾았을 경우 해당 연결선 alpha = 1

    -- '빠른캐시'
    local line21 = display.newLine(blackText[10].x, blackText[10].y + 20, blueText[12].x, blueText[12].y - 20)
    line21.strokeWidth = 3
    line21:setStrokeColor(0, 0, 0)
    line21.alpha = 0 -- '녹음', '빠른캐시' 모두 찾았을 경우 해당 연결선 alpha = 1

    if drawLine1() then line1.alpha = 1 end
    if drawLine2() then line2.alpha = 1 end
    if drawLine3() then line3.alpha = 1 end
    if drawLine4() then line4.alpha = 1 end
    if drawLine5() then line5.alpha = 1 end
    if drawLine6() then line6.alpha = 1 end
    if drawLine7() then line7.alpha = 1 end
    if drawLine8() then line8.alpha = 1 end
    if drawLine9() then line9.alpha = 1 end
    if drawLine10() then line10.alpha = 1 end
    if drawLine11() then line11.alpha = 1 end
    if drawLine12() then line12.alpha = 1 end
    if drawLine13() then line13.alpha = 1 end
    if drawLine14() then line14.alpha = 1 end
    if drawLine15() then line15.alpha = 1 end
    if drawLine16() then line16.alpha = 1 end
    if drawLine17() then line17.alpha = 1 end
    if drawLine18() then line18.alpha = 1 end
    if drawLine19() then line19.alpha = 1 end
    if drawLine20() then line20.alpha = 1 end
    if drawLine21() then line21.alpha = 1 end


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
    sceneGroup:insert(noteBackground)
    for i = 1, #redText, 1 do sceneGroup:insert(redText[i]) end
    for i = 1, #blueText, 1 do sceneGroup:insert(blueText[i]) end
    for i = 1, #indigoText, 1 do sceneGroup:insert(indigoText[i]) end
    for i = 1, #blackText, 1 do sceneGroup:insert(blackText[i]) end
    for i = 1, #yellowText, 1 do sceneGroup:insert(yellowText[i]) end

    sceneGroup:insert(line1)
    sceneGroup:insert(line2) 
    sceneGroup:insert(line3) 
    sceneGroup:insert(line4) 
    sceneGroup:insert(line5) 
    sceneGroup:insert(line6)
    sceneGroup:insert(line7) 
    sceneGroup:insert(line8) 
    sceneGroup:insert(line9) 
    sceneGroup:insert(line10) 
    sceneGroup:insert(line11) 
    sceneGroup:insert(line12) 
    sceneGroup:insert(line13) 
    sceneGroup:insert(line14) 
    sceneGroup:insert(line15) 
    sceneGroup:insert(line16) 
    sceneGroup:insert(line17) 
    sceneGroup:insert(line18) 
    sceneGroup:insert(line19) 
    sceneGroup:insert(line20) 
    sceneGroup:insert(line21) 

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
-----------------------------------------------------------------------------------------
--
-- reList.lua 각각의 녹음 듣기
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local widget = require("widget")
local scene = composer.newScene()
local font = "font/KM.ttf"

local sqlite3 = require( "sqlite3" )
local path = system.pathForFile( "data.db", system.DocumentsDirectory )
local db = sqlite3.open( path )

local recordN = composer.getVariable("recordNum") -- recorder.lua 에서 받아온 인자
print("recorder.lua에서 받아온 recordNum값", recordN)

local script = {}
script[0] = {
    "잠깐 휴대폰을 무음으로 해서 못 받았어요, 죄송해요",
    "조금만 더 시간을 주세요",
    "꼭 이번 달 안에 갚을게요",
    "정말 이번에는 꼭 갚을게요"
}
script[1] = {
    "네, 알아요..",
    "네..."
}
script[2] = {
    "이번달은 갚았는데...",
    "아니..저는 이번달거는 정확하게 갚았어요",
    "그런게 어디있어요!!!",
    "...네"
}
script[3] = {
    "이자가 너무 많아서..",
    "...네"
}
script[4] = {
    "네, 알고있어요",
    "네.."
}
script[5] = {
    "방금 입금했어요",
    "...",
    "네..."
}
script[6] = {
    "요즘들어 교주님 말씀 따르기가 힘드네..",
    "금전적으로 너무 힘드네..",
    "...알겠어, 양씨는 교주님 말을 참 잘 지키는 것 같애"
}
script[7] = {
    "애들이 정말 말을 안들어..정말 머리가 아프다",
    "그래야하는데, 이제 대출도 어려울 것 같애",
    "그런 돈은 쓰면 안돼..",
    "...그렇겠지, 어쩔 수 없지"
}
script[8] = {
    "진작에 양씨 말 들을 것 그랬어",
    "정말이지, 내가 양씨 도움을 많이 받네",
    "응? 아직 못봤는데",
    "그래? 나도 그럴까?",
    "응 알겠어"
}
script[9] = {
    "응, 알려줘서 고마워, \n여러모로 요즘에 힘든 일이 계속 일어나서",
    "의지할 곳이 없어서 힘들었는데, \n덕분에 살았어",
    "응 알겠어, 고마워 정말"
}

-- 단서노트 클릭
local function gotoCluenote()
    print("단서노트 클릭")
    -- 오디오 멈춤
    audio.stop()
    composer.removeScene("reList")
    composer.gotoScene("clueNote")
end

-- 홈버튼 클릭
local function gotoHome()
    print("홈버튼 클릭")
    -- 오디오 멈춤
    audio.stop()
    composer.removeScene("reList")
    composer.gotoScene("game_main")
end

-- 뒤로가기 버튼 클릭
local function gotoBack()
    print("뒤로가기 버튼 클릭")
    -- 오디오 멈춤
    audio.stop()
    composer.removeScene("reList")
    composer.gotoScene("recorder")
end




--모든 단서를 열었는지 체크하는 변수
local allClue_opened
allClue_opened = false
--녹음 초반에서(reListe에 들어갔을 때) 조건이 만족하는지 체크한다. 
local function is_clue_caus()
    local clueNum = 30-2
    local count = 0

    local all_data
    for row in db:nrows("SELECT * FROM clue") do
        all_data = row.opened

        if all_data == 'TRUE' then 
            count = count + 1
            print("단서 다 열렸는지 체크중"..all_data..count)
        end
    end

    if count == clueNum then
        allClue_opened = true
        print("모든 단서 다 열렸다")
    end
end


-- db랑 연결할 부분
local function dbClick( event )
    if event.name == "timer" then
        print("dbClick completed!!!+"..event.name)
        db:exec([[UPDATE clue SET opened = 'TRUE' WHERE name = '녹음' AND content = '지영맘';]]) 
    elseif event.name == "causal" then
        print("db completed!!!+ "..event.name.." game end!")
        db:exec([[UPDATE clue SET opened = 'TRUE' WHERE name = '녹음' AND content = '인과';]]) 
    end
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
    
    -- 받아온 인자를 날짜로 바꾸기
    local recordArray = {"20200201", "20200127", "20200115", "20200109", "20191229", "20191207", "20191022", "20190917", "20190824", "20190815"}
    local recordDate = recordArray[recordN+1]
    print(recordDate)

     -- 녹음 이름(누구랑 언제)
    local titleT = ""

    if recordN <= 5 then
        titleT = "통화 정씨_"..recordDate
    elseif recordN > 5 then
        titleT = "통화 양혜지_"..recordDate
    end

    local loadMusic
    local playMusic
    if recordN == 0 then
        loadMusic = audio.loadStream("list/2020.02.02.mp3")
        playMusic = audio.play(loadMusic)
        playMusic = audio.setVolume(1)
    elseif recordN == 1 then
        loadMusic = audio.loadStream("list/2020.01.27.mp3")
        playMusic = audio.play(loadMusic)
        playMusic = audio.setVolume(1)
    elseif recordN == 2 then
        loadMusic = audio.loadStream("list/2020.01.15.mp3")
        playMusic = audio.play(loadMusic)
        playMusic = audio.setVolume(1)
    elseif recordN == 3 then
        loadMusic = audio.loadStream("list/2020.01.09.mp3")
        playMusic = audio.play(loadMusic)
        playMusic = audio.setVolume(1)
    elseif recordN == 4 then
        loadMusic = audio.loadStream("list/2019.12.29.mp3")
        playMusic = audio.play(loadMusic)
        playMusic = audio.setVolume(1)
    elseif recordN == 5 then
        loadMusic = audio.loadStream("list/2019.12.07.mp3")
        playMusic = audio.play(loadMusic)
        playMusic = audio.setVolume(1)
    elseif recordN == 6 then
        loadMusic = audio.loadStream("list/2019.10.22.mp3")
        playMusic = audio.play(loadMusic)
        playMusic = audio.setVolume(1)
    elseif recordN == 7 then
        loadMusic = audio.loadStream("list/2019.09.17.mp3")
        playMusic = audio.play(loadMusic)
        playMusic = audio.setVolume(1)
    elseif recordN == 8 then
        loadMusic = audio.loadStream("list/2019.8.24.mp3")
        playMusic = audio.play(loadMusic)
        playMusic = audio.setVolume(1)
    elseif recordN == 9 then
        loadMusic = audio.loadStream("list/2019.8.15.mp3")
        playMusic = audio.play(loadMusic)
        playMusic = audio.setVolume(1)
    end



    local title = display.newText(titleT, display.contentCenterX, 150, font, 50)
       
    local whiteBox = display.newRect(display.contentCenterX, 500, 650, 570)

    local waveImg = display.newImageRect("images/soundwave.png", 630, 300)
    waveImg.x, waveImg.y = display.contentCenterX, whiteBox.y
    --chatUI sceneGroup:insert 할때 쓸거
    local i



    -- 녹음 중 '나'(아내)의 말을 넣는 부분
    local chatUI = {}
    chatUI[1] = display.newRect(display.contentWidth/2, display.contentHeight-245, display.contentWidth, 300)
    chatUI[1]:setFillColor(0, 0, 0, 0.75)
    chatUI[2] = display.newText("", chatUI[1].x, chatUI[1].y, chatUI[1].width-100, chatUI[1].height-100, font, 36)

    chatUI[1].alpha = 0

    -- 전달되는 인덱스대로 권씨의 말이 뜨도록 하는 함수
    local function showScript( dIndex, nIndex ) -- dIndex는 날짜, nIndex는 그 날의 몇번째 스크립트인지
        chatUI[1].alpha = 1
        chatUI[2].alpha = 0
        chatUI[2].text = script[dIndex][nIndex]
        chatUI[2].alpha = 1
    end

    -- 말을 없애는 함수
    local function hideScript( )
        chatUI[1].alpha = 0
        chatUI[2].text = ""
    end

    local timeHandle
    local myTimer

    if recordN == 0 then
        timeHandle = timer.performWithDelay(4000, function() showScript(0, 1) end, 1)
        timeHandle = timer.performWithDelay(6500, hideScript, 1)
        timeHandle = timer.performWithDelay(9000, function() showScript(0, 2) end, 1)
        timeHandle = timer.performWithDelay(12000, hideScript, 1)
        timeHandle = timer.performWithDelay(15000, function() showScript(0, 3) end, 1)
        timeHandle = timer.performWithDelay(16500, hideScript, 1)
        timeHandle = timer.performWithDelay(22700, function() showScript(0, 4) end, 1)
        -- 진심 들었네요
        --myTimer = timer.performWithDelay(30000, function() areYouListen(recordN) end, 1)
        timeHandle = timer.performWithDelay(26000, hideScript, 1)
    elseif recordN == 1 then
        timeHandle = timer.performWithDelay(5000, function() showScript(1, 1) end, 1)
        timeHandle = timer.performWithDelay(6700, hideScript, 1)
        timeHandle = timer.performWithDelay(10500, function() showScript(1, 2) end, 1)
        -- 진심 들었네요
        --myTimer = timer.performWithDelay(10500, function() areYouListen(recordN) end, 1)
        timeHandle = timer.performWithDelay(16500, hideScript, 1)
     elseif recordN == 2 then--수정
        timeHandle = timer.performWithDelay(1000, function() showScript(2, 1) end, 1)
        timeHandle = timer.performWithDelay(5000, hideScript, 1)
        timeHandle = timer.performWithDelay(6500, function() showScript(2, 2) end, 1)
        timeHandle = timer.performWithDelay(9500, hideScript, 1)
        timeHandle = timer.performWithDelay(14500, function() showScript(2, 3) end, 1)
        timeHandle = timer.performWithDelay(16500, hideScript, 1)
        timeHandle = timer.performWithDelay(28000, function() showScript(2, 4) end, 1)
        -- 진심 들었네요
        --myTimer = timer.performWithDelay(28000, function() areYouListen(recordN) end, 1)
        timeHandle = timer.performWithDelay(32000, hideScript, 1)
    elseif recordN == 3 then
        timeHandle = timer.performWithDelay(7500, function() showScript(3, 1) end, 1)
        timeHandle = timer.performWithDelay(10500, hideScript, 1)
        timeHandle = timer.performWithDelay(17500, function() showScript(3, 2) end, 1)
        -- 진심 들었네요
        --myTimer = timer.performWithDelay(17500, function() areYouListen(recordN) end, 1)
        timeHandle = timer.performWithDelay(20500, hideScript, 1)
    elseif recordN == 4 then
        timeHandle = timer.performWithDelay(4500, function() showScript(4, 1) end, 1)
        timeHandle = timer.performWithDelay(5500, hideScript, 1)
        timeHandle = timer.performWithDelay(10500, function() showScript(4, 2) end, 1)
        -- 진심 들었네요
        --myTimer = timer.performWithDelay(10500, function() areYouListen(recordN) end, 1)
        timeHandle = timer.performWithDelay(11500, hideScript, 1)
    elseif recordN == 5 then
        timeHandle = timer.performWithDelay(4500, function() showScript(5, 1) end, 1)
        timeHandle = timer.performWithDelay(6500, hideScript, 1)
        timeHandle = timer.performWithDelay(11000, function() showScript(5, 2) end, 1)
        timeHandle = timer.performWithDelay(12500, hideScript, 1)
        timeHandle = timer.performWithDelay(17800, function() showScript(5, 3) end, 1)
        -- 진심 들었네요
        --myTimer = timer.performWithDelay(17800, function() areYouListen(recordN) end, 1)
        timeHandle = timer.performWithDelay(25000, hideScript, 1)
    elseif recordN == 6 then
        timeHandle = timer.performWithDelay(500, function() showScript(6, 1) end, 1)
        timeHandle = timer.performWithDelay(5500, hideScript, 1)
        timeHandle = timer.performWithDelay(14000, function() showScript(6, 2) end, 1)
        timeHandle = timer.performWithDelay(16500, hideScript, 1)
        timeHandle = timer.performWithDelay(22000, function() showScript(6, 3) end, 1)
        -- 진심 들었네요
        --myTimer = timer.performWithDelay(22000, function() areYouListen(recordN) end, 1)
        timeHandle = timer.performWithDelay(25000, hideScript, 1)
    elseif recordN == 7 then
        timeHandle = timer.performWithDelay(4500, function() showScript(7, 1) end, 1)
        timeHandle = timer.performWithDelay(7000, hideScript, 1)
        timeHandle = timer.performWithDelay(10600, function() showScript(7, 2) end, 1)
        timeHandle = timer.performWithDelay(12500, hideScript, 1)
        timeHandle = timer.performWithDelay(19000, function() showScript(7, 3) end, 1)
        timeHandle = timer.performWithDelay(21300, hideScript, 1)
        timeHandle = timer.performWithDelay(30000, function() showScript(7, 4) end, 1)      
        -- 진심 들었네요
        --myTimer = timer.performWithDelay(30000, function() areYouListen(recordN) end, 1)
        -- 조건 : 녹음-지영맘20190917 스크립트 마지막 대사가 나오고 난 뒤 바로 true 로 바뀜
        myTimer = timer.performWithDelay(30000, dbClick)

        timeHandle = timer.performWithDelay(32500, hideScript, 1)
    elseif recordN == 8 then
        timeHandle = timer.performWithDelay(500, function() showScript(8, 1) end, 1)
        timeHandle = timer.performWithDelay(4200, hideScript, 1)
        timeHandle = timer.performWithDelay(12000, function() showScript(8, 2) end, 1)
        timeHandle = timer.performWithDelay(14000, hideScript, 1)
        timeHandle = timer.performWithDelay(17500, function() showScript(8, 3) end, 1)
        timeHandle = timer.performWithDelay(20300, hideScript, 1)
        timeHandle = timer.performWithDelay(34500, function() showScript(8, 4) end, 1)
        timeHandle = timer.performWithDelay(36500, hideScript, 1)
        timeHandle = timer.performWithDelay(40500, function() showScript(8, 5) end, 1)
        -- 진심 들었네요
        --myTimer = timer.performWithDelay(30000, function() areYouListen(recordN) end, 1)
        timeHandle = timer.performWithDelay(42500, hideScript, 1)
    elseif recordN == 9 then
        timeHandle = timer.performWithDelay(5500, function() showScript(9, 1) end, 1)
        timeHandle = timer.performWithDelay(10000, hideScript, 1)
        timeHandle = timer.performWithDelay(7500, function() showScript(9, 2) end, 1)
        timeHandle = timer.performWithDelay(18000, function() showScript(9, 3) end, 1)
        -- 진심 들었네요
        --myTimer = timer.performWithDelay(30000, function() areYouListen(recordN) end, 1)
        timeHandle = timer.performWithDelay(20000, hideScript, 1)
    end

    --------------------------------------------------------------------------------------------
    -- 단서가 모두 열려있고 모든 녹음을 다 들었는지 확인해준다.
    --if allRec_opened == false then is_listen_caus() end
    if allClue_opened == false then is_clue_caus() end

    if allClue_opened == true then
        event = {name = "causal"}
        dbClick(event)
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
    sceneGroup:insert(title)
    sceneGroup:insert(whiteBox)
    sceneGroup:insert(waveImg)
    sceneGroup:insert(bottombar)
    sceneGroup:insert(noteBtn)
    sceneGroup:insert(homeBtn)
    sceneGroup:insert(backBtn)

    for i = 1, #chatUI, 1 do
        sceneGroup:insert( chatUI[i] )
    end
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
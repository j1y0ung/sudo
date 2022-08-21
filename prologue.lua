-----------------------------------------------------------------------------------------
--
-- prologue.lua
--
-- 개발 : 냨냨
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()
local font = "font/KM.ttf"

local sqlite3 = require( "sqlite3" )
local path = system.pathForFile( "data.db", system.DocumentsDirectory )
local db = sqlite3.open( path )

local dialog = {}
dialog[0] = {
    "나는 어제 교수를 죽였다.",
    "이유는 터무니없다.",
    "과제가 너무 많았기 때문이다.",
    "내가 지 수업만 듣는 줄 아나보지"
}
dialog[1] = {
    "어제",
    "아내와 딸들이 모두 죽었다.",
    "나는 좋은 남편, 아버지는 아니었다.",
    "생업을 이어나가기 위해서, 우리는 주말부부 생활을 계속할 수밖에 없었다.\n그러나 나는 내가 할 수 있는 최선을 다했다.",
    "그러나 대체 이게 무슨 운명의 장난이란 말인가?",
    "[알람소리]",
    "[D-0 분납 2차입금]",
    "그래. 아내의 휴대폰.",
    "죽은 이들은 살려낼 수 없다.\n그러나 죽은 이유는 찾아낼 수 있지 않겠는가.",
    "휴대폰, 휴대폰에서 답을 찾아보자.\n휴대폰은 분명 답을 알고 있을 것이다."
}

function scene:create( event )
    local sceneGroup = self.view

    local background = display.newRect(display.contentWidth/2, display.contentHeight/2, display.contentWidth, display.contentHeight)
    background:setFillColor(0)

    local chatUI = {}
    chatUI[1] = display.newRect(display.contentWidth/2, display.contentHeight-150, display.contentWidth, 300)
    chatUI[1]:setFillColor(0, 0, 0, 0.75)
    chatUI[2] = display.newText("대충 대사라는 뜻", chatUI[1].x, chatUI[1].y, chatUI[1].width-100, chatUI[1].height-100, font, 36)
    chatUI[3] = display.newText("▶ 다음", display.contentWidth-100, display.contentHeight-75, 128, 36, font, 36)
    chatUI[3]:setFillColor(1, 1, 0)

    local i = 1
    local dIndex = 1
    local aIndex = 1

    function nextDialog()
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
            composer.gotoScene( "game_main", { effect="crossFade", time=2000 } )
        end
    end
    nextDialog()

    local isempty = "YES"
    local data = 
    {
        {
            name = "문자",
            content = "빠른캐시",
            opened = "FALSE"
        },
        {
            name = "문자",
            content = "지영맘",
            opened = "FALSE"
        },
        {
            name = "캘린더",
            content = "4월",
            opened = "FALSE"
        },
        {
            name = "갤러리",
            content = "엄마생신",
            opened = "FALSE"
        },
        {
            name = "은행",
            content = "두리안카페",
            opened = "FALSE"
        },
        {
            name = "은행",
            content = "양혜지",
            opened = "FALSE"
        },
        {
            name = "은행",
            content = "빠른캐시",
            opened = "FALSE"
        },
        {
            name = "연락처",
            content = "비밀번호(톡톡)",
            opened = "FALSE"
        },
        {
            name = "톡톡",
            content = "딸",
            opened = "FALSE"
        },
        {
            name = "톡톡",
            content = "링크",
            opened = "FALSE"
        },
        {
            name = "톡톡",
            content = "사이비",
            opened = "FALSE"
        },
        {
            name = "톡톡",
            content = "비밀번호(비밀갤러리)",
            opened = "FALSE"
        },
        {
            name = "톡톡",
            content = "물",
            opened = "FALSE"
        },
        {
            name = "톡톡",
            content = "정신교육",
            opened = "FALSE"
        },
        {
            name = "톡톡",
            content = "총명탕",
            opened = "FALSE"
        },
        {
            name = "비밀갤러리",
            content = "아이들사진",
            opened = "FALSE"
        },
        {
            name = "비밀갤러리",
            content = "예배사진",
            opened = "FALSE"
        },
        {
            name = "밴드",
            content = "지령1",
            opened = "FALSE"
        },
        {
            name = "밴드",
            content = "지령2",
            opened = "FALSE"
        },
        {
            name = "밴드",
            content = "지령3",
            opened = "FALSE"
        },
        {
            name = "밴드",
            content = "지령4",
            opened = "FALSE"
        },
        {
            name = "밴드",
            content = "비밀번호(녹음)",
            opened = "FALSE"
        },
        {
            name = "녹음",
            content = "지영맘",
            opened = "FALSE"
        },
        {
            name = "녹음",
            content = "빠른캐시",
            opened = "FALSE"
        },
        {
            name = "녹음",
            content = "인과",
            opened = "FALSE"
        },
        {
            name = "독백",
            content = "2은행비번",
            opened = "FALSE"
        },
        {
            name = "독백",
            content = "3은행빚",
            opened = "FALSE"
        },
        {
            name = "독백",
            content = "4두리안카페",
            opened = "FALSE"
        },
        {
            name = "독백",
            content = "5비밀갤러리",
            opened = "FALSE"
        },
        {
            name = "독백",
            content = "6교주",
            opened = "FALSE"
        }
    }
    db:exec(
        [[
            DROP TABLE IF EXISTS status;
            DROP TABLE IF EXISTS clue;
            CREATE TABLE IF NOT EXISTS status(
                name    TEXT PRIMARY KEY,
                opened  TEXT
            );
            CREATE TABLE IF NOT EXISTS clue(
                id      INTEGER PRIMARY KEY,
                name    TEXT,
                content TEXT,
                opened  TEXT,
                FOREIGN KEY(name) REFERENCES status(name)
            );
        ]]
     )
    for row in db:nrows("SELECT * FROM status") do
        isempty = row
        break
    end
    print(isempty)
    if (isempty == "YES") then
        db:exec(
            [[
                INSERT INTO status VALUES( "문자",    "TRUE" );
                INSERT INTO status VALUES( "캘린더",  "TRUE" );
                INSERT INTO status VALUES( "연락처",  "TRUE" );
                INSERT INTO status VALUES( "갤러리",  "TRUE" );
                INSERT INTO status VALUES( "은행",    "FALSE" );
                INSERT INTO status VALUES( "밴드",    "FALSE" );
                INSERT INTO status VALUES( "녹음",    "FALSE" );
                INSERT INTO status VALUES( "톡톡",    "FALSE" );
                INSERT INTO status VALUES( "비밀갤러리", "FALSE" );
                
                INSERT INTO status VALUES( "독백", "FALSE" );
            ]]
        )
        for i = 1, #data, 1 do
            print(i, data[i].name, data[i].content, data[i].opened)
            local sql = [[INSERT INTO clue VALUES (']]..i..[[', ']]..data[i].name..[[', ']]..data[i].content..[[', ']]..data[i].opened..[[');]]
            db:exec(sql)  
        end
    end
    chatUI[3]:addEventListener( "tap", nextDialog )

    sceneGroup:insert( background )
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
    
    if phase == "will" then
    elseif phase == "did" then
    end
end

function scene:destroy( event )
    local sceneGroup = self.view
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene

-----------------------------------------------------------------------------------------
--
-- db.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()
local font = "font/KM.ttf"

local sqlite3 = require( "sqlite3" )
local path = system.pathForFile( "data.db", system.DocumentsDirectory )
local db = sqlite3.open( path )
    
function scene:create( event )
	local sceneGroup = self.view

	local start = {}
	start[0] = display.newRect(display.contentWidth/2, display.contentHeight/2, display.contentWidth, display.contentHeight)
	start[0]:setFillColor( 0 )
	start[1] = display.newText({ text="대충 DB를 만들었다는 뜻", x=300, y=1000, fontSize=48, align="left" })
	start[1]:setFillColor( 1 )

    --db:exec([[DROP TABLE status]])
    db:exec(
    [[
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
            name = "비밀갤러리",
            content = "비밀번호(밴드)",
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
        }
    }
    --print(#data)

    for i = 1, #data, 1 do
        print(i, data[i].name, data[i].content, data[i].opened)
        local sql = [[INSERT INTO clue VALUES (']]..i..[[', ']]..data[i].name..[[', ']]..data[i].content..[[', ']]..data[i].opened..[[');]]
        db:exec(sql)  
    end

    local result_s = {}
    local result_c = {}

    i = 1
    for row in db:nrows("SELECT * FROM status") do
        result_s[i] = { name="", opened="" }
        result_s[i].name = row.name
        result_s[i].opened = row.opened
        local t = display.newText( result_s[i].name .. " " .. result_s[i].opened, 50, 30 * i, nil, 16 )
        i = i + 1
    end
    
    i = 1
    for row in db:nrows("SELECT * FROM clue") do
        result_c[i] = { name="", content="", opened="" }
        result_c[i].name = row.name
        result_c[i].content = row.content
        result_c[i].opened = row.opened
    	local t = display.newText( row.id .. " " .. result_c[i].name .. " " .. result_c[i].content .. " " .. result_c[i].opened, 500, 30 * i, nil, 16 )
    	i = i + 1
	end

	sceneGroup:insert( start[0] )
	sceneGroup:insert( start[1] )
end

function scene:show( event )
end

function scene:hide( event )
end

function scene:destroy( event )
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene

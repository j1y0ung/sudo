-----------------------------------------------------------------------------------------
--
-- password.lua
--
-- 개발 : 냨냨
--
-----------------------------------------------------------------------------------------

local widget = require( "widget" )
local composer = require( "composer" )
local scene = composer.newScene()
local time = os.date( '*t' )

local i, j
local font = "font/KM.ttf"
local bold = "font/KB.ttf"


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

local dialog = {}
dialog[1] = {
	"모든 자산은 아내가 관리했다.\n그렇기에 매달 얼마가, 어디에 사용되는지, 나는 아는 바가 없으며",
	"통장 비밀번호에 대해서는 더더욱 아는 바가 없다.\n그러나 아내에 대해서라면..",
	"...",
	"..정은아..",
	"...",
	"아내, 정은이는 기념일을 챙기는 것을 좋아했다. 어쩌면 비밀번호는 [날짜]와 관련이 있을지도 모른다.",
	"[날짜]와 관련된 정보를 찾아보자."
}

function scene:create( event )
	local sceneGroup = self.view

	local background = display.newImageRect("ui/pass_bg.png", display.contentWidth, display.contentHeight)
	background.x, background.y = display.contentWidth/2, display.contentHeight/2

	local logo_sheet = graphics.newImageSheet( "ui/pass_ico.png", { width=300, height=300, numFrames=9 } )
	local logo_img = display.newImage(logo_sheet, 7)
	logo_img.x, logo_img.y = display.contentWidth/2, 300

	local circle = {}
	circle[0] = display.newCircle(175, 597, 20)
	circle[0]:setFillColor(1, 1, 0)
	circle[0].alpha = 0
	circle[1] = display.newCircle(298, 597, 20)
	circle[1]:setFillColor(1, 1, 0)
	circle[1].alpha = 0
	circle[2] = display.newCircle(421, 597, 20)
	circle[2]:setFillColor(1, 1, 0)
	circle[2].alpha = 0
	circle[3] = display.newCircle(545, 597, 20)
	circle[3]:setFillColor(1, 1, 0)
	circle[3].alpha = 0

	local sqlite3 = require( "sqlite3" )
	local path = system.pathForFile( "data.db", system.DocumentsDirectory )
	local db = sqlite3.open( path )

	local data
    for row in db:nrows("SELECT * FROM status WHERE name = '은행'") do
        data = row.opened
	end
	print(data)
	if data == 'TRUE' then
    	composer.removeScene(composer.getSceneName( "current" ))
		composer.gotoScene("bank_start")
	end

	local count = 0
	local passwd = ""
	local answer = "0414"
	function input( event )
		if string.find(event.target.name, '10') ~= nil then
			passwd = passwd .. '*'
		elseif string.find(event.target.name, '11') ~= nil then
			passwd = passwd .. 0
		elseif string.find(event.target.name, '12') ~= nil then
			passwd = passwd .. '#'
		else
			passwd = passwd .. event.target.name
		end
		circle[count].alpha = 1
		count = count + 1
		if count == 4 then
			if passwd == answer then
   				composer.removeScene(composer.getSceneName( "current" ))
				composer.gotoScene("bank_start")
				local sql = [[UPDATE status SET opened = 'TRUE' WHERE name = '은행';]]
				db:exec(sql)
			else
				for i = 0, 3, 1 do
					transition.to( circle[i], {time=1000, alpha=0} )
				end
				count = 0
				passwd = ""
			end
		end
	end

	local num = {}
	for i = 0, 3, 1 do
		num[1 + 3*i] = display.newImageRect(logo_sheet, 8, 110, 110)
		num[1 + 3*i].x, num[1 + 3*i].y = 190, 770 + i*110
		num[2 + 3*i] = display.newImageRect(logo_sheet, 8, 110, 110)
		num[2 + 3*i].x, num[2 + 3*i].y = 360, 770 + i*110
		num[3 + 3*i] = display.newImageRect(logo_sheet, 8, 110, 110)
		num[3 + 3*i].x, num[3 + 3*i].y = 530, 770 + i*110
	end
	for i = 1, 12, 1 do
		num[i].name = i
		num[i]:addEventListener( "tap", input )
	end

	sceneGroup:insert( background )
	sceneGroup:insert( logo_img )
	for i = 1, #num, 1 do
		sceneGroup:insert( num[i] )
	end
	for i = 0, #circle, 1 do
		sceneGroup:insert( circle[i] )
	end

    local bottombar = display.newRect(display.contentCenterX, 1220, display.contentWidth, 120)
    bottombar:setFillColor( 0 )

    local noteBtn = widget.newButton( { id = "notebtn", left = 110, top = 1170, width = 100, height = 100, defaultFile = "imgsources/clueNote.png", onRelease = gotoCluenote } )
    local homeBtn = widget.newButton( { id = "homebtn", left = 325, top = 1180, width = 80, height = 80, defaultFile = "imgsources/w_home.png", onRelease = gotoHome } )
    local backBtn = widget.newButton( { id = "backbtn", left = 540, top = 1180, width = 80, height = 80, defaultFile = "imgsources/w_back.png", onRelease = gotoBack } )
   
	i = 1
	local dIndex = 1
	local aIndex = 1

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

	for row in db:nrows("SELECT * FROM clue WHERE name = '독백' AND content = '2은행비번'") do
        data = row.opened
	end
	if data == 'FALSE' then
		nextDialog()
		db:exec([[UPDATE clue SET opened = 'TRUE' WHERE name = '독백' AND content = '2은행비번';]])
	else
		for i = 1, #chatUI, 1 do chatUI[i].alpha = 0 end
	end

    sceneGroup:insert(bottombar)
    sceneGroup:insert(noteBtn)
    sceneGroup:insert(homeBtn)
    sceneGroup:insert(backBtn)

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

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene
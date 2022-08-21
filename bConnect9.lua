-----------------------------------------------------------------------------------------
--
-- bConnect9.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local widget = require("widget")
local scene = composer.newScene()
local time = os.date( '*t' )


-- 단서노트 클릭
local function gotoCluenote()
    print("단서노트 클릭")
    composer.removeScene("bConnect9")
    composer.gotoScene("clueNote")
end

-- 홈버튼 클릭
local function gotoHome()
    print("홈버튼 클릭")
    composer.removeScene("bConnect9")
    composer.gotoScene("game_main")
end

-- 뒤로가기 버튼 클릭
local function gotoBack()
    print("뒤로가기 버튼 클릭")
    composer.removeScene("bConnect9")
    composer.gotoScene("bView1")
end

local sqlite3 = require( "sqlite3" )
local path = system.pathForFile( "data.db", system.DocumentsDirectory )
local db = sqlite3.open( path )

local dialog = {}
dialog[0] = {
	"모든 해답은 이 교주라는 사람이 갖고 있다.",
	"도대체 무엇이 딸을 죽일 정도로 이 사람을 맹신하게 했는가.",
	"[전화]",
	string.format("[2020-02-03 %02d:%02d:%02d 녹음이 저장되었습니다.]", time.hour, time.min, time.sec),	-- 휴대폰 시간 따와도 ㄱㅊ할듯
	"!",
	"통화가 끝나면 자동으로 녹음이 저장된다. 그렇다면.."
}

function scene:create( event )
	local sceneGroup = self.view
	
	local background = display.newRect( display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight )
	background:setFillColor( 1 )	-- white

	-- 상단바는 움직이지 않게
	local topBar = display.newImageRect("images/connectTop.png", display.contentWidth, 150)
	topBar.x = display.contentCenterX
	topBar.y = 100

	-- 취소 버튼(뒤로 가기)
	local function goBack(event)
		composer.gotoScene("bView1")	
	end

	local cancelButton = widget.newButton(
		{
			width = 60,
			height = 60,
			defaultFile = "images/cancel.png",
			onPress = goBack
		}
	)
	cancelButton.x = 60
	cancelButton.y = 120

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
            
            backBtn.alpha = 1
	        db:exec([[UPDATE clue SET opened = 'TRUE' WHERE name = '독백' AND content = '6교주';]])
        end
    end
    for i = 1, #chatUI, 1 do chatUI[i].alpha = 0 end
    chatUI[3]:addEventListener( "tap", nextDialog )

    function checkLast()
	    for row in db:nrows("SELECT * FROM clue WHERE name = '독백' AND content = '6교주'") do
	        data = row.opened
	    end
	    print(data)

	    if data == 'FALSE' then
	        nextDialog()
	    end
	end

	local scrollView
	local function scrollListener( event )
		if ( event.limitReached ) then
			checkLast()
		end
	 
	    return true
	end

	-- Create the widget
	scrollView = widget.newScrollView(
		{
			top = 170,
			width = display.contentWidth,
			height = display.contentHeight-380,
			listener = scrollListener
		}
	)
 
	-- 하단바는 움직이지 않게
	local bottomBar = display.newImageRect("images/connectBottom.png", display.contentWidth, 150)
	bottomBar.x = display.contentCenterX
	bottomBar.y = 1132

	-- Create a image and insert it into the scroll view
	local content = display.newImageRect("images/connectC9.png", display.contentWidth, 13500)
	content.x = display.contentCenterX
	content.y = 6780

	scrollView:insert( content )

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
	
	-- all objects must be added to group (e.g. self.view)
	sceneGroup:insert( background )
	sceneGroup:insert( topBar )
	sceneGroup:insert( cancelButton )
	sceneGroup:insert( scrollView )
	sceneGroup:insert( bottomBar)
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

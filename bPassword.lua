-----------------------------------------------------------------------------------------
--
-- bPassword.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local widget = require("widget")
local scene = composer.newScene()
local font = "font/KM.ttf"

-- 단서노트 클릭
local function gotoCluenote()
    print("단서노트 클릭")
    composer.removeScene("bPassword")
    composer.gotoScene("clueNote")
end

-- 홈버튼 클릭
local function gotoHome()
    print("홈버튼 클릭")
    composer.removeScene("bPassword")
    composer.gotoScene("game_main")
end

-- 뒤로가기 버튼 클릭
local function gotoBack()
    print("뒤로가기 버튼 클릭")
    composer.removeScene("bPassword")
    -- composer.gotoScene("gallery_main")
end

function scene:create( event )
	local sceneGroup = self.view
	
	local background = display.newRect( display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight )
	background:setFillColor( 0 )	-- black
	
	local title = display.newText("비밀번호입력", display.contentCenterX, 140, font, 100)

	local enterSpace = display.newRoundedRect(display.contentCenterX, 350, 550, 150, 20)
	enterSpace:setFillColor(0.7)
	enterSpace.strokeWidth = 8
	enterSpace:setStrokeColor(1)

	-- 진짜 비밀번호
	local rightPw = {1, 1, 1, 1}

	-- 비밀번호 받기
	local passwd = {}
	-- 비밀번호 시도한 횟수
	local cntTry = 0

	local function checkPasswd(event)
    	cntTry = cntTry + 1
    	print(cntTry)
    	
    	-- 입력한 비밀번호가 맞는지 확인
    	for i = 1, 4 do
    		if passwd[i] ~= rightPw[i] then
    			break
    		end

    		if (i == 4 and passwd[i] == rightPw[i]) then
    			print("right password")
    			composer.gotoScene("bTitle")    		
    		elseif (i ~= 4 or passwd[i] ~= rightPw[i]) then
    			print("wrong password")
    		end
    	end

    end

	-- 힌트는 처음에는 없다가 (안 보이도록) 10번 이상 틀리면 나타나게 함
	local hint = display.newText("힌트 : 4자리", display.contentCenterX, 500, font, 50)
	
	local digit = {1, 2, 3, 4, 5, 6, 7, 8, 9, 0}

	local function click1Event(event)
		if ( "ended" == event.phase ) then
        	print( "Button1 was pressed and released" )
    	end

    	if (table.maxn(passwd) == 4) then
    		print("full table")
    		for i = #passwd, 1, -1 do
    			table.remove(passwd, i)
    		end
    		passwd[1] = 1

    	elseif (table.maxn(passwd) < 4) then
    		print("not full")
    		passwd[table.maxn(passwd)+1] = 1
    	end
    	
    	print(table.maxn(passwd))
    	if (table.maxn(passwd) == 4) then
    		checkPasswd()
    	end

	end

	local button1 = widget.newButton(
		{
			x = 180,
			y = 680,
			id = "button1",
			label = digit[1],
			font = font,
			fontSize = 80,
			labelColor = {default = {1}},
			onPress = click1Event
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

	-- all objects must be added to group (e.g. self.view)
	sceneGroup:insert( background )
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

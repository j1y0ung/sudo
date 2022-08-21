-----------------------------------------------------------------------------------------
--
-- view1.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()
local widget = require( "widget" )
local Num = 0
local font = "font/KM.ttf"

-- 단서노트 클릭
local function gotoCluenote()
    print("단서노트 클릭")
    composer.removeScene("view1")
    composer.gotoScene("clueNote")
end

-- 홈버튼 클릭
local function gotoHome()
    print("홈버튼 클릭")
    composer.removeScene("view1")
    composer.gotoScene("game_main")
end

-- 뒤로가기 버튼 클릭
local function gotoBack()
    print("뒤로가기 버튼 클릭")
    composer.removeScene("view1")
    composer.gotoScene("game_main")
end

function scene:create( event )
	local sceneGroup = self.view
	
	local background = display.newRect( display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight )
	background:setFillColor( 0.97 )	-- white

	local top_bar = display.newRect(display.contentCenterX, 40, 1000, 80)
 	top_bar:setFillColor(0)
 	local wifi = display.newImageRect("symbol/wifi.png", 70, 70)
	wifi.x, wifi.y = 500, 30
	local battery = display.newImageRect("symbol/battery.png", 70, 70)
	battery.x, battery.y = 670, 40
	local remain = display.newText("34%", 600, 40, font, 35)
    remain:setFillColor( 1 )


	local day = display.newRect( 0, 200, 1500, 80 )
	day:setFillColor( 0.7 )	-- 회색바


	local day_d = {"일", "월", "화", "수", "목", "금", "토"}
	local showText = {}
	showText[1] = display.newText( day_d[1], 50, 200 )
	showText[1].size = 80
	showText[1]:setFillColor(1, 0, 0)
	showText[2] = display.newText( day_d[2], 150, 200 )
	showText[2].size = 80
	showText[3] = display.newText( day_d[3], 250, 200 )
	showText[3].size = 80
	showText[4] = display.newText( day_d[4], 350, 200 )
	showText[4].size = 80
	showText[5] = display.newText( day_d[5], 450, 200 )
	showText[5].size = 80
	showText[6] = display.newText( day_d[6], 550, 200 )
	showText[6].size = 80
	showText[7] = display.newText( day_d[7], 650, 200 )
	showText[7].size = 80
	showText[7]:setFillColor(0, 0, 1)
	
	--week구분
	local line1 = display.newRect( 300, 400, 1400, 5 )
	line1:setFillColor( 0.9 )   
	local line2 = display.newRect( 300, 570, 1400, 5 )
	line2:setFillColor( 0.9 )  
	local line3 = display.newRect( 300, 740, 1400, 5 )
	line3:setFillColor( 0.9 )  
	local line4 = display.newRect( 300, 910, 1400, 5 )
	line4:setFillColor( 0.9 )  

	--전, 후달
	local goJ = display.newText("1월", 50, 130, font, 45)
	goJ:setFillColor(0)
	goJ.name = "1월"
	local goM = display.newText("3월", 650, 130, font, 45)
	goM:setFillColor(0)
	goM.name = "3월"
	
	--전, 후달 이동
	local function go_J()
		composer.removeScene("view1")
		composer.gotoScene("jan")
		print("1월")
	end

	local function go_M()
		composer.removeScene("view1")
		composer.gotoScene("mar")
		print("3월")
	end

	local function tapListener( event )
    	local object = event.target

    	if ( event.phase == "began" ) then
        	display.getCurrentStage():setFocus( object )
    	elseif ( event.phase == "ended" or event.phase == "cancelled" ) then
        	display.getCurrentStage():setFocus( nil )
    	end

    	print( object.name .. " TAP" )
	end

	goJ:addEventListener( "tap", go_J )
	goJ:addEventListener( "tap", function() return true; end )	
	goM:addEventListener( "tap", go_M )
	goM:addEventListener( "tap", function() return true; end )	

	--2월달력
	local year = 2020
	local month = 2
	local days = {}
	local yoon = 0
	local pyear = year - 1
	local yyear = (pyear/4) - (pyear/100) + (pyear/400)
	local stweekday = (pyear + yyear) % 7
	local i, totdays, stthismon, curpos
		days = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31}
	local year_month = display.newText(year.."년"..month.."월", 350, 115, font, 75)
	year_month:setFillColor(0)
	
	--윤년확인
	if (year % 4 == 0) then
		yoon = 1
		if (year % 100 == 0) then 
			yoon = 0
			if (year % 400 == 0) then
				yoon = 1;
			end
		end
	end
	if (yoon == 1) then
		days[2] = 29
	else
		days[2] = 28 
	end

	totdays = stweekday

	for i = 1, month-1, 1 do
		totdays = totdays + days[i]
	end
	stthismon = totdays % 7

	curpos = stthismon

	local date = {}
	local j = math.ceil(curpos)
	local start = 0

	for i = 1, days[month], 1 do
		date[i] = display.newText(i.."", 45, 260, font, 35)
		date[i]:setFillColor(0)
	end

	if j > 6 then
		j = 0
	end

	for i = 1, days[month], 1 do
			date[i].x = (j * 100) + 35
			if j == 0 then
				date[i]:setFillColor(1, 0, 0)
			elseif j == 6 then
				date[i]:setFillColor(0, 0, 1)
			end
			j = j + 1
			curpos = curpos + 1
		if (curpos % 7 >= 6) and (curpos % 7 < 7)then
			for j = i + 1, days[month], 1 do
				date[j].y = date[i].y + 170
			end
			j = 0
		end
	end

	--일정
	local today = display.newCircle( 140, 470, 20 )
	today:setFillColor( 0.7 )

	local promise = display.newText("월급", 440, 965)
	promise.size = 30
	promise:setFillColor(0)

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
	sceneGroup:insert(day)
	sceneGroup:insert(line1)
	sceneGroup:insert(line2)
	sceneGroup:insert(line3)
	sceneGroup:insert(line4)
	sceneGroup:insert(goJ)
	sceneGroup:insert(goM)
	sceneGroup:insert(year_month)
	sceneGroup:insert(today)
	sceneGroup:insert(promise)
	sceneGroup:insert(bottombar)
    sceneGroup:insert(noteBtn)
    sceneGroup:insert(homeBtn)
	sceneGroup:insert(backBtn)
	
	for i = 1, #date, 1 do sceneGroup:insert(date[i]) end
	for i = 1, #showText, 1 do sceneGroup:insert(showText[i]) end
end

function scene:show( event )
end

function scene:hide( event )
end

function scene:destroy( event )
end

---------------------------------------------------------------------------------
composer.hideOverlay( true, "fade", 400 )
-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene

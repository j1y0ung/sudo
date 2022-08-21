-----------------------------------------------------------------------------------------
--
-- my.lua
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

function scene:create( event )
	local sceneGroup = self.view

	local background = display.newImageRect("ui/bg2.png", display.contentWidth, display.contentHeight)
	background.x, background.y = display.contentWidth/2, display.contentHeight/2
	--local background = display.newRect(display.contentWidth/2, display.contentHeight/2, display.contentWidth, display.contentHeight)
	background.alpha = 0
	local background_real = display.newRect(display.contentWidth/2, display.contentHeight/2+155, display.contentWidth, display.contentHeight-155)
	background_real:setFillColor(0.95)

	local banner = display.newImageRect("ui/bank_banner.png", background.width, 150)
	banner.x, banner.y = background.x, 155
--	banner:setFillColor( 0 )
--	local banner_logo = display.newText({text="M은행\n\nMore Trust, More Money", x=banner.x, y=banner.y, fontSize=28, font=font, align="center"})

	local menu = {}
	menu[0] = display.newRect(75, 37.5+155+80, 155, 75)
	menu[0]:setFillColor(0)
	menu[1] = display.newText("뱅킹", menu[0].x, menu[0].y, bold, 24)
	menu[1]:setTextColor(1)

	menu[2] = display.newRect(75+155, menu[0].y, 150, 75)
	menu[2]:setFillColor(0)
	menu[3] = display.newText("카드", menu[2].x, menu[2].y, bold, 24)
	menu[3]:setTextColor(1)

	menu[4] = display.newRect(75+310, menu[0].y, 150, 75)
	menu[4]:setFillColor(1)
	menu[5] = display.newText("MY", menu[4].x, menu[4].y, bold, 24)
	menu[5]:setTextColor(0)

	local info = {}
	info[0] = display.newImageRect("ui/bank_profile.png", 300, 300)
	info[0].x, info[0].y = background.x, background.y-150+80
	info[1] = display.newRect(70, 780+80, 10, 200)
	info[1].strokeWidth=10
	info[1]:setFillColor(0)
	info[1]:setStrokeColor(0)
	info[2] = display.newText(string.format("권정은님\n최근접속 : 2020-02-03 %02d:%02d:%02d", time.hour, time.min, time.sec), info[0].x, info[1].y, font, 36)
	info[2]:setFillColor(0)
	info[3] = display.newRoundedRect(info[0].x, 1050, 540, 100, 50)
	info[3]:setFillColor(0)
	info[4] = display.newText("로그아웃", info[3].x, info[3].y, bold, 36)

	local alert = {}
	alert[0] = display.newRoundedRect(background.x, background.y, 400, 350, 25)
	alert[0]:setFillColor(0.75)
	alert[1] = display.newText({text="알 림\n\n정말 로그아웃 하시겠습니까?", x=alert[0].x, y=alert[0].y-50, font=font, fontSize=36, align="center"})
	alert[1]:setFillColor(0)
	alert[2] = display.newRect(alert[0].x, alert[0].y+75, 350, 10)
	alert[3] = display.newText("예", alert[0].x-350/4, alert[0].y+125, bold, 36)
	alert[4] = display.newText("아니오", alert[0].x+350/4, alert[0].y+125, bold, 36)
	alert[5] = display.newRect(alert[0].x, alert[0].y+125, 5, 36)

	function menuBank()
		composer.gotoScene( "bank_banking", { effect="crossFade", time=1000 } )
	end

	function menuCard()
		composer.gotoScene( "bank_card", { effect="crossFade", time=1000 } )
	end

	function alertYes()
		alert[1].text = "로그아웃에 실패하였습니다.\n고객센터에 문의하세요."
		alert[3].alpha = 0
		alert[4].x = alert[0].x
		alert[4].text = "확인"
		alert[5].alpha = 0
	end

	function showAlert()
		for i = 0, #alert, 1 do alert[i].alpha = 1 end
	end

	function hideAlert()
		if alert[3].alpha == 0 then
			alert[1].text = "알 림\n\n정말 로그아웃 하시겠습니까?"
			alert[4].x = alert[0].x+350/4
			alert[4].text = "아니오"
		end
		for i = 0, #alert, 1 do alert[i].alpha = 0 end
	end
	hideAlert()

	menu[0]:addEventListener( "tap", menuBank )
	menu[1]:addEventListener( "tap", menuBank )
	menu[2]:addEventListener( "tap", menuCard )
	menu[3]:addEventListener( "tap", menuCard )
	info[3]:addEventListener( "tap", showAlert )
	info[4]:addEventListener( "tap", showAlert )
	alert[3]:addEventListener( "touch", alertYes )
	alert[4]:addEventListener( "touch", hideAlert )

	sceneGroup:insert( background )
	sceneGroup:insert( background_real )
	sceneGroup:insert( banner )
	--sceneGroup:insert( banner_logo )

	for i = 0, #menu, 1 do sceneGroup:insert( menu[i] ) end
	for i = 0, #info, 1 do sceneGroup:insert( info[i] ) end
	for i = 0, #alert, 1 do sceneGroup:insert( alert[i] ) end

local function gotoCluenote()
    composer.gotoScene("clueNote")
end

local function gotoHome()
    composer.removeScene(composer.getSceneName( "current" ))
    composer.gotoScene("game_main")
end

local function gotoBack()
    composer.removeScene(composer.getSceneName( "current" ))
    composer.gotoScene(composer.getSceneName( "previous" ))
end

    local bottombar = display.newRect(display.contentCenterX, 1220, display.contentWidth, 120)
    bottombar:setFillColor( 0 )

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

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene
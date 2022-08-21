-----------------------------------------------------------------------------------------
--
-- banking.lua
--
-- 개발 : 냨냨
--
-----------------------------------------------------------------------------------------

local widget = require( "widget" )
local composer = require( "composer" )
local scene = composer.newScene()

local i, j
local font = "font/KM.ttf"
local bold = "font/KB.ttf"


function scene:create( event )
	local sceneGroup = self.view

	local background = display.newRect(display.contentWidth/2, display.contentHeight/2+155, display.contentWidth, display.contentHeight-155)
	background:setFillColor(0.95)
	local banner = display.newImageRect("ui/bank_banner.png", background.width, 150)
	banner.x, banner.y = background.x, 155

	local menu = {}
	menu[0] = display.newRect(75, 37.5+155+80, 155, 75)
	menu[0]:setFillColor(1)
	menu[1] = display.newText("뱅킹", menu[0].x, menu[0].y, bold, 24)
	menu[1]:setTextColor(0)

	menu[2] = display.newRect(75+155, menu[0].y, 150, 75)
	menu[2]:setFillColor(0)
	menu[3] = display.newText("카드", menu[2].x, menu[2].y, bold, 24)
	menu[3]:setTextColor(1)

	menu[4] = display.newRect(75+310, menu[0].y, 150, 75)
	menu[4]:setFillColor(0)
	menu[5] = display.newText("MY", menu[4].x, menu[4].y, bold, 24)
	menu[5]:setTextColor(1)

	local money = {}
	money[0] = display.newRect(background.x, display.contentHeight/2, 300, 300)
	money[1] = display.newImageRect("ui/bank_diamond.png", 500, 500)
	money[1].x, money[1].y = money[0].x, 1070
	money[2] = display.newText({text="예금(M의꿈통장)\n3000-642-138648", x=money[0].x, y=1075-80, font=font, fontSize=36, align="center"})
	money[2]:setTextColor(0)
	money[3] = display.newRect(money[0].x, 1090, 400, 10)
	money[3]:setFillColor(1)
	money[4] = display.newText("계좌잔액표시 ON", money[0].x, 1220-100, bold, 32)
	money[5] = display.newImageRect("ui/bank_send.png", 125, 125)
	money[5].x, money[5].y = 572.5, 337.5+80
	money[7] = display.newText("현재자산\n\n-7,374,950원", background.x, money[0].y, bold, 36)
	money[7]:setTextColor(0)
	money[6] = display.newRect(210, 495, 300, 300)
	money[8] = display.newText("권정은님,\n좋은 하루 되세요.", 180, 490, bold, 32)
	money[8]:setFillColor(0)

	local alert = {}
	alert[0] = display.newRoundedRect(background.x, money[0].y, 400, 350, 25)
	alert[0]:setFillColor(0.75)
	alert[1] = display.newText({text="안 내\n\n거래가 중지된 계좌입니다.", x=alert[0].x, y=alert[0].y-50, font=font, fontSize=36, align="center"})
	alert[1]:setFillColor(0)
	alert[2] = display.newRect(alert[0].x, alert[0].y+75, 350, 10)
	alert[3] = display.newText("확인", alert[0].x, alert[0].y+125, bold, 36)

	function menuCard()
		composer.gotoScene( "bank_card", { effect="crossFade", time=1000 } )
	end

	function menuMY()
		composer.gotoScene( "bank_my", { effect="crossFade", time=1000 } )
	end

	function moneyView()
		print(money[7].text)
		if money[7].text ~= "현재자산\n\n비밀" then
			money[7].text = "현재자산\n\n비밀"
			money[4].text = "계좌잔액표시 OFF"
		else
			money[7].text = "현재자산\n\n-7,374,950원"
			money[4].text = "계좌잔액표시 ON"
		end
	end

	function showAlert()
		for i = 0, #alert, 1 do alert[i].alpha = 1 end
	end

	function hideAlert()
		for i = 0, #alert, 1 do alert[i].alpha = 0 end
	end
	hideAlert()

	menu[2]:addEventListener( "tap", menuCard )
	menu[3]:addEventListener( "tap", menuCard )
	menu[4]:addEventListener( "tap", menuMY )
	menu[5]:addEventListener( "tap", menuMY )
	money[4]:addEventListener( "tap", moneyView )
	money[5]:addEventListener( "tap", showAlert )
	alert[3]:addEventListener( "tap", hideAlert )

	sceneGroup:insert( background )
	sceneGroup:insert( banner )

	for i = 0, #menu, 1 do sceneGroup:insert( menu[i] ) end
	for i = 0, #money, 1 do sceneGroup:insert( money[i] ) end
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

-----------------------------------------------------------------------------------------
--
-- card.lua
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

	local background = display.newImageRect("ui/bg2.PNG", display.contentWidth, display.contentHeight)
	background.x, background.y = display.contentWidth/2, display.contentHeight/2
	--local background = display.newRect(display.contentWidth/2, display.contentHeight/2, display.contentWidth, display.contentHeight)
	background.alpha = 0
	local background_real = display.newRect(display.contentWidth/2, display.contentHeight/2+155, display.contentWidth, display.contentHeight-155)
	background_real:setFillColor(0.95)

	local banner = display.newImageRect("ui/bank_banner.png", background.width, 150)
	banner.x, banner.y = background.x, 75+80
--	banner:setFillColor( 0 )
--	local banner_logo = display.newText({text="M은행\n\nMore Trust, More Money", x=banner.x, y=banner.y, fontSize=28, font=font, align="center"})

	local menu = {}
	menu[0] = display.newRect(75, 37.5+155+80, 155, 75)
	menu[0]:setFillColor(0)
	menu[1] = display.newText("뱅킹", menu[0].x, menu[0].y, bold, 24)
	menu[1]:setTextColor(1)

	menu[2] = display.newRect(75+155, menu[0].y, 150, 75)
	menu[2]:setFillColor(1)
	menu[3] = display.newText("카드", menu[2].x, menu[2].y, bold, 24)
	menu[3]:setTextColor(0)

	menu[4] = display.newRect(75+310, menu[0].y, 150, 75)
	menu[4]:setFillColor(0)
	menu[5] = display.newText("MY", menu[4].x, menu[4].y, bold, 24)
	menu[5]:setTextColor(1)

	local card = {}
	card[0] = display.newImageRect("ui/bank_btn2.png", 200, 60)
	card[0].x, card[0].y = 110, 380

	local info = {}
	info[0] = display.newRect(70, 675, 10, 600)
	info[0].strokeWidth=10
	info[0]:setFillColor(0)
	info[0]:setStrokeColor(0)
	info[1] = display.newText("내가 받은 혜택", 225, 435, bold, 48)
	info[1]:setFillColor(0)
	info[2] = display.newText("이달의 혜택\n\n\n누적 혜택", 187, 570, bold, 36)
	info[2]:setFillColor(0.1)
	info[3] = display.newText("0원\n\n\n0원", 620, 570, bold, 36)
	info[3]:setFillColor(0)
	info[4] = display.newText("청구 할인\n무이자 할인", 165, 570, font, 28)
	info[4]:setFillColor(0.25)
	info[5] = display.newText("0원\n0원", 625, 570, font, 28)
	info[5]:setFillColor(0.25)	
	info[6] = display.newText("나의 포인트/마일리지", 285, 745, bold, 48)
	info[6]:setFillColor(0)
	info[7] = display.newText("이달의 포인트\n0P\n\n이달의 항공마일리지\n0M", 215, 890, font, 32)
	info[7]:setFillColor(0.25)
	info[8] = display.newRect(background.x, 690, 550, 10)
	for i = 0, #info, 1 do info[i].y = info[i].y + 80 end

	function menuBank()
		composer.gotoScene( "bank_banking", { effect="crossFade", time=1000 } )
	end

	function menuCard()
		composer.gotoScene( "bank_card", { effect="crossFade", time=500 } )
	end

	function menuMY()
		composer.gotoScene( "bank_my", { effect="crossFade", time=1000 } )
	end
	
	menu[0]:addEventListener( "tap", menuBank )
	menu[1]:addEventListener( "tap", menuBank )
	menu[4]:addEventListener( "tap", menuMY )
	menu[5]:addEventListener( "tap", menuMY )
	card[0]:addEventListener( "tap", menuCard )

	sceneGroup:insert( background )
	sceneGroup:insert( background_real )
	sceneGroup:insert( banner )
	--sceneGroup:insert( banner_logo )

	for i = 0, #menu, 1 do sceneGroup:insert( menu[i] ) end
	for i = 0, #card, 1 do sceneGroup:insert( card[i] ) end
	for i = 0, #info, 1 do sceneGroup:insert( info[i] ) end

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
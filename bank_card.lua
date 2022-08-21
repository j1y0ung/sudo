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
	card[0] = display.newImageRect("ui/bank_btn1.png", 200, 60)
	card[0].x, card[0].y = 110, 380

	local info = {}
	info[0] = display.newRect(70, 625, 10, 500)
	info[0].strokeWidth=10
	info[0]:setFillColor(0)
	info[0]:setStrokeColor(0)
--	info[0].alpha = 0.5
	info[1] = display.newText("내달 결제예정 금액", 265, 435, bold, 48)
	info[1]:setFillColor(0)
	info[2] = display.newText("7,374,950원", 190, 510, font, 36)
	info[2]:setFillColor(0.25)
	info[3] = display.newRect(background.x, 575, 620, 10)
	info[3]:setFillColor(1)
	info[4] = display.newText("이용대금 명세서", 240, 645, bold, 48)
	info[4]:setFillColor(0)
	info[5] = display.newText("7,374,950원", 190, 725, font, 36)
	info[5]:setFillColor(0.25)
	info[6] = display.newRect(info[3].x, 790, 550, 10)
	info[6].alpha=0
	info[7] = display.newText("이용금액\n잔여한도\n총 이용한도\n", 150, 840, font, 28)
	info[7]:setFillColor(0)
	info[8] = display.newText({text="7,374,950원\n-원\n-원", x=550, y=825, font=font, fontSize=28, align="right"})
	info[8]:setFillColor(0.25)
	for i = 0, #info, 1 do info[i].y = info[i].y + 80 end 

	local show = {}
	show[0] = display.newRoundedRect(510, 1050, 300, 100, 50)
	show[0]:setFillColor(0)
	show[1] = display.newText("이용내역조회", show[0].x, show[0].y, bold, 36)

	function menuBank()
		composer.gotoScene( "bank_banking", { effect="crossFade", time=1000 } )
	end

	function menuCard()
		composer.gotoScene( "bank_card_dum", { effect="crossFade", time=500 } )
	end

	function menuInfo()
		composer.gotoScene( "bank_card_info", { effect="crossFade", time=500 } )
	end

	function menuMY()
		composer.gotoScene( "bank_my", { effect="crossFade", time=1000 } )
	end
	
	menu[0]:addEventListener( "tap", menuBank )
	menu[1]:addEventListener( "tap", menuBank )
	menu[4]:addEventListener( "tap", menuMY )
	menu[5]:addEventListener( "tap", menuMY )
	card[0]:addEventListener( "tap", menuCard )
	show[0]:addEventListener( "tap", menuInfo )
	show[1]:addEventListener( "tap", menuInfo )

	sceneGroup:insert( background )
	sceneGroup:insert( background_real )
	sceneGroup:insert( banner )
--	sceneGroup:insert( banner_logo )

	for i = 0, #menu, 1 do sceneGroup:insert( menu[i] ) end
	for i = 0, #card, 1 do sceneGroup:insert( card[i] ) end
	for i = 0, #info, 1 do sceneGroup:insert( info[i] ) end
	for i = 0, #show, 1 do sceneGroup:insert( show[i] ) end

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
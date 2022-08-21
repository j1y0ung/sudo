-----------------------------------------------------------------------------------------
--
-- epilogue.lua
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
	"녹음을 다시 듣는다.",
	"아내는 대체 왜 이런 녹음을 남겼을까.\n아내의 휴대폰에 남은 흔적을 이번에는 거꾸로 돌아가본다.",
	"그 단서들이 내 머릿속을 떠나지 않는다.",
	"아내는 정말 이런 방법이 딸을 위한 것이라고 생각한 것일까\n그런 말도 안되는 약이..",
    "정은아 너는 왜 그랬을까\n너의 선택을 이해할 수가 없다. ",
    "...",
	"내 아내는, 그녀는 그렇게 죽었다.\n두 딸을 데리고.",
	"그럼에도 나는 살아가야 하는 것일까",
	"나는 무엇을 목적으로 앞으로를 살아가야 할까",
	"나의 무관심함이 아내의 연락을 끊게 했고",
	"그런 아내와의 관계로 인해 가족들에게서 나는 의지할 수 없는 사람이었다.",
	"가장 힘들 때 연락할 수 없는 사람이었다.",
	"죄책감에서 벗어나고 싶다.",
	"보고 싶다."
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
	local aIndex = 0

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
			composer.gotoScene( "menu", { effect="crossFade", time=2000 } )
		end
	end
	nextDialog()
	
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

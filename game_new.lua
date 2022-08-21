-----------------------------------------------------------------------------------------
--
-- dokbak.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()
local font = "font/KM.ttf"
local time = os.date( '*t' )
local start = composer.getVariable("start")

local dialog = {}
dialog[0] = {
	"나는 어제 교수를 죽였다.",
	"이유는 터무니없다.",
	"과제가 너무 많았기 때문이다.",
	"내가 지 수업만 듣는 줄 아나보지"
}
dialog[1] = {
	"어제",
	"아내와 딸들이 모두 죽었다.",
	"나는 좋은 남편, 아버지는 아니었다.",
	"생업을 이어나가기 위해서, 우리는 주말부부 생활을 계속할 수밖에 없었다.\n그러나 나는 내가 할 수 있는 최선을 다했다.",
	"그러나 대체 이게 무슨 운명의 장난이란 말인가?",
	"[알람소리]",
	"[D-0 분납 2차입금]",
	"그래. 아내의 휴대폰.",
	"죽은 이들은 살려낼 수 없다.\n그러나 죽은 이유는 찾아낼 수 있지 않겠는가.",
	"휴대폰, 휴대폰에서 답을 찾아보자.\n휴대폰은 분명 답을 알고 있을 것이다."
}
dialog[2] = {
	"모든 자산은 아내가 관리했다.\n그렇기에 매달 얼마가, 어디에 사용되는지, 나는 아는 바가 없으며",
	"통장 비밀번호에 대해서는 더더욱 아는 바가 없다.\n그러나 아내에 대해서라면..",
	"...",
	"..은정아..",
	"...",
	"아내, 은정이는 기념일을 챙기는 것을 좋아했다. 어쩌면 비밀번호는 [날짜]와 관련이 있을지도 모른다.",
	"[날짜]와 관련된 정보를 찾아보자."
}
dialog[3] = {
	"...",
	"나는 내 아내를 잘 안다고 생각했는데, 그것은 나의 오만이었다.",
	"...",
	"..왜 이런 선택을 했니?",
	"엄청난 빚의 액수.\n무엇이 너를 이렇게까지 극한으로 몰고 갔을까.",
	"정녕 빚 때문에 이렇게 된거야?"
}
dialog[4] = {	--[두리안카페] 서로 다른 항목 5개 이상 클릭
	"두리안카페.. 두리안카페..\n두리안카페.. 두리안카페..\n두리안카페.",
	"은정이는 맛집이든 카페든, 탐방을 좋아했다.",
	"그런데 어느 시점 이후로부터 두리안카페만 계속 방문했다.",
	"확실한 것은 여기 이 집에 이사올 때만 해도 그런 카페가 없었다는 것이다. 새로 생긴 곳인가?"
}
dialog[5] = {
	"경악스럽다.",
	"믿을 수가 없다.",
	"내가 본 것이 아니라고, 누군가가 조작한 것이라고 믿고 싶다.",
	"도대체 왜 이런 짓을 한단 말인가?",
	"내가 아는 아내는 이런 말을 할 사람이 아니다.",
	"그게 아니라면 지금까지 내가 보아 온 모습은 모두 허상이었던가."
}
dialog[6] = {	--횡설수설하는 부분 클릭?
	"모든 해답은 이 사람이 갖고 있다.",
	"과연 횡설수설하는 모습도 진짜 모습일까, 꾸며진 모습일까.",
	"[전화]",
	string.format("[2020-02-03 %02d:%02d:%02d 녹음이 저장되었습니다.]", time.hour, time.min, time.sec),	-- 휴대폰 시간 따와도 ㄱㅊ할듯
	"!",
	"통화가 끝나면 자동으로 녹음이 저장된다. 그렇다면.."
}

function scene:create( event )
	local sceneGroup = self.view

	local background = display.newImageRect("ui/bg6.png", display.contentWidth, display.contentHeight)
	background.x, background.y = display.contentWidth/2, display.contentHeight/2

	local chatUI = {}
	chatUI[1] = display.newRect(display.contentWidth/2, display.contentHeight-150, display.contentWidth, 300)
	chatUI[1]:setFillColor(0, 0, 0, 0.75)
	chatUI[2] = display.newText("대충 대사라는 뜻", chatUI[1].x, chatUI[1].y, chatUI[1].width-100, chatUI[1].height-100, font, 36)
	chatUI[3] = display.newText("▶ 다음", display.contentWidth-100, display.contentHeight-75, 128, 36, font, 36)
	chatUI[3]:setFillColor(1, 1, 0)

	local i = 1
	local dIndex = 1
	local aIndex = start

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

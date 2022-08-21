-----------------------------------------------------------------------------------------
--
-- password.lua
--
-- 개발 : 냨냨
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()
local time = os.date( '*t' )

local i, j
local font = native.systemFont
local bold = native.systemFontBold

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

	local count = 0
	local passwd = ""
	local answer = "123#"
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
				print("정답입니다!")
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
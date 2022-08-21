-----------------------------------------------------------------------------------------
--
-- bank_start.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view
	
	local function startBanking( event )
		composer.gotoScene( "bank_banking", { effect="slideUp", time=1000 } )
	end

	local start = {}
	start[0] = display.newRect(display.contentWidth/2, display.contentHeight/2, display.contentWidth, display.contentHeight)
	start[0]:setFillColor( 0 )
	start[1] = display.newImageRect("ui/bank_logo.png", display.contentWidth, display.contentWidth)
	start[1].x, start[1].y = display.contentWidth/2, display.contentHeight/2

	start[0]:addEventListener( "tap", startBanking )

	sceneGroup:insert( start[0] )
	sceneGroup:insert( start[1] )
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

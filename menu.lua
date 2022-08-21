-----------------------------------------------------------------------------------------
--
-- menu.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()
local newNum = 0
local font = "font/KM.ttf"

local path = system.pathForFile( "data.db", system.DocumentsDirectory )
local db = io.open( path )

local function changeNum()
	newNum = 1
end

-- 새로하기 클릭
local function gotoGame()
	composer.setVariable("start", newNum)
	composer.removeScene("menu")
	composer.gotoScene("prologue")
end

local function gotoRelay()
	if db then
		io.close( db )
		composer.setVariable("start", newNum)
		composer.removeScene("menu")
		composer.gotoScene("game_main")
	else
		gotoGame()
	end
end

function scene:create( event )
	local sceneGroup = self.view
---------------------------
	-- local systemFonts = native.getFontNames()
 
	-- -- Set the string to query for (part of the font name to locate)
	-- local searchString = "pt"
	
	-- -- Display each font in the Terminal/console
	-- for i, fontName in ipairs( systemFonts ) do
	
	-- 	local j, k = string.find( string.lower(fontName), string.lower(searchString) )
	
	-- 	if ( j ~= nil ) then
	-- 		print( "Font Name = " .. tostring( fontName ) )
	-- 	end
	-- end
	-------------------------------
	local background = display.newRect( display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight )
	background:setFillColor( 0.1, 0.1, 0.1 ) -- 어두운 회색
	
	local logo = display.newImageRect("imgsources/logo.png", 250, 250)
	logo.x, logo.y = display.contentWidth/2, display.contentHeight/4

	function exitgame()
		native.requestExit();
	end

	local new = display.newText("새로하기", 360, 600, font, 75)
	new:addEventListener("tap", changeNum)
	new:addEventListener("tap", gotoGame)
	local resume = display.newText("이어하기", 360, 750, font, 75)
	resume:addEventListener("tap", gotoRelay)
	local exit = display.newText("종료하기", 360, 900, font, 75)
	exit:addEventListener("tap", exitgame)

	sceneGroup:insert(background)
    sceneGroup:insert(logo)
    sceneGroup:insert(new)
    sceneGroup:insert(resume)
    sceneGroup:insert(exit)
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
-----------------------------------------------------------------------------------------
--
-- password.lua
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

-- 단서노트 클릭
local function gotoCluenote()
    print("단서노트 클릭")
    composer.removeScene(composer.getSceneName( "current" ))
    composer.gotoScene("clueNote")
end

-- 홈버튼 클릭
local function gotoHome()
    print("홈으로가기")
    composer.removeScene(composer.getSceneName( "current" ))
    composer.gotoScene("game_main")
end

-- 뒤로가기 버튼 클릭
local function gotoBack()
    print("뒤로가기")
    composer.removeScene(composer.getSceneName( "current" ))
    composer.gotoScene(composer.getSceneName( "previous" ))
end

function scene:create( event )
   local sceneGroup = self.view

   local background = display.newImageRect("ui/pass_bg.png", display.contentWidth, display.contentHeight)
   background.x, background.y = display.contentWidth/2, display.contentHeight/2

   local logo_sheet = graphics.newImageSheet( "ui/pass_ico.png", { width=300, height=300, numFrames=9 } )
   local logo_img = display.newImage(logo_sheet, 4)
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

  local sqlite3 = require( "sqlite3" )
  local path = system.pathForFile( "data.db", system.DocumentsDirectory )
  local db = sqlite3.open( path )

  local data
    for row in db:nrows("SELECT * FROM status WHERE name = '톡톡'") do
        data = row.opened
  end

  if data == 'TRUE' then
    composer.removeScene(composer.getSceneName( "current" ))
    composer.gotoScene("kIntro")
  end

   local count = 0
   local passwd = ""
   local answer = "1374" 	--가족공통 휴대폰번호 뒷자리
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
            composer.removeScene(composer.getSceneName( "current" ))
            composer.gotoScene("kIntro")
            local sql = [[UPDATE status SET opened = 'TRUE' WHERE name = '톡톡';]]
            db:exec(sql)
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
   for i = 1, #num, 1 do
      sceneGroup:insert( num[i] )
   end
   for i = 0, #circle, 1 do
      sceneGroup:insert( circle[i] )
   end

    local bottombar = display.newRect(display.contentCenterX, 1220, display.contentWidth, 120)
    bottombar:setFillColor( 0 )

    local noteBtn = widget.newButton( { id = "notebtn", left = 110, top = 1170, width = 100, height = 100, defaultFile = "imgsources/clueNote.png", onRelease = gotoCluenote } )
    local homeBtn = widget.newButton( { id = "homebtn", left = 325, top = 1180, width = 80, height = 80, defaultFile = "imgsources/w_home.png", onRelease = gotoHome } )
    local backBtn = widget.newButton( { id = "backbtn", left = 540, top = 1180, width = 80, height = 80, defaultFile = "imgsources/w_back.png", onRelease = gotoBack } )
   
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
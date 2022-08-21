-----------------------------------------------------------------------------------------
--
-- albumPwd.lua
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
    composer.gotoScene("gallery_main")
end

-- 비번 풀면 잠긴앨범 내부로 감
local function gotoLockedAlbum()
    print("비번 맞춤")
    composer.removeScene(composer.getSceneName( "current" ))
    composer.gotoScene("lockedAlbum")
end

function scene:create( event )
	local sceneGroup = self.view

	local background = display.newImageRect("ui/pass_bg.png", display.contentWidth, display.contentHeight)
	background.x, background.y = display.contentWidth/2, display.contentHeight/2

    -- 상단바
    local topbar = display.newRect(display.contentCenterX, 40, display.contentWidth, 80)
    topbar:setFillColor( 0 )

    -- 시계
    local currentTime = os.date("*t")
    local h = currentTime.hour
    local m = currentTime.min
    local time = display.newText(h..":"..m, 80, 40, defaultFont)

    local function clock()
        currentTime = os.date("*t")
        h = currentTime.hour
        m = currentTime.min
        
        -- print("현재시간 = "..currentTime.hour..":"..currentTime.min)
        -- print("clock 호출됨")
        local clockDisplay = string.format("%d:%d", h, m)
        -- print(clockDisplay)
        if h < 12 then
            if m < 10 then
                clockDisplay = string.format("0%d:0%d", h, m)
                time.text = clockDisplay
            elseif m >= 10 then
                clockDisplay = string.format("0%d:%d", h, m)
                time.text = clockDisplay
            end
        elseif h >= 12 then
            if m < 10 then
                clockDisplay = string.format("%d:0%d", h, m)
                time.text = clockDisplay
            elseif m >= 10 then
                clockDisplay = string.format("%d:%d", h, m)
                time.text = clockDisplay
            end
        end
    end
    local clock1 = clock()
    local clock2 = timer.performWithDelay(5000, clock, -1) -- 5초마다 시계 갱신

    -- 와이파이 아이콘
    local wifi = display.newImageRect("imgsources/w_wifi.png", 60, 45)
    wifi.x, wifi.y = 500, 35

    -- 배터리 아이콘
    local battery_t = display.newText("34%", 585, 40, defaultFont)
    local battery = display.newImageRect("imgsources/w_battery.png", 70, 45)
    battery.x, battery.y = 650, 40

    --------------------------------------------------------------------------------------------

    -- 비번창
	local logo_sheet = graphics.newImageSheet( "ui/pass_ico.png", { width=300, height=300, numFrames=9 } )
	local logo_img = display.newImage(logo_sheet, 5)
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
    for row in db:nrows("SELECT * FROM status WHERE name = '비밀갤러리'") do
        data = row.opened
  end

  if data == 'TRUE' then
    gotoLockedAlbum()
  end

	local count = 0
	local passwd = ""
	local answer = "2016"
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
                local sql = [[UPDATE status SET opened = 'TRUE' WHERE name = '비밀갤러리';]]
                db:exec(sql)
                gotoLockedAlbum()
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

    --------------------------------------------------------------------------------------------

    -- 하단바(단서노트, 홈버튼, 뒤로가기)
    local bottombar = display.newRect(display.contentCenterX, 1220, display.contentWidth, 120)
    bottombar:setFillColor( 0 )

    -- 단서노트
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

    -- 홈버튼
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

    -- 뒤로가기
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

	sceneGroup:insert( background )
	sceneGroup:insert( topbar )
	sceneGroup:insert( logo_img )
	sceneGroup:insert( bottombar )
	sceneGroup:insert( noteBtn )
	sceneGroup:insert( homeBtn )
	sceneGroup:insert( backBtn )
    for i = 0, #circle, 1 do
      sceneGroup:insert( circle[i] )
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
local Gamestate = require 'vendor/gamestate'
local Level = require 'level'
local window = require 'window'
local state = Gamestate.new()

local home = require 'menu'
local nextState = 'home'

function state:init()
    state.finished = false
    state.current = 1
    state.assets = {}

    table.insert(state.assets, function()
        Gamestate.load('valley', Level.new('valley.tmx'))
    end)

    table.insert(state.assets, function()
        Gamestate.load('gay island', Level.new('gay island.tmx'))
    end)

     table.insert(state.assets, function()
        Gamestate.load('gay island2', Level.new('gay island2.tmx'))
    end)

    table.insert(state.assets, function()
        Gamestate.load('forest2', Level.new('forest3.tmx'))
    end)

    table.insert(state.assets, function()
        Gamestate.load('abedtown', Level.new('newtown.tmx'))
    end)

    table.insert(state.assets, function()
        Gamestate.load('lab', Level.new('lab.tmx'))
    end)

    table.insert(state.assets, function()
        Gamestate.load('house', Level.new('house.tmx'))
    end)

    table.insert(state.assets, function()
        Gamestate.load('studyroom', Level.new('studyroom.tmx'))
    end)

    table.insert(state.assets, function()
        Gamestate.load('hallway', Level.new('hallway.tmx'))
    end)

    table.insert(state.assets, function()
        Gamestate.load('forest', Level.new('forest2.tmx'))
    end)

    table.insert(state.assets, function()
        Gamestate.load('town', Level.new('town.tmx'))
    end)

    table.insert(state.assets, function()
        Gamestate.load('tavern', Level.new('tavern.tmx'))
    end)

    table.insert(state.assets, function()
        Gamestate.load('blacksmith', Level.new('blacksmith.tmx'))
    end)

    table.insert(state.assets, function()
        Gamestate.load('greendale-exterior', Level.new('greendale-exterior.tmx'))
    end)

    table.insert(state.assets, function()
        Gamestate.load('deans-office-1', Level.new('deans-office-1.tmx'))
    end)

    table.insert(state.assets, function()
        Gamestate.load('deans-office-2', Level.new('deans-office-2.tmx'))
    end)

    table.insert(state.assets, function()
        Gamestate.load('deans-closet', Level.new('deans-closet.tmx'))
    end)
	
    table.insert(state.assets, function()
        Gamestate.load('baseball', Level.new('baseball.tmx'))
    end)

    table.insert(state.assets, function()
        Gamestate.load('dorm-lobby', Level.new('dorm-lobby.tmx'))
    end)

    table.insert(state.assets, function()
        Gamestate.load('borchert-hallway', Level.new('borchert-hallway.tmx'))
    end)

    table.insert(state.assets, function()
        Gamestate.load('admin-hallway', Level.new('admin-hallway.tmx'))
    end)

    table.insert(state.assets, function()
        Gamestate.load('class-hallway-1', Level.new('class-hallway-1.tmx'))
    end)

    table.insert(state.assets, function()
        Gamestate.load('class-hallway-2', Level.new('class-hallway-2.tmx'))
    end)

    table.insert(state.assets, function()
        Gamestate.load('rave-hallway', Level.new('rave-hallway.tmx'))
    end)

    table.insert(state.assets, function()
        Gamestate.load('overworld', require 'overworld')
    end)

    table.insert(state.assets, function()
        Gamestate.load('credits', require 'credits')
    end)

    table.insert(state.assets, function()
        Gamestate.load('select', require 'select')
    end)

    table.insert(state.assets, function()
        Gamestate.load('home', require 'menu')
    end)

    table.insert(state.assets, function()
        Gamestate.load('pause', require 'pause')
    end)

    table.insert(state.assets, function()
        Gamestate.load('cheatscreen', require 'cheatscreen')
    end)

    table.insert(state.assets, function()
        Gamestate.load('instructions', require 'instructions')
    end)

    table.insert(state.assets, function()
        Gamestate.load('options', require 'options')
    end)

    table.insert(state.assets, function()
        Gamestate.load('blackjackgame', require 'blackjackgame')
    end)

    table.insert(state.assets, function()
        local font = love.graphics.newImage("imagefont.png")
        font:setFilter('nearest', 'nearest')

        love.graphics.setFont(love.graphics.newImageFont(font,
        " abcdefghijklmnopqrstuvwxyz" ..
        "ABCDEFGHIJKLMNOPQRSTUVWXYZ0" ..
        "123456789.,!?-+/:;%&`'*#=\"$"), 35)
    end)

    state.step = 240 / # self.assets

    state.messages = {
        "terminal://",
        "operations://load program:(true)",
        "program: journey_to_the_center_of_hawkthorne",
        "loading simulation...",
        "5465415151",
        "5413572495",
        "7342195434",
        "8432159965",
        "3141592653",
        "5897932384",
        "1678942348",
        "1123581321",
        "9437832123",
        "1359756423"
    }

    state.orig_font = love.graphics.getFont()
    love.graphics.setFont( love.graphics.newFont("courier.ttf", 20 ) )
end

function state:update(dt)
    if self.finished then
        love.graphics.setFont( self.orig_font )
        return
    end

    local asset = state.assets[self.current]

    if asset ~= nil then
        asset()
        self.current = self.current + 1
    else
        self.finished = true
        self:switch()
    end
end

function state:switch()
    Gamestate.switch(nextState)
end

function state:target(state)
    nextState = state
end

function state:draw()

    progress = (self.current-1) / #self.assets
    lineCount = math.floor(#self.messages * progress)

    love.graphics.setColor(88, 246, 0)
    for i = 1,lineCount do
        if i <= 4 then
            love.graphics.print(self.messages[i], 50, 15*(i+1), 0, 0.6, 0.5)
        else
            for j = 1,math.min(lineCount-i+1, 5) do
                love.graphics.print(self.messages[i], 60*j, 15*(i+1), 0, 0.4, 0.4)
            end
        end
    end
    love.graphics.setColor(255, 255, 255)
end

return state


local NetScene = class("NetScene", function (  )
    return cc.Scene:create()
end)

local NetSocket = require("app.manager.NetManager")

function NetScene:create(  )
    local scene = NetScene.new()
    local layer = scene:createLayer2()
    scene:addChild(layer)
    return scene

end

function NetScene:ctor(  )
    
end


function NetScene:createLayer(  )
    
    local layer = cc.Layer:create()

    local ws = cc.WebSocket:create("ws://127.0.0.1:3000")
    
    local function wsSendTextOpen(strData)
        dump(strData, "webSocket start")
    end

    local function wsSendTextMessge( strData )
        dump(strData, "webSocket response text msg:")
    end

    local function wsSendTextClose( strData )
        dump(strData, "webSocket close")
    end

    local function wsSendTextError( strData )
        dump(strData, "webSocket Error")
    end

    ws:registerScriptHandler(wsSendTextOpen, cc.WEBSOCKET_OPEN)
    ws:registerScriptHandler(wsSendTextMessge, cc.WEBSOCKET_MESSAGE)
    ws:registerScriptHandler(wsSendTextError, cc.WEBSOCKET_ERROR)
    ws:registerScriptHandler(wsSendTextClose, cc.WEBSOCKET_CLOSE)

    return layer

end


function NetScene:createLayer1(  )
    local layer = cc.Layer:create()

    -- local bgSprite = cc.LayerColor:create(cc.c3b(255,255,255))
    -- layer:addChild(bgSprite)
     local bgSprite = cc.Sprite:create("Rectangle-white.png")
     bgSprite:setPosition(cc.p(display.cx,display.cy))
     bgSprite:setScale(10.0)
     layer:addChild(bgSprite)



    local label1 = cc.Label:createWithSystemFont("", "", 36)
            :align(display.LEFT_CENTER, 200, 400)
            :addTo(layer, 0, 101)

    local label2 = cc.Label:createWithSystemFont("", "", 36)
            :align(display.LEFT_CENTER, 200, 320)
            :addTo(layer, 0, 102)

    local label3 = cc.Label:createWithSystemFont("", "", 36)
            :align(display.LEFT_CENTER, 200, 240)
            :addTo(layer, 0, 103)

    local label4 = cc.Label:createWithSystemFont("", "", 36)
            :align(display.LEFT_CENTER, 200, 160)
            :addTo(layer, 0, 104)

    local label5 = cc.Label:createWithSystemFont("", "", 36)
            :align(display.LEFT_CENTER, 200, 80)
            :addTo(layer, 0, 105)


    local ws = cc.WebSocket:create("ws://localhost:8181")

    local isClose = false

    local stocks = {
        AAPL = 0,
        MSFT = 0,
        AMZN = 0,
        GOOG = 0,
        YHOO = 0
    }

    local function wsSendTextOpen( strData )
        dump(strData, "webSocket open")
        local temp = {
            stocks = {
                "AAPL",
                "MSFT",
                "AMZN",
                "GOOG",
                "YHOO"           
            }
        }
        ws:sendString(json.encode(temp))
    end

    local function wsSendTextMessage( strData )
        dump(json.decode(strData), "webSocket response")
        local tempJson = json.decode(strData)
        local i = 1
        for i,v in ipairs(tempJson) do
            if type(i) == "string" then
                local label = layer:getChildByTag(100 + i)
                label:setString(i.." "..tostring(v))
            end
        end
    end

    local function wsSendTextError( strData )
        dump(strData, "webSocket error")
    end

    local function wsSendTextClose( strData )
        dump(strData, "webSocket close")
    end

    ws:registerScriptHandler(wsSendTextOpen, cc.WEBSOCKET_OPEN)
    ws:registerScriptHandler(wsSendTextMessage, cc.WEBSOCKET_MESSAGE)
    ws:registerScriptHandler(wsSendTextError, cc.WEBSOCKET_ERROR)
    ws:registerScriptHandler(wsSendTextClose, cc.WEBSOCKET_CLOSE)



    return layer
end

function NetScene:createLayer2(  )
    local layer = cc.Layer:create()

    local bgSprite = cc.LayerColor:create(cc.c3b(255,255,255))
    layer:addChild(bgSprite)

    local label1 = cc.Label:createWithSystemFont("test", "arial", 36)
            :align(display.LEFT_CENTER, 200, 400)
            :addTo(layer, 0, 101)
            :setTextColor(cc.c3b(0,0,0))

    local label2 = cc.Label:createWithSystemFont("", "arial", 36)
            :align(display.LEFT_CENTER, 200, 320)
            :addTo(layer, 0, 102)
            :setTextColor(cc.c3b(0,0,0))

    local label3 = cc.Label:createWithSystemFont("", "arial", 36)
            :align(display.LEFT_CENTER, 200, 240)
            :addTo(layer, 0, 103)
            :setTextColor(cc.c3b(0,0,0))

    local label4 = cc.Label:createWithSystemFont("", "arial", 36)
            :align(display.LEFT_CENTER, 200, 160)
            :addTo(layer, 0, 104)
            :setTextColor(cc.c3b(0,0,0))

    local label5 = cc.Label:createWithSystemFont("", "arial", 36)
            :align(display.LEFT_CENTER, 200, 80)
            :addTo(layer, 0, 105)
            :setTextColor(cc.c3b(0,0,0))



    local ws = NetSocket:new()

    ws.openHandle = function ( strData )
        dump(strData, "webSocket open")
        local temp = {
            stocks = {
                "AAPL",
                "MSFT",
                "AMZN",
                "GOOG",
                "YHOO"           
            }
        }
        ws:sendString(json.encode(temp))
    end

    ws.messageHandle = function ( strData )
        dump(json.decode(strData), "webSocket response")
        local tempJson = json.decode(strData)
        local i = 1
        local m = type(tempJson)
        for k,v in pairs(tempJson) do
            if type(k) == "string" then
                local label = layer:getChildByTag(100 + i)
                label:setString(k.." "..tostring(v))
                i = i+1
            end
        end
    end

    

    ws:start("ws://localhost:8181")
    



    return layer

end

return NetScene

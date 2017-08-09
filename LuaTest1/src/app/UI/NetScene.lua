
local NetScene = class("NetScene", function (  )
    return cc.Scene:create()
end)

function NetScene:create(  )
    local scene = NetScene.new()
    local layer = scene:createLayer1()
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



return NetScene

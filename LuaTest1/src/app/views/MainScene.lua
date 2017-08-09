
local MainScene = class("MainScene", cc.load("mvc").ViewBase)

function MainScene:onCreate()
    -- add background image
    display.newSprite("HelloWorld.png")
        :move(display.center)
        :addTo(self)

    local size = cc.size(600,700)

    -- add HelloWorld label
    local titleLabel = cc.Label:createWithSystemFont("查咕哝阿尔高我奥尔盖尔噶而过阿哥怕个IE我阿尔高片儿嘎嘎噶恶搞配股我阿尔噶尔个", "Arial", 40)
        :move(display.cx, display.cy + 200)
        :addTo(self)

    local contentSize = titleLabel:getContentSize()
    local lineNum = math.ceil( contentSize.width / (size.width - 40) )
    -- titleLabel:setContentSize(cc.size(lineNum > 1 and (size.width - 40) or contentSize.width,44 * lineNum))
    titleLabel:setWidth(lineNum > 1 and (size.width - 40) or contentSize.width)
    titleLabel:setHeight(44 * lineNum)

    --[UITEst]
    -- local layer = require("app.UI.NodeTest").new()

    -- --[[球体坐标系测试]]
    -- -- layer:CameraCenterTest()

    -- --[[node的action]]
    -- layer:Test4()
    -- self:addChild(layer)

    local scene = require("app.UI.NetScene"):create()
    


    local tempStr = "fanlesxmj://appurl?json="
    print(string.sub( tempStr, 1, -6))

end

return MainScene

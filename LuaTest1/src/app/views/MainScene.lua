
local MainScene = class("MainScene", cc.load("mvc").ViewBase)

function MainScene:onCreate()
    -- add background image
    local image = display.newSprite("HelloWorld.png")
        :move(display.center)
        :addTo(self)

    --抖动动画
    local rotate1 = cc.RotateTo:create(0.2, -50)
    local bcRotate1 = cc.RotateTo:create(0.2, 0)
    local rotate2 = cc.RotateTo:create(0.2, -50)
    local bcRotate2 = cc.RotateTo:create(0.2, 50)
    local scaleBy = cc.ScaleBy:create(0.2, 1.2)
    local bcScaleBy = scaleBy:reverse()
    -- rotate2 = rotate1:reverse()

    local seq1 = cc.Sequence:create(scaleBy, rotate1, bcRotate2, rotate1:clone(), bcRotate1, bcScaleBy)
    image:runAction(cc.RepeatForever:create(seq1))

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

    -- local scene = require("app.UI.NetScene"):create()
    -- -- app:enterScene("UI.NetScene")
    -- scene = cc.Scene:create()
    -- cc.Director:getInstance():replaceScene(scene)


    local button1 = ccui.Button:create("Images/dot.png")
    button1:setPosition(cc.p(200,300))
    self:addChild(button1)
    button1:addClickEventListener(function (  )
        -- local scene = require("app.UI.NetScene"):create()
        -- local scene = require("app.UI.LabelScene"):create()
        local scene = require("app.UI.GameScene"):create()
        -- app:enterScene("UI.NetScene")
        -- scene = cc.Scene:create()
        cc.Director:getInstance():replaceScene(scene)
    end)

    --[[直接调用并不会切换场景，猜测可能在执行完该方法后，后面调用了一次director的runScene,所以
    最后还是当前场景；
    local scene = require("app.UI.LabelScene"):create()
    cc.Director:getInstance():replaceScene(scene)
    ]]

    local tempStr = "fanlesxmj://appurl?json="
    print(string.sub( tempStr, 1, -6))

end

return MainScene

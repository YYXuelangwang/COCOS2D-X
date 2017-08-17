
local LabelScene = class("LabelScene", function (  )
    return cc.Scene:create()
end)

function LabelScene:create(  )
    local scene = LabelScene.new()
    scene:addChild(scene:createLayer())
    return scene
end

function LabelScene:createLayer(  )
    local layer = cc.Layer:create()

    local bgSprite = cc.LayerColor:create(cc.c3b(0,0,0))
    layer:addChild(bgSprite)

    local size = display.size

    --上下两个控件的距离
    local  gap = 120
    local label1 = cc.Label:createWithSystemFont("世界真的很美好", "arial", 36)
    label1:setPosition(cc.p(size.width/2, size.height - gap))
    layer:addChild(label1, 1)


    local label2 = cc.Label:createWithTTF("meihaodesheji","fonts/Marker Felt.ttf", 36)
    label2:setPosition(cc.p(size.width/2, size.height - 2*gap))
    layer:addChild(label2,2)

    --[[
        声明一个ttfConfig变量，ttfConfig的属性如下：
        fontFilePath    --字体文件路径
        fontSize,       --字体大小
        glyphs = GLYPHCOLLECTION_DYNAMIC,   --字体库类型
        customGlyphs    --自定义字体库
        outlineSize     --字体描边
        distanceFieldEnabled                --开启距离字段字体开关
    ]]
    local ttifConfig = {}
    ttifConfig.fontFilePath = "fonts/tahoma.ttf"
    ttifConfig.fontSize = 32

    local label3 = cc.Label:createWithTTF(ttifConfig, "Hello World")
    label3:setPosition(cc.p(size.width/2, size.height - 3*gap))
    layer:addChild(label3,3)

    ttifConfig.outlineSize = 4
    local label4 = cc.Label:createWithTTF(ttifConfig, "Hellow orld")
    label4:setPosition(cc.p(size.width/2, size.height - 4 * gap))
    
    --添加阴影
    label4:enableShadow(cc.c4b(255,255,255,128), cc.size(4,-4))

    --设置颜色
    label4:setColor(cc.c3b(255,0,0))
    layer:addChild(label4, 4)

    local label5 = cc.Label:createWithBMFont("fonts/bitmapFontTest3.fnt", "cmd")
    label5:setPosition(cc.p(size.width/2, size.height - 5 *gap))
    layer:addChild(label5, 5)

    --参数1，要显示的文本；参数2，源文件；参数3，宽度；参数4，高度；参数5，起始字符
    local label6 = cc.LabelAtlas:create("234", "fonts/alartNum2.png", 50, 86, string.byte("."))
    label6:setPosition(cc.p(size.width/2 -20, size.height/2))
    layer:addChild(label6, 6)

    return layer
end

return LabelScene



local LabelScene = class("LabelScene", function (  )
    return cc.Scene:create()
end)

function LabelScene:createLayer(  )
    local layer = cc.Layer:create()

    local size = display.size

    --上下两个控件的距离
    local  gap = 120
    local label1 = cc.Label:createWithSystemFont("世界真的很美好", "Arial", 36)
    label1:setPosition(cc.p(size.width/2, size.heght - gap))
    layer:addChild(label1)

    

    return layer
end

return LabelScene


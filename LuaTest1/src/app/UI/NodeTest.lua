

local M  = class("NodeTest", function (  )
    return display.newLayer()
end)

local testF = require("app.Util.TestFunction")
local size = display.size

--[[director的定时器]]
local schedule = cc.Director:getInstance():getScheduler()

function M:ctor(  )
    M.baseLayer = cc.Layer:create()
    testF.initWithLayer(M.baseLayer)
end

function M:CameraCenterTest()

    local layer = M.baseLayer

    local sprite = cc.Sprite:create("Rectangle-white.png")
    layer:addChild(sprite)
    sprite:setPosition(cc.p(size.width/5*1, size.height/5*1))

    -- sprite:setAnchorPoint(cc.p(0,0))

    --[[改变节点的颜色,会改变图片的颜色]]
    sprite:setColor(cc.c3b(255,0,0))
    --[[设置纹理的区域]]
    sprite:setTextureRect(cc.rect(0,0,120,50))

    --[[球坐标系的理解 （参考印象笔记中的球面坐标的理解）]]
    --[[用球坐标环绕着屏幕的中心，：以屏幕的中心为原点的球形坐标系来观察，参考]]
    local orbit = cc.OrbitCamera:create(10, 1, 0, 0, 360, 0, 0)
    sprite:runAction(cc.RepeatForever:create(orbit))

    sprite = cc.Sprite:create("Rectangle-white.png")
    layer:addChild(sprite)
    sprite:setPosition(cc.p(size.width/5*1,size.height/5*3))
    sprite:setColor(cc.c3b(0,255,0))
    sprite:setTextureRect(cc.rect(0,0,200,80))
    -- orbit = cc.OrbitCamera:create(10, )

    self:addChild(layer)

    return layer
end

function M:test1(  )
    local layer = M.baseLayer

    local sp1 = cc.Sprite:create(ImageSource.s_pPathSister1)
    local sp2 = cc.Sprite:create(ImageSource.s_pPathSister2)
    local sp3 = cc.Sprite:create(ImageSource.s_pPathSister1)
    local sp4 = cc.Sprite:create(ImageSource.s_pPathSister2)

    sp1:setPosition(cc.p(100,size.height/2))
    sp2:setPosition(cc.p(300,size.height/2))
    layer:addChild(sp1)
    layer:addChild(sp2)

    sp3:setScale(0.25)
    sp4:setScale(0.25)
    sp1:addChild(sp3)
    sp2:addChild(sp4)

    local a1 = cc.RotateBy:create(2,360)
    local a2 = cc.ScaleBy:create(2,2)

    -- local action1 = cc.RepeatForever:create(cc.Sequence:create(a1,a2,a2:reverse()))
    local action2 = cc.RepeatForever:create(cc.Sequence:create(a1:clone(), a2:clone(), a1:clone():reverse()))

    local a3 = cc.MoveBy:create(1, cc.p(0,10))
    local action1 = cc.RepeatForever:create(cc.Sequence:create(a3, a3:reverse()))

    sp2:setAnchorPoint(cc.p(0,0))

    --[[持有action1，避免释放掉, fail 无效]]
    sp1.action = action1
    sp1:runAction(cc.Sequence:create(a2, cc.CallFunc:create(function ()
        --[[不明白，为什么有的时候，局部变量能有效，有的时候局部变量没有效，为nil]]
        local a3 = cc.MoveBy:create(1, cc.p(0,10))
        local action1 = cc.RepeatForever:create(cc.Sequence:create(a3, a3:reverse()))
        sp1:runAction(action1)
        print("this is a new message")
    end)))
    sp2:runAction(action1:clone())

    self:addChild(layer)

    return layer

end

local Test2_layer = nil
local Test2_delay2Entry = nil
local Test2_delay3Entry = nil

function M:Test2(  )
    Test2_layer = M.baseLayer

    local sp1 = cc.Sprite:create(ImageSource.s_pPathSister1)
    local sp2 = cc.Sprite:create(ImageSource.s_pPathSister2)
    sp1:setPosition(cc.p(160,300))
    sp2:setPosition(cc.p(280,300))

    -- sp1:setAnchorPoint(cc.p(1.0,1.0))

    Test2_layer:addChild(sp1, 0, 2)
    Test2_layer:addChild(sp2, 0, 3)

    local function delay2( dt )
        local node = Test2_layer:getChildByTag(2)
        local action = cc.RotateBy:create(2,360)
        node:runAction(action)
    end

    local function delay3( dt )
        schedule:unscheduleScriptEntry(Test2_delay3Entry)
        Test2_layer:removeChildByTag(3, false)
    end

    local function Test2_onEnterOrExit( event )
        if event == "enter" then
            --[[定时器，执行函数，返回执行的id标识]]
            Test2_delay2Entry = schedule:scheduleScriptFunc(delay2, 2.0, false)
            Test2_delay3Entry = schedule:scheduleScriptFunc(delay3, 2.0, false)
        elseif event == "exit" then
            schedule:unscheduleScriptEntry(Test2_delay2Entry)
            schedule:unscheduleScriptEntry(Test2_delay3Entry)
        end
    end
    
    --[[注册脚本事件，一般主要响应触摸和进出场景事件]]
    Test2_layer:registerScriptHandler(Test2_onEnterOrExit)

    self:addChild(Test2_layer)

    return Test2_layer
end

-------------------------
------ Test 2
-------------------------

local Test3_entry = nil
local Test3_layer = nil

function M:Test3(  )
    
    Test3_layer = M.baseLayer

    local layer = Test3_layer

    local sp1 = cc.Sprite:create(ImageSource.s_pPathSister1)
    local sp2 = cc.Sprite:create(ImageSource.s_pPathSister2)

    sp1:setPosition(cc.p(160,300))
    sp2:setPosition(cc.p(240,300))

    local rot = cc.RotateBy:create(2, 360)
    local rot_back = rot:reverse()
    local forever = cc.RepeatForever:create(cc.Sequence:create(rot, rot_back))

    local rot2 = cc.RotateBy:create(2, 360 )
    local rot2_back = rot2:reverse()
    local forever2 = cc.RepeatForever:create(cc.Sequence:create(rot2, rot2_back))

    forever:setTag(101)
    forever2:setTag(102)

    layer:addChild(sp1, 0, 111)
    layer:addChild(sp2, 0, 112)

    sp1:runAction(forever)
    sp2:runAction(forever2)

    local function Test3_addAndRemove( dt )
        local sp1 = Test3_layer:getChildByTag(111)
        local sp2 = Test3_layer:getChildByTag(112)

        sp1:retain()
        sp2:retain()

        local layer = Test3_layer

        --[[
            removeChild( Node *child, bool cleanup = true)
            @param cleanup : true：移除所有child关联的action和callback；false：不移除
        ]]
        layer:removeChild(sp1, false)
        layer:removeChild(sp2, true)

        layer:addChild(sp1, 0, 111)
        layer:addChild(sp2, 0, 112)

        sp1:release()
        sp2:release()
    end

    local function Test3_onEnterOrExit( event )
        if event == "enter" then
            Test3_entry = schedule:scheduleScriptFunc(Test3_addAndRemove, 5, false)
        elseif event == "exit" then
            schedule:unscheduleScriptEntry(Test3_entry)
        end
    end

    layer:registerScriptHandler(Test3_onEnterOrExit)


    self:addChild(layer)
    return layer

end

----------------------

local Test4_layer = nil
local Test4_entry = nil

function M:Test4(  )
    
    Test4_layer = M.baseLayer

    local layer = Test4_layer

    local sp1 = cc.Sprite:create(ImageSource.s_pPathSister1)
    local sp11 = cc.Sprite:create(ImageSource.s_pPathSister2)

    local sp2 = cc.Sprite:create(ImageSource.s_pPathSister2)
    local sp22 = cc.Sprite:create(ImageSource.s_pPathSister1)

    sp1:setPosition(cc.p(160,300))
    sp2:setPosition(cc.p(300,300))

    sp1:addChild(sp11)
    sp2:addChild(sp22)

    local rot = cc.RotateBy:create(2,360)
    local rot_back = rot:reverse()
    local forever1 = cc.RepeatForever:create(cc.Sequence:create(rot, rot_back))
    local forever11 = forever1:clone()

    local forever2 = forever1:clone()
    local forever22 = forever1:clone()

    layer:addChild(sp1, 0, 111)
    layer:addChild(sp2, 0, 112)

    sp1:runAction(forever1)
    sp11:runAction(forever11)
    sp2:runAction(forever2)
    sp22:runAction(forever22)

    local function Test4_addAndRemove( dt )
        local sp1 = Test4_layer:getChildByTag(111)
        local sp2 = Test4_layer:getChildByTag(112)

        sp1:retain()
        sp2:retain()

        Test4_layer:removeChild(sp1, false)
        Test4_layer:removeChild(sp2, true)

        Test4_layer:addChild(sp1, 0, 111)
        Test4_layer:addChild(sp2, 0, 112)

        sp1:release()
        sp2:release()
    end

    local function Test4_onEnterOrExit( event )
        if event == "enter" then
            Test4_entry = schedule:scheduleScriptFunc(Test4_addAndRemove, 5, false)
        elseif event == "exit" then
            schedule:unscheduleScriptEntry(Test4_entry)
        end
    end

    layer:registerScriptHandler(Test4_onEnterOrExit)

    self:addChild(layer)

    return layer

end

-----------------
---StressTest
-----------------


return M




-- require "cocos2d"
-- require "Cocos2dConstants"

local SettingScene = require("app.UI.SettingScene")

local size  = cc.Director:getInstance():getWinSize()

local GameScene = class("GameScene", function() 
    return cc.Scene:create()
end )

function GameScene.create(  )
    local scene = GameScene.new()
    scene:addChild(scene:createLayer())
    return scene
end

function GameScene:ctor(  )
    cclog("GameScene init")
    local function onNodeEvent(event) 
        if event == "enter" then
            self:onEnter()
        elseif event == "enterTransitionFinish" then
            self:onEnterTransitionFinish()
        elseif event == "exit" then
            self:exit()
        elseif event == "exitTransitionStart" then 
            self:exitTransitionStart()
        elseif event == "cleanup" then
            self:cleanup()
        end
    end
end

function GameScene:onEnter(  )
    cclog("self enter")
end

function GameScene:onEnterTransitionFinish(  )
    cclog("self enterTransitionFinish")
end

function GameScene:exitTransitionStart(  )
    cclog("self exitTransitionStart")
end

function GameScene:exit(  )
    cclog("self exit")
end

function GameScene:cleanup(  )
    cclog("self cleanup")
end

function GameScene:createLayer(  )
    local layer = cc.Layer:create()
    local director = cc.Director:getInstance()

    local bg = cc.Sprite:create("background.png")
    bg:setPosition(cc.p(size.width/2,size.height/2))
    layer:addChild(bg)

    -- 开始精灵
    local startlocalNormal = cc.Sprite:create("start-up.png")
    local startlocalSelected = cc.Sprite:create("start-down.png")
    local startMenuItem = cc.MenuItemSprite:create(startlocalNormal, startlocalSelected)
    startMenuItem:setPosition(director:convertToGL(cc.p(700,170)))  -- 转换为GL坐标
    local function menuItemStartCallback( sender )
        cclog("Touch start")
    end

    startMenuItem:registerScriptTapHandler(menuItemStartCallback)

    -- 设置图片菜案
    local settingMenuItem = cc.MenuItemImage:create("setting-up.png", "setting-down.png")
    settingMenuItem:setPosition(director:convertToGL(cc.p(480,400)))
    local function menuItemSettingCallback( sender )
        cclog("Touch Setting,")
        local settingScene = SettingScene.create()
        director:pushScene(settingScene)
    end
    settingMenuItem:registerScriptTapHandler(menuItemSettingCallback)

    -- 帮助图片菜单
    local helpMenuItem = cc.MenuItemImage:create("help-up.png", "help-down.png")
    helpMenuItem:setPosition(director:convertToGL(cc.p(860,480)))
    local function menuItemHelpCallback(sender )
        cclog("Touch help")
    end
    helpMenuItem:registerScriptTapHandler(menuItemHelpCallback)

    local mn = cc.Menu:create(startMenuItem, settingMenuItem, helpMenuItem)
    mn:setPosition(cc.p(0,0))
    layer:addChild(mn)

    return layer

end

return GameScene

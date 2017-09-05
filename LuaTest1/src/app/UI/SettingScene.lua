
-- require "cocos2d"
-- require "Cocos2dConstants"

local size = cc.Director:getInstance():getWinSize()

local SettingScene = class("SettingScene", function() 
    return cc.Scene:create()
end )

function SettingScene.create(  )
    local scene = SettingScene.new()
    scene:addChild(scene:createLayer())
    return scene
end

function SettingScene:ctor(  )
    
end

function SettingScene:createLayer(  )
    local layer = cc.Layer:create()
    local director = cc.Director:getInstance()

    local bg = cc.Sprite:create("setting-back.png")
    bg:setPosition(cc.p(size.width/2, size.height/2))
    layer:addChild(bg)

    -- 音效
    local soundOnMenuItem = cc.MenuItemImage:create("on.png", "on.png")
    local soundOffMenuItem = cc.MenuItemImage:create('off.png', 'off.png')
    local soundToggleMenuItem = cc.MenuItemToggle:create(soundOnMenuItem, soundOffMenuItem)
    soundToggleMenuItem:setPosition(director:convertToGL(cc.p(818,362)))
    local function menuMusicToggleCallback( sender )
        cclog("Music Toggle.")
    end
    soundToggleMenuItem:registerScriptTapHandler(menuMusicToggleCallback)

    -- OK按钮
    local okMenuItem = cc.MenuItemImage:create('ok-down.png', 'ok-up.png')
    okMenuItem:setPosition(director:convertToGL(cc.p(600,500)))
    local function menuOKCallback( sender )
        cclog("OK Menu tap")
        director:popScene()
    end
    okMenuItem:registerScriptTapHandler(menuOKCallback)

    local mn = cc.Menu:create(soundToggleMenuItem, okMenuItem)
    mn:setPosition(cc.p(0,0))
    return layer
end

return SettingScene


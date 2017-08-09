
local M = {}

function M.initWithLayer( layer )

    local rect = cc.Director:getInstance():getOpenGLView():getVisibleRect()
    
    M.currentLayer = layer
    M.titleLabel = cc.Label:createWithSystemFont("cc", FontSource.s_arialPath, 28)
    M.titleLabel:setAnchorPoint(cc.p(0.5,0.5))
    layer:addChild(M.titleLabel, 1)
    M.titleLabel:setPosition(rect.width/2, rect.height - 50)

    M.subtitleLabel = cc.Label:createWithSystemFont("dd", FontSource.s_thonburiPath, 16)
    M.subtitleLabel:setAnchorPoint(cc.p(0.5,0.5))
    layer:addChild(M.subtitleLabel, 1)
    M.subtitleLabel:setPosition(rect.width / 2, rect.height - 80)

    local item1 = cc.MenuItemImage:create(ImageSource.s_pPathB1, s_pPathB2)
    local item2 = cc.MenuItemImage:create(ImageSource.s_pPathR1, s_pPathR2)
    local item3 = cc.MenuItemImage:create(ImageSource.s_pPathF1, s_pPathF2)
    -- item1:registerScriptTapHandler(M.backAction)

    local menu = cc.Menu:create()
    menu:addChild(item1)
    menu:addChild(item2)
    menu:addChild(item3)
    menu:setPosition(cc.p(0,0))
    item1:setPosition(cc.p(rect.width/2 - item2:getContentSize().width * 2, rect.y + item2:getContentSize().height/2))
    item2:setPosition(cc.p(rect.width/2,rect.y + item2:getContentSize().height/2))
    item3:setPosition(cc.p(rect.width/2 + item2:getContentSize().width * 2, rect.y + item2:getContentSize().height/2))
    layer:addChild(menu, 1)

    local background = cc.Layer:create()
    layer:addChild(background, -10)

end

return M

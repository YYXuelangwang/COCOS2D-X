

local breakInfoFun,xpcallFun = require("src.LuaDebug")("localhost", 7003)
cc.Director:getInstance():getScheduler():scheduleScriptFunc(breakInfoFun, 0.3, false)

cc.FileUtils:getInstance():setPopupNotify(false)
cc.FileUtils:getInstance():addSearchPath("src/")
cc.FileUtils:getInstance():addSearchPath("res/")

require "config"
require "cocos.init"
require "app.config.init"

--设计分辨率大小
local designResolutionSize = cc.size(320,568)

--三种资源大小
local smallResolutionSize = cc.size(640,1136)
local largeResolutionSize = cc.size(750,1334)

-- cclog
cclog = function ( ... )
    print(string.format(...))
end

local function main()

    collectgarbage("collect")

    --avoid memory leak
    collectgarbage("setpause",100)
    collectgarbage("setstepmul",5000)

    local director = cc.Director:getInstance()
    local glview = director:getOpenGLView()

    local sharedFileUtils = cc.FileUtils:getInstance()
    sharedFileUtils:addSearchPath("src")
    sharedFileUtils:addSearchPath("res")

    local searchPaths = sharedFileUtils:getSearchPaths()
    local resPrefix = "res/"

    -- 屏幕大小
    local frameSize = glview:getFrameSize()

    cc.exports.app = require("app.MyApp"):create()
    -- require("app.MyApp"):create():run()
    app:run()
end

local status, msg = xpcall(main, __G__TRACKBACK__)
if not status then
    print(msg)
end

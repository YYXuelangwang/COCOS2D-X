

local breakInfoFun,xpcallFun = require("src.LuaDebug")("localhost", 7003)
cc.Director:getInstance():getScheduler():scheduleScriptFunc(breakInfoFun, 0.3, false)

cc.FileUtils:getInstance():setPopupNotify(false)
cc.FileUtils:getInstance():addSearchPath("src/")
cc.FileUtils:getInstance():addSearchPath("res/")

require "config"
require "cocos.init"
require "app.config.init"

local function main()
    cc.exports.app = require("app.MyApp"):create()
    -- require("app.MyApp"):create():run()
    cc.exports.cclog = function(...) 
        print(string.format( ... ))
    end 
    app:run()
end

local status, msg = xpcall(main, __G__TRACKBACK__)
if not status then
    print(msg)
end

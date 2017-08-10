
local NetManager = class("NetManager")


function NetManager:ctor(  )
    self:init()
end

function NetManager:init()  
    self.openHandle = function () end
    self.messageHandle = function()  end
    self.errorHandle = function()  end
    self.closeHandle = function()  end 

end

function NetManager:start( url )

    -- if self.ws:getReadyState() == cc.WEBSOCKET_STATE_CONNECTING then
    --     -- body
    -- end

    if self.ws  then
        self.ws:close()
        self.ws = nil
    end

    self.ws = cc.WebSocket:create(url)
    self.ws:registerScriptHandler(self.openHandle, cc.WEBSOCKET_OPEN)
    self.ws:registerScriptHandler(self.messageHandle, cc.WEBSOCKET_MESSAGE)
    self.ws:registerScriptHandler(self.errorHandle, cc.WEBSOCKET_ERROR)
    self.ws:registerScriptHandler(self.closeHandle, cc.WEBSOCKET_CLOSE)
end

function NetManager:setHandlers( handlers )
    if type(handlers) ~= "table" then
        return
    end
    for i,v in ipairs(handlers) do
        if type(v) == "function" then
        
            if i == "openHandle" then
                self.openHandle = v
            elseif i == "messageHandle" then
                self.messageHandle = v
            elseif i == "errorHandle" then
                self.errorHandle = v
            elseif i == "closeHandle" then 
                self.closeHandle = v
            end
        end
    end
end

function NetManager:sendString( strData )
    self.ws:sendString(strData)
end


return NetManager


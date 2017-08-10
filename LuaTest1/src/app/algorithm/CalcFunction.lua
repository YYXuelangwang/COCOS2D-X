

--将卡牌转换为点数
local function card2Point( card )
    if card == DDZ_CJ then
        return DDZ.Point.PC
    elseif  card == DDZ_BJ then
        return DDZ.Point.PB
    else
        return math.floor( card/4) + 3
    end
end

local function fasetSelectedCard( cards )
    local n = #cards
    local pmin = card2Point(cards[n])
    local pmax, c, cs = pmin, 0, 0
    for m=n-1,1 -1 do
        if m == pmax then
            c = c+1
        elseif m > pmax then
            pmax = m
            if c > 0 then
                cs[#cs + 1] = c
                c = 0
            end
        end
    end
end

return {
    card2Point = card2Point
}













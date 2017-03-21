--
-- BetterGroundScales
--
-- @author  TyKonKet
-- @date 17/03/2017
BetterGroundScales = {};
BetterGroundScales.name = "BetterGroundScales";
BetterGroundScales.debug = false;
BetterGroundScales.nc = 0;
BetterGroundScales.pc = 0;

function BetterGroundScales:print(txt1, txt2, txt3, txt4, txt5, txt6, txt7, txt8, txt9)
    if self.debug then
        local args = {txt1, txt2, txt3, txt4, txt5, txt6, txt7, txt8, txt9};
        for i, v in ipairs(args) do
            if v then
                print("[" .. self.name .. "] -> " .. tostring(v));
            end
        end
    end
end

function BetterGroundScales.overwrittenFunction(oldFunc, newFunc)
    return function(...)
        return newFunc(oldFunc, ...);
    end
end

function BetterGroundScales:loadMap(name)
    self:print(("loadMap(name:%s)"):format(name));
    if self.debug then
        TipUtil.tipToGroundAroundLine = BetterGroundScales.overwrittenFunction(TipUtil.tipToGroundAroundLine, self.tipToGroundAroundLine);
        addConsoleCommand("AAASetVolumesScales", "", "setScalesConsole", self);
    end
    self:setScales(2);
end

function BetterGroundScales:deleteMap()
    self:print("deleteMap()");
end

function BetterGroundScales:keyEvent(unicode, sym, modifier, isDown)
end

function BetterGroundScales:mouseEvent(posX, posY, isDown, isUp, button)
end

function BetterGroundScales:update(dt)
end

function BetterGroundScales:draw()
end

function BetterGroundScales:setScales(v)
    TipUtil.fillTypeToHeightType[FillUtil.FILLTYPE_STRAW].fillToGroundScale = v;
    TipUtil.fillTypeToHeightType[FillUtil.FILLTYPE_GRASS_WINDROW].fillToGroundScale = v;
    TipUtil.fillTypeToHeightType[FillUtil.FILLTYPE_DRYGRASS_WINDROW].fillToGroundScale = v + 0.5;
end

function BetterGroundScales:setScalesConsole(v)
    self:setScales(tonumber(v));
    return "AAASetVolumesScales = " .. v;
end

function BetterGroundScales.tipToGroundAroundLine(superFunc, vehicle, delta, fillType, sx, sy, sz, ex, ey, ez, innerRadius, radius, lineOffset, limitToLineHeight, occlusionAreas, useOcclusionAreas)
    local dropped, lineOffset = superFunc(vehicle, delta, fillType, sx, sy, sz, ex, ey, ez, innerRadius, radius, lineOffset, limitToLineHeight, occlusionAreas, useOcclusionAreas);
    if dropped ~= 0 then
        if dropped < 0 then
            BetterGroundScales.nc = BetterGroundScales.nc + math.abs(dropped);
        else
            BetterGroundScales.pc = BetterGroundScales.pc + math.abs(dropped);
        end
        BetterGroundScales:print(string.format("delta:%s, fillToGroundScale:%s, dropped:%s(%s), pc:%s, nc:%s", delta, TipUtil.fillTypeToHeightType[fillType].fillToGroundScale, dropped, dropped * TipUtil.fillTypeToHeightType[fillType].fillToGroundScale, BetterGroundScales.pc, BetterGroundScales.nc));
    
    end
    return dropped, lineOffset;
end

addModEventListener(BetterGroundScales)

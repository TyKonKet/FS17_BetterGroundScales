--
-- BetterGroundScales
--
-- @author  TyKonKet
-- @date 17/03/2017
BetterGroundScales = {};
BetterGroundScales.name = "BetterGroundScales";
BetterGroundScales.debug = false;

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

function BetterGroundScales:loadMap(name)
    self:print(("loadMap(name:%s)"):format(name));
    TipUtil.fillTypeToHeightType[FillUtil.FILLTYPE_STRAW].fillToGroundScale = 3;
    TipUtil.fillTypeToHeightType[FillUtil.FILLTYPE_GRASS_WINDROW].fillToGroundScale = 3;
    TipUtil.fillTypeToHeightType[FillUtil.FILLTYPE_DRYGRASS_WINDROW].fillToGroundScale = 3;
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

addModEventListener(BetterGroundScales)

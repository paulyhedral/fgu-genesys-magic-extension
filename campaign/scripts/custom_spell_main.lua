function onInit() update(); end

function onDrop(x, y, draginfo)
    local bReadOnly = WindowManager.getReadOnlyState(getDatabaseNode());
    if bReadOnly then return; end
    Debug.console(draginfo)
    if draginfo.isType("shortcut") then
        local sClass, sRecord = draginfo.getShortcutData();
        if StringManager.contains({"srpg_spell_type"}, sClass) then
            MagicManager.addInfoDB(getDatabaseNode(), sClass, sRecord);
            return true;
        end
    end
end

function onClose()
    -- 	ShopManager.emptyCart(getDatabaseNode());
end

function onLockChanged() update(); end

function updateControl(sControl, bReadOnly, bID)
    if not self[sControl] then return false; end

    if not bID then return self[sControl].update(bReadOnly, true); end

    return self[sControl].update(bReadOnly);
end

function update()
    local nodeRecord = getDatabaseNode();
    local bReadOnly = WindowManager.getReadOnlyState(nodeRecord);
    local bID = true;

    updateControl("spell_type", bReadOnly, bID);
    updateControl("qualities", bReadOnly, bID);
    updateControl("skills", bReadOnly, bID);
    updateControl("difficulty", bReadOnly, bID);
    updateControl("effects", bReadOnly, bID);
    updateControl("description", bReadOnly, bID);
end

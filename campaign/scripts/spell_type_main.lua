function onInit() update(); end

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

    updateControl("skills", bReadOnly, bID);
    updateControl("difficulty", bReadOnly, bID);
    updateControl("target", bReadOnly, bID);
    updateControl("damage", bReadOnly, bID);
    updateControl("critical", bReadOnly, bID);
    updateControl("concentration", bReadOnly, bID);
    updateControl("stacks", bReadOnly, bID);
    updateControl("effect", bReadOnly, bID);
    updateControl("description", bReadOnly, bID);
    updateControl("effectslist", bReadOnly, bID);
end

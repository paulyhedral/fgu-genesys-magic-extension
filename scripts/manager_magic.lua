local _aCustomSpellRecord = {
    aDataMap = {"srpg_custom_spell", "reference.srpg_custom_spell"},
    sRecordDisplayClass = "srpg_custom_spell",
    aDisplayIcon = {"button_custom_spells_up", "button_custom_spells_down"},
    bExport = 1,
    aCustomFilters = {
        ["Spell Type"] = {
            sField = "spell_type"
            -- fGetValue = getSpell_typeTypeValue
        }
    }
};
local _aSpellTypeRecord = {
    aDataMap = {"srpg_spell_type", "reference.srpg_spell_type"},
    sRecordDisplayClass = "srpg_spell_type",
    aDisplayIcon = {"button_spell_types_up", "button_spell_types_down"},
    bExport = 1
};

function onInit()
    LibraryData.setRecordTypeInfo("srpg_custom_spell", _aCustomSpellRecord);
    LibraryData.setRecordTypeInfo("srpg_spell_type", _aSpellTypeRecord);
end

-- function copyToDB(nNode)
--     local tempNode = DB.createChild("srpg_custom_spell");
--     if tempNode then DB.copyNode(nNode, tempNode); end
-- end

function resolveRefNode(sRecord)
    local nodeSource = DB.findNode(sRecord);
    if not nodeSource then
        local sRecordSansModule = StringManager.split(sRecord, "@")[1];
        nodeSource = DB.findNode(sRecordSansModule .. "@*");
        if not nodeSource then
            ChatManager.SystemMessage(Interface.getString(
                                          "char_error_missingrecord"));
        end
    end
    return nodeSource;
end

function addInfoDB(node, class, record, nodeTargetList)
    if not node then return false; end

    if class == "srpg_spell_type" then
        addCustomSpellType(node, class, record);
        -- elseif sClass == "referencecareer" then
        -- 	addCareer(nodeChar, sClass, sRecord);
        --	elseif sClass == "referenceracialtrait" then
        --		addRacialTrait(nodeChar, sClass, sRecord, nodeTargetList);
        --	elseif sClass == "referenceclassability" then
        --		addClassFeature(nodeChar, sClass, sRecord, nodeTargetList);
        --	elseif sClass == "referencefeat" then
        --		addFeat(nodeChar, sClass, sRecord, nodeTargetList);
    else
        return false;
    end

    return true;
end

function addCustomSpellType(node, class, record)
    local nodeSource = resolveRefNode(record);
    if not nodeSource then return; end

    local spell_type = DB.getValue(nodeSource, "name", "");

    local sFormat = Interface.getString("custom_spell_message_spell_type_add");
    local sMsg = string.format(sFormat, spell_type,
                               DB.getValue(node, "name", ""));
    ChatManager.SystemMessage(sMsg);

    DB.setValue(node, "spell_type", "string", spell_type);
    DB.setValue(node, "spell_type_link", "windowreference", class,
                node.getNodeName());
end

function onSpellTypeEffectRemoveEvent(node)
    -- TODO?
end

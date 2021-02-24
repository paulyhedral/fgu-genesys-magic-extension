--
-- Please see the license.html file included with this distribution for
-- attribution and copyright information.
--
function onInit()
    registerMenuItem(Interface.getString("list_menu_createitem"), "insert", 5);
end

function onMenuSelection(selection) if selection == 5 then addEntry(true); end end

function onListChanged()
    update();
    -- updateContainers();
end

function update(bEditMode)
    -- local bEditMode = (window.parentcontrol.window.spell_type_effects_iedit
    --                       .getValue() == 1);
    for _, w in ipairs(getWindows()) do
        w.idelete.setVisibility(bEditMode);
        w.update(bEditMode);
    end
end

function addEntry(bFocus)
    local w = createWindow();
    if w then if bFocus then w.name.setFocus(); end end
    return w;
end

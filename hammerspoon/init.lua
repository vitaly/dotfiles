hs.window.animationDuration = 0


function resizer(f)
    return function()
        local w = hs.window.focusedWindow()
        local frame = w:frame()
        f(frame, w:screen():frame())
        w:setFrame(frame)
    end
end

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Left", resizer(function(f, max)
    f.x = max.x
    f.y = max.y

    f.w = max.w / 2
    f.h = max.h
end))


-- right half
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Right", resizer(function(f, max)
    f.x = max.w / 2
    f.y = max.y

    f.w = max.w / 2
    f.h = max.h
end))

-- top half
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Up", resizer(function(f, max)
    f.x = max.x
    f.y = max.y

    f.w = max.w
    f.h = max.h / 2
end))

-- top half
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Down", resizer(function(f, max)
    f.x = max.x
    f.y = max.h / 2

    f.w = max.w
    f.h = max.h / 2
end))

-- full screen
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "M", resizer(function(f, max)
    f.x = max.x
    f.y = max.y

    f.w = max.w
    f.h = max.h
end))

-- top left
hs.hotkey.bind({"cmd", "alt", "ctrl"}, ";", resizer(function(f, max)
    f.x = max.x
    f.y = max.y

    f.w = max.w / 2
    f.h = max.h / 2
end))

-- top right
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "'", resizer(function(f, max)
    f.x = max.w / 2
    f.y = max.y

    f.w = max.w / 2
    f.h = max.h / 2
end))

-- bottom left
hs.hotkey.bind({"cmd", "alt", "ctrl"}, ".", resizer(function(f, max)
    f.x = max.x
    f.y = max.h / 2

    f.w = max.w / 2
    f.h = max.h / 2
end))

-- bottom right
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "/", resizer(function(f, max)
    f.x = max.w / 2
    f.y = max.h / 2

    f.w = max.w / 2
    f.h = max.h / 2
end))

local mouseCircle = nil
local mouseCircleTimer = nil

function mouseHighlight()
    -- Delete an existing highlight if it exists
    if mouseCircle then
        mouseCircle:delete()
        if mouseCircleTimer then
            mouseCircleTimer:stop()
        end
    end
    -- Get the current co-ordinates of the mouse pointer
    mousepoint = hs.mouse.get()
    -- Prepare a big red circle around the mouse pointer
    mouseCircle = hs.drawing.circle(hs.geometry.rect(mousepoint.x-40, mousepoint.y-40, 80, 80))
    mouseCircle:setStrokeColor({["red"]=1,["blue"]=0,["green"]=0,["alpha"]=1})
    mouseCircle:setFill(false)
    mouseCircle:setStrokeWidth(5)
    mouseCircle:show()

    -- Set a timer to delete the circle after 3 seconds
    mouseCircleTimer = hs.timer.doAfter(3, function() mouseCircle:delete() end)
end
hs.hotkey.bind({"shift","ctrl","alt"}, "m", mouseHighlight)

function reloadConfig(files)
    doReload = false
    for _,file in pairs(files) do
        if file:sub(-4) == ".lua" then
            doReload = true
        end
    end
    if doReload then
        hs.reload()
    end
end
hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()

hs.alert.show("Config loaded")
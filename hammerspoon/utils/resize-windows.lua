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



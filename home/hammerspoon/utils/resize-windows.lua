function resizer(f)
    return function()
        local w = hs.window.focusedWindow()
        if w then
            local frame = w:frame()
            f(frame, w:screen():frame())
            w:setFrame(frame)
        end
    end
end

function resize_width(max)
    if (max.w > 3400) then
        return 0.3
    else
        return 0.5
    end
end

function resize_height(max)
    return 0.5
end

function resize_box(f, max, x, y, w, h)
    f.x = max.x + x * max.w
    f.y = max.y + y * max.h
    f.w = w * max.w
    f.h = h * max.h
    hs.alert.show(max)
end

resize_left = resizer(function(f, max)
    w = resize_width(max)
    resize_box(f, max, 0, 0, w, 1)
end)

resize_right = resizer(function(f, max)
    w = resize_width(max)
    resize_box(f, max, 1 - w, 0, w, 1)
end)

resize_up = resizer(function(f, max)
    h = resize_height(max)
    resize_box(f, max, 0, 0, 1, h)
end)

resize_down = resizer(function(f, max)
    h = resize_height(max)
    resize_box(f, max, 0, 1 - h, 1, h)
end)

resize_up_left = resizer(function(f, max)
    w = resize_width(max)
    h = resize_height(max)
    resize_box(f, max, 0, 0, w, h)
end)

resize_up_right = resizer(function(f, max)
    w = resize_width(max)
    h = resize_height(max)
    resize_box(f, max, 1 - w, 0, w, h)
end)

resize_down_left = resizer(function(f, max)
    w = resize_width(max)
    h = resize_height(max)
    resize_box(f, max, 0, 1 - h, w, h)
end)

resize_down_right = resizer(function(f, max)
    w = resize_width(max)
    h = resize_height(max)
    resize_box(f, max, 1 - w, 1 - h, w, h)
end)

resize_full_screen = resizer(function(f, max)
    resize_box(f, max, 0, 0, 1, 1)
end)

-- left
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Left", resize_left)

-- right
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Right", resize_right)

-- top
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Up", resize_up)

-- top
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Down", resize_down)

-- top left
hs.hotkey.bind({"cmd", "alt", "ctrl"}, ";", resize_up_left)

-- top right
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "'", resize_up_right)

-- bottom left
hs.hotkey.bind({"cmd", "alt", "ctrl"}, ".", resize_down_left)

-- bottom right
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "/", resize_down_right)

-- full screen
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "M", resize_full_screen)

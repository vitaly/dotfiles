function resizer(f)
    return function()
        local w = hs.window.focusedWindow()
        if w then
            w:setFrame(f(w:frame(), w:screen():frame()))
        end
    end
end

function resize_width(max)
    if (max.w > 3000) then
        return 1/3
    else
        return 1/2
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
    return f
end

resize_left = resizer(function(f, max)
    w = resize_width(max)
    return resize_box(f, max, 0, 0, w, 1)
end)

resize_right = resizer(function(f, max)
    w = resize_width(max)
    return resize_box(f, max, 1 - w, 0, w, 1)
end)

resize_middle = resizer(function(f, max)
    w = resize_width(max)
    return resize_box(f, max, (1 - w)/2, 0, w, 1)
end)

resize_left_2 = resizer(function(f, max)
    w = resize_width(max)
    return resize_box(f, max, 0, 0, 2 * w, 1)
end)

resize_right_2 = resizer(function(f, max)
    w = resize_width(max)
    return resize_box(f, max, 1 - 2 * w, 0, 2 * w, 1)
end)

resize_top = resizer(function(f, max)
    h = resize_height(max)
    return resize_box(f, max, 0, 0, 1, h)
end)

resize_bottom = resizer(function(f, max)
    h = resize_height(max)
    return resize_box(f, max, 0, 1 - h, 1, h)
end)

resize_top_left = resizer(function(f, max)
    w = resize_width(max)
    h = resize_height(max)
    return resize_box(f, max, 0, 0, w, h)
end)

resize_top_middle = resizer(function(f, max)
    w = resize_width(max)
    h = resize_height(max)
    return resize_box(f, max, (1 - w)/2, 0, w, h)
end)

resize_top_right = resizer(function(f, max)
    w = resize_width(max)
    h = resize_height(max)
    return resize_box(f, max, 1 - w, 0, w, h)
end)

resize_bottom_left = resizer(function(f, max)
    w = resize_width(max)
    h = resize_height(max)
    return resize_box(f, max, 0, 1 - h, w, h)
end)

resize_bottom_middle = resizer(function(f, max)
    w = resize_width(max)
    h = resize_height(max)
    return resize_box(f, max, (1 - w)/2, 1 - h, w, h)
end)

resize_bottom_right = resizer(function(f, max)
    w = resize_width(max)
    h = resize_height(max)
    return resize_box(f, max, 1 - w, 1 - h, w, h)
end)


resize_full_screen = resizer(function(f, max)
    return resize_box(f, max, 0, 0, 1, 1)
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Up", resize_top)
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Down", resize_bottom)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "p", resize_top_left)
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "[", resize_top_middle)
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "]", resize_top_right)

hs.hotkey.bind({"cmd", "alt", "shift"}, "l", resize_left_2)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "l", resize_left)
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Left", resize_left)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, ";", resize_middle)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Right", resize_right)
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "'", resize_right)

hs.hotkey.bind({"cmd", "alt", "shift"}, "'", resize_right_2)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, ",", resize_bottom_left)
hs.hotkey.bind({"cmd", "alt", "ctrl"}, ".", resize_bottom_middle)
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "/", resize_bottom_right)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "M", resize_full_screen)

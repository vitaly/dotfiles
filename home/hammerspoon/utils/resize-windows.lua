function resizer(handler)
    return function()
        local w = hs.window.focusedWindow()
        if w then
            local max = w:screen():frame()
            --hs.alert.show(max, 5)

            local f = w:frame()
            --hs.alert.show(f, 5)

            local new_f = handler(f, max)
            --hs.alert.show(new_f, 5)

            w:setFrame(new_f)
        end
    end
end

function show_frame()
  local w = hs.window.focusedWindow()
  if w then
    hs.alert.show(w:frame())
  end
end

function show_screen_frame()
  local w = hs.window.focusedWindow()
  if w then
    hs.alert.show(w:screen():frame())
  end
end

function is_big(max)
    return max.w > 2500
end

function resize_width(max)
    return is_big(max) and 1/3 or 1/2
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
    return resize_box(f, max, 1/3, 0, 1/3, 1)
end)

resize_left_2 = resizer(function(f, max)
    return resize_box(f, max, 0, 0, 2/3, 1)
end)

resize_right_2 = resizer(function(f, max)
    return resize_box(f, max, 1/3, 0, 2/3, 1)
end)

resize_top = resizer(function(f, max)
    return resize_box(f, max, 0, 0, 1, 1/2)
end)

resize_bottom = resizer(function(f, max)
    return resize_box(f, max, 0, 1/2, 1, 1/2)
end)

resize_top_left = resizer(function(f, max)
    w = resize_width(max)
    return resize_box(f, max, 0, 0, w, 1/2)
end)

resize_top_left_2 = resizer(function(f, max)
    return resize_box(f, max, 0, 0, 2/3, 1/2)
end)

resize_top_middle = resizer(function(f, max)
    return resize_box(f, max, 1/3, 0, 1/3, 1/2)
end)

resize_top_right = resizer(function(f, max)
    w = resize_width(max)
    return resize_box(f, max, 1 - w, 0, w, 1/2)
end)

resize_top_right_2 = resizer(function(f, max)
    return resize_box(f, max, 1/3, 0, 2/3, 1/2)
end)

resize_bottom_left = resizer(function(f, max)
    w = resize_width(max)
    return resize_box(f, max, 0, 1/2, w, 1/2)
end)

resize_bottom_left_2 = resizer(function(f, max)
    return resize_box(f, max, 0, 1/2, 2/3, 1/2)
end)

resize_bottom_middle = resizer(function(f, max)
    return resize_box(f, max, 1/3, 1/2, 1/3, 1/2)
end)

resize_bottom_right = resizer(function(f, max)
    w = resize_width(max)
    return resize_box(f, max, 1 - w, 1/2, w, 1/2)
end)

resize_bottom_right_2 = resizer(function(f, max)
    return resize_box(f, max, 1/3, 1/2, 2/3, 1/2)
end)


resize_full_screen = resizer(function(f, max)
    return resize_box(f, max, 0, 0, 1, 1)
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Up", resize_top)
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Down", resize_bottom)

hs.hotkey.bind({"cmd", "alt", "shift"}, "p", resize_top_left_2)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "p", resize_top_left)
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "[", resize_top_middle)
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "]", resize_top_right)

hs.hotkey.bind({"cmd", "alt", "shift"}, "]", resize_top_right_2)

hs.hotkey.bind({"cmd", "alt", "shift"}, "l", resize_left_2)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "l", resize_left)
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Left", resize_left)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, ";", resize_middle)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Right", resize_right)
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "'", resize_right)

hs.hotkey.bind({"cmd", "alt", "shift"}, "'", resize_right_2)

hs.hotkey.bind({"cmd", "alt", "shift"}, ",", resize_bottom_left_2)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, ",", resize_bottom_left)
hs.hotkey.bind({"cmd", "alt", "ctrl"}, ".", resize_bottom_middle)
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "/", resize_bottom_right)

hs.hotkey.bind({"cmd", "alt", "shift"}, "/", resize_bottom_right_2)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "M", resize_full_screen)


hs.hotkey.bind({"cmd", "alt", "ctrl"}, "f", show_frame)
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "s", show_screen_frame)

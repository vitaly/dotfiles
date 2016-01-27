function hideApps()
    local apps = {'Skype', 'Wunderlist', 'Mailplane 3', 'Slack', 'Messages', 'Spotify'}

    for i, name in ipairs(apps) do
        local app = hs.application.get(name)
        if app then
            hs.alert.show(name)
            app:hide()
        end
    end
end
hs.hotkey.bind({"shift","ctrl","alt"}, "h", hideApps)

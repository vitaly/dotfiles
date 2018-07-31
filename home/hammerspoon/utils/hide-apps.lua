hs.application.enableSpotlightForNameSearches(true)
function hideApps()
    local apps = { 'Calendar', 'Contacts', 'Finder', 'Messages', 'Notes', 'Skype', 'Slack', 'Spotify', 'Telegram', 'WhatsApp', 'iTunes' }

    for i, name in ipairs(apps) do
        local app = hs.application.get(name)
        if app then
            hs.alert.show(name)
            app:hide()
        end
    end
end
hs.hotkey.bind({"shift","ctrl","alt"}, "h", hideApps)

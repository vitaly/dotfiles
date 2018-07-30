hs.application.enableSpotlightForNameSearches(true)
function hideApps()
    local apps = {'Skype', 'Wunderlist', 'Mailplane', 'Slack', 'Messages',
    'Spotify', 'Telegram', 'Evernote', 'Sonos', '1Password 6', 'Finder',
    'iTunes', 'Contacts', 'Speed Download', 'Things', 'WhatsApp', 'Tweetbot',
    'Notes', 'Calendar', 'HipChat'}

    for i, name in ipairs(apps) do
        local app = hs.application.get(name)
        if app then
            hs.alert.show(name)
            app:hide()
        end
    end
end
hs.hotkey.bind({"shift","ctrl","alt"}, "h", hideApps)

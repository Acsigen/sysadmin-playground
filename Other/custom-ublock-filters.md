# Custom uBlock filters

```ublock
# Compiled from https://letsblock.it/filters

# Cleanup Google search results
google.*###rso > div:has(div.related-question-pair)
google.*###botstuff
google.*###rso div.g div[jscontroller]
google.*###rso > :not(div.g):not(:has(:scope>div.g))

# Linuxfr.org cleanup
linuxfr.org###phare
linuxfr.org###phare + aside.banner

# Cleanup YouTube
www.youtube.com###related
www.youtube.com##ytd-browse[page-subtype="home"]
www.youtube.com##.ytp-ce-element
www.youtube.com###chat:remove()
www.youtube.com##ytd-browse ytd-grid-video-renderer:has(ytd-thumbnail-overlay-time-status-renderer[overlay-style="UPCOMING"])
www.youtube.com##ytd-browse ytd-rich-item-renderer:has(ytd-thumbnail-overlay-time-status-renderer[overlay-style="UPCOMING"])


# Hide specific sites from various search engines
google.*##.g:has(a[href*=".pinterest."])
google.*##a[href*=".pinterest."]:upward(1)
duckduckgo.com##a.result__a[href*=".pinterest."]:upward(3)
google.*##.g:has(a[href*="snapcraft.io/install"])
google.*##a[href*="snapcraft.io/install"]:upward(1)
duckduckgo.com##a.result__a[href*="snapcraft.io/install"]:upward(3)
```

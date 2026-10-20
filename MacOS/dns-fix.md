# MacOS DNS Issues

MacOS caches DNS entries quite heavily so if you have a host that booted after MacOS, it might not see it via hostname.

To clear the DNS cache run:

```bash
sudo dscacheutil -flushcache
sudo killall -HUP mDNSResponder
```

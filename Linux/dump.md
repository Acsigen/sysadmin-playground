create system image
```bash
dump -y -u -f /backup/system$(date +%d%m%Y%s).lzo /
```

restore from system image

```bash
restore -rf /backup/system$(date +%d%m%Y%s).lzo
```

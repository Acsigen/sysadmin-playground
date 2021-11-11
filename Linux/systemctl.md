# SystemCTL

## Services control

List running services:

```bash
systemctl list-units --type=service --state=running
```

Start service:

```bash
systemctl start service-name
```

Start service at startup:

```bash
systemctl enable service-name
```

Stop service:

```bash
systemctl stop service-name
```

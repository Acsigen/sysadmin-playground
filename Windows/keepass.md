# Keepass Configuration

## Prerequisites

Small adjustments to Keepass for Windows to make your life better.

## PuTTY integration

Go to Tools &rarr; Options &rarr; Integration &rarr; URL Overrides

Add a new one:

* Scheme: `ssh`
* URL Override: `cmd://"c:/Program Files/PuTTY/putty.exe" -ssh {USERNAME}@{BASE:RMVSCM} {KEEAGENT:KEYFILEPATH}`

Then go to Tools &rarr; KeeAgent and add your keys.

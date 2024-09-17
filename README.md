# startup-temp-rule

Temporary add first allow firewall filter input rule.

Put the script into /system/script and run by cron when reboot.
Policy: read, write.

# blacklist-update

Update the blacklist in /ip/firewall/address-list from spamhaus.

Put the script into /system/script and run by cron (once a day).
Policy: read, write, test.

# dhcp-dns
## dhcp-dns

Create the DNS A-record after dhcp server bound.

Put into /ip/dhcp-server/*/lease-script.

## dhcp-dns-clear

Remove old DNS A-records.

Put the script into /system/script and run by cron (once a day).
Policy: read, write.

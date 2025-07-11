/system script
add dont-require-permissions=no name=blacklist-update owner=adminaz policy=read,write,test source="# Policy: read, write, test\r\
    \n\r\
    \nip firewall address-list\r\
    \n:local update do={\r\
    \n :do {\r\
    \n  :local data ([:tool fetch url=\$url output=user as-value]->\"data\")\r\
    \n  remove [find list=blacklist comment=\$description]\r\
    \n  :while ([:len \$data]!=0) do={\r\
    \n    :delay 0.01s;\r\
    \n   :if ([:pick \$data 0 [:find \$data \"\\n\"]]~\"^[0-9]{1,3}\\\\.[0-9]{1,3}\\\\.[0-9]{1,3}\\\\.[0-9]{1,3}\") do={\r\
    \n    :do {add list=blacklist address=([:pick \$data 0 [:find \$data \$delimiter]].\$cidr) comment=\$description timeout=10d} on-error={}\r\
    \n   }\r\
    \n   :set data [:pick \$data ([:find \$data \"\\n\"]+1) [:len \$data]]\r\
    \n  }\r\
    \n } on-error={:log warning \"Address list <\$description> update failed\"}\r\
    \n}\r\
    \n#\$update url=https://www.dshield.org/block.txt description=DShield delimiter=(\"\\t\") cidr=/24\r\
    \n\$update url=https://www.spamhaus.org/drop/drop.txt description=\"Spamhaus DROP\" delimiter=(\"\\_\")\r\
    \n\$update url=https://www.spamhaus.org/drop/edrop.txt description=\"Spamhaus EDROP\" delimiter=(\"\\_\")\r\
    \n#\$update url=https://sslbl.abuse.ch/blacklist/sslipblacklist.txt description=\"Abuse.ch SSLBL\" delimiter=(\"\\r\")\r\
    \n"
/system scheduler
add interval=1d name=blacklist-update on-event=blacklist-update policy=read,write,test start-time=06:00:00

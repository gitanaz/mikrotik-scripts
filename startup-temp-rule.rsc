/system script
add dont-require-permissions=no name=startup-temp-rule owner=adminaz policy=read,write source="# Policy: read, write\r\
    \n\r\
    \n# time for enable rule in seconds\r\
    \n:local time 15m ;\r\
    \n# description of firewall rule (first normally disabled input allow rule)\r\
    \n:local desc STARTUP-TEMP-RULE ;\r\
    \n\r\
    \n/ip firewall filter ;\r\
    \nadd chain=input place-before=0 comment=\$desc ;\r\
    \n:delay \$time ;\r\
    \nremove [ find comment=\$desc ] ;\r\
    \n\r\
    \n/ip firewall connection;\r\
    \nremove [find where protocol=udp];\r\
    \n"
/system scheduler
add name=startup-temp-rule on-event=startup-temp-rule policy=read,write start-time=startup

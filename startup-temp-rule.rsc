/system script
add dont-require-permissions=no name=startup-temp-rule owner=adminaz policy=read,write source="# Policy: read, write\
    \n\
    \n# time for enable rule in seconds\
    \n:local time 15m ;\
    \n# description of firewall rule (first normally disabled input allow rule)\
    \n:local desc STARTUP-TEMP-RULE ;\
    \n\
    \n/ip firewall filter ;\
    \nadd chain=input place-before=0 comment=\$desc ;\
    \n:delay \$time ;\
    \nremove [ find comment=\$desc ] ;\
    \n\
    \n/ip firewall connection;\
    \nremove [find where protocol=udp];\
    \n"
/system scheduler
add name=startup-temp-rule on-event=startup-temp-rule policy=read,write start-time=startup

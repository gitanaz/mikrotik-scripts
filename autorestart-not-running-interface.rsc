/system script
add dont-require-permissions=no name=autorestart-not-running-interface policy=read source="# policy: read\
    \n# label in interface description\
    \nlocal desc AUTORESART-NOT-RUNNING\
    \n# time for disable interface\
    \nlocal time 900s\
    \n\
    \n/interface\
    \n:if ([find disabled=no running=no comment~\$desc]) do={\
    \n    :log info \"AUTORESTART-INTERFACE disable interfaces:\"\
    \n    set [find disabled=no running=no comment~\$desc] disabled=yes\
    \n}\
    \n:delay \$time\
    \n:if ([find disabled=yes comment~\$desc]) do={\
    \n    :log info \"AUTORESTART-INTERFACE enable interfaces:\"\
    \n    set [find disabled=yes comment~\$desc] disabled=no\
    \n}\
    \n"
/system scheduler
add interval=1h name=autorestart-not-running-interface on-event=autorestart-not-running-interface policy=read start-date=dec/30/2024 start-time=00:00:00

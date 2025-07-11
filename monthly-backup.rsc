/system script
add dont-require-permissions=no name=monthly-backup owner=adminaz policy=read,policy,test source="# Policy: read, policy, test\r\
    \n\r\
    \n:local flash \"flash/\" ; :do { /file get flash } on-error= { :set flash \"\" }\r\
    \n:local month [ /system clock get date ] ; :if ( [ :len \$month ]=10) do={ :set month [ :pick \$month 5 7 ] } else= { :set month [ :pick \$month 0 3 ] }\r\
    \n\r\
    \n/system backup save name=( \$flash . \"month-\" . \$month ) ;\r\
    \n"
/system scheduler
add interval=30d name=monthly-backup on-event=monthly-backup policy=read,policy,test start-date=dec/31/2024 start-time=01:00:00

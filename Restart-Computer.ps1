$server =  Read-Host 'Enter name of the server you want to reboot:'
Restart-Computer -computerName $server
# Written by the Cloud Cowboy
$Server = Read-Host 'Server name you want to monitor'
$Drive = Read-Host 'Drive letter you want to monitor'
Get-Counter -counter "\LogicalDisk(D:)\AVG. Disk Queue Length" -Computer $server -Continuous -SampleInterval 5
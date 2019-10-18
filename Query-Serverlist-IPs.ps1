## Configure a list of server in the path
## This script will ping each entry in comma delimited format
$servers = Get-Content c:\scripts\serverList.txt
$ping = New-Object System.Net.NetworkInformation.Ping
foreach($s in $servers)
{
    $("$s,$($ping.Send($s).Address)")
}
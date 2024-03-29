## Written by the Cloud Cowboy
# Pop up requests for you to enter information
$computers = Read-Host "Enter computer name" 
# For each computer get the Domain, Manufacturer, Model, Name, Primary Owner Name, and Physical Memory.
foreach ($computer in $computers) {
            $continue = $true
            try {
                $os = Get-WmiObject -class Win32_OperatingSystem `
                 -computer $computer -ea Stop
            } catch {
                $computer | out-file $logfile -append
                $continue = $false
            }
            if ($continue) {
                $bios = Get-WmiObject -class Win32_BIOS `
                 -computername $computer
                 $comp = Get-WmiObject -class Win32_ComputerSystem `
                 -computername $computer
                $proc = Get-WmiObject -class Win32_Processor `
                 -computername $computer | Select -first 1
                $hash = @{
                    'OSVersion'=$os.caption;
                    'SPVersion'=$os.servicepackmajorversion;
                    'OSArch'=$os.osarchitecture;
                    'ProcArch'=$proc.addresswidth;
                    'Memory GB'=$os.totalvisiblememorysize/1000000;
                    'Manufacturer'=$comp.manufacturer;
                    'Model'=$comp.model;
                    'ComputerName'=$computer
                }
                $obj = New-Object -TypeName PSObject -Property $hash
                Write-Output $obj
            }
        }
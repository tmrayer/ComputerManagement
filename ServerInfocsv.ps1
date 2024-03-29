## Written by the Cloud Cowboy
# Pop up requests for you to enter information
# Open the text file
$computers = Get-Content C:\Scripts\computers.txt
# For each computer get the Domain, Manufacturer, Model, Name, Primary Owner Name, and Physical Memory.
#This cmdlet picks the servers from workstations.txt one by one, 
#and collects WMI details of each server and pushes them into excel sheet
#Creates Excel com object
$ExcelSheet=new-object -comobject Excel.application
#When you first open excel it creates a workbook
$WorkBook=$ExcelSheet.WorkBooks.add(1)   
#Under book create a worksheet 
$WorkSheet=$WorkBook.WorkSheets.item(1)    
#Create parent fields            
$WorkSheet.cells.item(1,1)=”System Name”                 
$WorkSheet.cells.item(1,2)=”Operating System”                  
$WorkSheet.cells.item(1,3)=”Service Pack”  
$WorkSheet.cells.item(1,4)=”OS Architecture”  
$WorkSheet.cells.item(1,5)=”Processor Count”               
$WorkSheet.cells.item(1,6)=”Processor Architecture”
$WorkSheet.cells.item(1,7)=”Manufacturer”
$WorkSheet.cells.item(1,8)=”Model”
$WorkSheet.cells.item(1,9)=”Memory”
$i=2
#For loop for each computer in computers.txt file
Foreach($computer in $computers) { 
    #The following variables are used to easily pull the data in a shortened format.
    #GWMI playing with shortered format
    $OS = gwmi Win32_OperatingSystem -comp $computer
    $CS = Get-WmiObject –class Win32_ComputerSystem -computername $computer
    $Proc = Get-WmiObject -class Win32_Processor -computername $computer
    Write-host Hostname => $computer
    #Writes the WMI data to the intger fields, then once per round increases the integer by 1
    $WorkSheet.cells.item($i,1)=$computer
    #the $os or $proc is a variable for get 
    $WorkSheet.cells.item($i,2)= $OS.name
    $WorkSheet.cells.item($i,3)= $OS.servicepackmajorversion
    $WorkSheet.cells.item($i,4)= $OS.osarchitecture
    $WorkSheet.cells.item($i,5)= $Proc.count
    $WorkSheet.cells.item($i,6)= $Proc.addresswidth
    $WorkSheet.cells.item($i,7)=$CS.manufacturer
    $WorkSheet.cells.item($i,8)=$CS.model
    $WorkSheet.cells.item($i,9)= $OS.totalvisiblememorysize/1000000
    $i=$i+1                                   #Remember here you say go to another column
}  
$ExcelSheet.visible=$true

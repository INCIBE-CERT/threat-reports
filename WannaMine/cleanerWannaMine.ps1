Get-WMIObject -Namespace root\subscription -Class __FilterToConsumerBinding -
Filter "__Path LIKE '%SCM Event8 Log Consumer%'" | Remove-WmiObject

Get-WMIObject -Namespace root\subscription -Class __EventFilter -filter "Name LIKE
'%SCM Event8 Log Filter%'" |Remove-WmiObject

Get-WMIObject -Namespace root\subscription -Class CommandLineEventConsumer -
Filter ("Name like '%SCM Event8 Log Consumer%'") | Remove-WmiObject

Get-WMIObject -Namespace root\default -List | where {$_.Name –eq
'systemcore_Updater8'} | Remove-WmiObject

sc.exe stop WinRing0_1_2_0
sc.exe delete WinRing0_1_2_0

if
([System.IO.File]::Exists([environment]::SystemDirectory+'\WindowsPowerShell\v1.0\Wi
nRing0x64.sys')) {
 echo ('Borrando
'+[environment]::SystemDirectory+'+'\WindowsPowerShell\v1.0\WinRing0x64.sys') ;
 rm ([environment]::SystemDirectory\WindowsPowerShell\v1.0\WinRing0x64.sys)
}

if ([System.IO.File]::Exists([environment]::SystemDirectory+'\drivers\WinRing0x64.sys'))
{
 echo ('Borrando '+[environment]::SystemDirectory+'+'\drivers\WinRing0x64.sys') ;
 rm ([environment]::SystemDirectory\drivers\WinRing0x64.sys)
}

if ([System.IO.File]::Exists([environment]::SystemDirectory+'\mui.exe')) {
 echo ('Borrando '+[environment]::SystemDirectory+'\mui.exe') ;
 rm ([environment]::SystemDirectory\mue.exe)
}

if ([System.IO.File]::Exists($env:WINDIR+'\temp\sysupdater0.bat')) {
 echo "Borrando $env:WINDIR\temp\sysupdater0.bat" ;
 rm $env:WINDIR\temp\sysupdater0.bat
}

if ([System.IO.File]::Exists($env:WINDIR+'\11.vbs')) {
 echo "Borrando $env:WINDIR\11.vbs" ;
 rm $env:WINDIR\11.vbs
}

if ([System.IO.File]::Exists($env:WINDIR+'\info.vbs')) {
 echo "Borrando $env:WINDIR\info.vbs" ;
 rm $env:WINDIR\info.vbs
}

schtasks /DELETE /TN sysupdater0 /F
function Get-NetFramework(){
	
	$allVersion = @()

	#This code is get versions of all .NET frameworks from 2.0 and above, which have installed in Windows 
	$frameworkKeyRoot = "HKLM:\Software\Microsoft\NET Framework Setup\NDP"
	$subroutes = Get-ChildItem $frameworkKeyRoot -Recurse
	$allVersion += ($subroutes | ForEach {Get-ItemProperty $_.PSPath} | Where {($_.Install -eq 1) -or ($_.SuccessInstall -eq 1)}).Version

	$installedFrameworks += $allVersion | Sort -Unique
	return $installedFrameworks
}
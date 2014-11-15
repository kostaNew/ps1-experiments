function Up-Hotspot{
	<#
    .SYNOPSIS
    Run system based hotspot 
    .EXAMPLE
    
    #>


	param(
        [String]
        # Hotspot SSID
        $Name,
		[String]
		# Hotspot password
		$Password,
		# Hotspot password usage
		[String]
		$PassUsage,
		[String]
		# Hotspot mode
		$Mode,
	)
	
	#Parameters checking
	if ("persistent","temporary" -NotContains $PassUsage){
		Write-Error "$($PassUsage) is not a valid value! Please use 'persistent' or 'temporary'"
	}
	
	if ("allow","disallow" -NotContains $Mode){
		Write-Error "$($Mode) is not a valid value! Please use 'allow' or 'disallow'"
	}
	
	if (($Password.length -ge 8) -and ($Password.length -le 23)){
		Write-Error "$($Password) is not a valid value! Please use 6-23 symbols"
	}
	
	
	#Construct run string
	$command = "netsh wlan set hostednetwork "
	if ($Mode) $command  += "mode=$($Mode) "
	if ($Name) $command  += "ssid=$($Name) "
	if ($Password) $command  += "key=$($Password) "
	if ($PassUsage) $command  += "keyUsage=$($PassUsage)"
	
	& $command
	if( $LastExitCode -ne 0 )
	{
		Write-Error "'netsh wlan set hostednetwork' failed and returned '$LastExitCode'."
	}
	
	netsh wlan start hostednetwork
	if( $LastExitCode -ne 0 )
	{
		Write-Error "'netsh wlan start hostednetwork' failed and returned '$LastExitCode'."
	}
}
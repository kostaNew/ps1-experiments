[xmlElement]$config = ([xml](Get-Content .\config.xml)).Root

#It's behavior for checking and creating new profile if it's no exist
$hostedNetwork = (netsh wlan show hostednetwork)
if (-not ($hostedNetwork -cmatch ("SSID[^\w]*"+$config.Name)))
{
	netsh wlan set hostednetwork  mode=allow  ssid=$config.Name  key=$config.Password
}

netsh wlan start hostednetwork $config.Name
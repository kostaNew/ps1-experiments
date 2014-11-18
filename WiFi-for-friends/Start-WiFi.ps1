[System.Xml.XmlElement]$config = ([xml](Get-Content .\config.xml)).Root

#It's behavior for checking and creating new profile if it's no exist
netsh wlan set hostednetwork  mode=allow  ssid="$($config.Name)"  key="$($config.Password)"

netsh wlan start hostednetwork $config.Name
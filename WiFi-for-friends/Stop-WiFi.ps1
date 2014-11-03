[xml]$config = (Get-Content ".\config.xml").Root
netsh wlan stop hostednetwork $config.Name
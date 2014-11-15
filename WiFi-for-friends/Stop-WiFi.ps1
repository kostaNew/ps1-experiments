[xmlElement]$config = ([xml](Get-Content .\config.xml)).Root

netsh wlan stop hostednetwork $config.Name
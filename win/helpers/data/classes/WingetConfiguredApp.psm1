Using module .\WingetApp.psm1

class WingetConfiguredApp : WingetApp {
    [hashtable]$Configurations

    WingetConfiguredApp(
        [string]$Name,
        [hashtable]$Sources,
        [hashtable]$Configurations
    ) : base($Name, $Sources) {
        $this.Configurations = $Configurations
    }
}

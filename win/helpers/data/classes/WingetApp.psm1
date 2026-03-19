class WingetApp {
    [string]$Name
    [bool]$Install
    [hashtable]$Sources
    [string]$SelectedSource

    WingetApp(
        [string]$Name,
        [hashtable]$Sources
    ) {
        $this.Name = $Name
        $this.Sources = $Sources
    }
}

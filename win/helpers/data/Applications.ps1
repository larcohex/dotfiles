$Applications = @(
    [WingetConfiguredApp]::New(
        'Espanso',
        [ordered]@{ winget = 'Espanso.Espanso'; },
        @{ SetConfigs = $FALSE; }
    )

    [WingetConfiguredApp]::New(
        'Git',
        [ordered]@{ winget = 'Git.Git' }, 
        @{ Globals = @{User_Name = ""; User_Email = ""; } }
    )

    [WingetConfiguredApp]::New(
        'Windows Terminal',
        [ordered]@{ msstore = '9N0DX20HK701'; winget = 'Microsoft.WindowsTerminal'; },
        @{ SetCustomSettings = $FALSE; }
    )
)

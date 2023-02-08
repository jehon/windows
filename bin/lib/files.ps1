
# Thanks to https://stackoverflow.com/a/24992975/1954789

Function Test-FileIsLocked {
    param (
        [parameter(Mandatory=$true)][string]$Path
    )

    $oFile = New-Object System.IO.FileInfo $Path

    try {
        $oStream = $oFile.Open([System.IO.FileMode]::Open, [System.IO.FileAccess]::ReadWrite, [System.IO.FileShare]::None)

        if ($oStream) {
            $oStream.Close()
        }
        return $false
    } catch {
        # file is locked by a process.
        return $true
    }
    $oFile = $null
}

Function Wait-FileUnlocked {
    param (
        [parameter(Mandatory=$true)][string]$Path
    )

    Write-Output "Waiting for file to be unlocked..."
    $res = $false
    Do {
        Start-Sleep 1
        $res = Test-FileIsLocked $Path
    } While ($res)
    Write-Output "Waiting for file to be unlocked done"
}

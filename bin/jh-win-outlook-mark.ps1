

# Param([String]$path)
$path = 'C:\Users\jho\OneDrive - NSI IT Software & Services (NSISABE)\Desktop\test.msg'

. $PSScriptRoot\..\lib\files.ps1

Write-Output "Check the file is not locked"
Wait-FileUnlocked "$path"
Write-Output "Ok,  the file is not locked"

$msg = $null

$dirName = [io.path]::GetDirectoryName($path)
if ($dirName) {
    $dirName = $dirName + '\'
}

$ext = [io.path]::GetExtension($path)
if ($ext -ne ".msg") {
    Write-Output "Not a message"
    exit 1
}

    # https://stackoverflow.com/q/62546688/1954789
Try {

    $outlook = New-Object -comobject outlook.application

    Write-Output "File: $path"

    Try {
        $msg = $outlook.Session.OpenSharedItem($path)
        # $msg | Select-Object "From", SenderName, to, subject, Senton

        $mFrom = $msg | Select-Object -ExpandProperty SenderName
        $mSubject= $msg | Select-Object -ExpandProperty subject
        $mDate = $msg | Select-Object -ExpandProperty SentOn
    } finally {
        Write-Output "Closing msg..."
        $outlook.close($msg)

        $msg.Close(0)
        $msg = $null
        Write-Output "Closing msg done"
    }
} Finally {
    Write-Output "Closing application..."
    [System.Runtime.InteropServices.Marshal]::ReleaseComObject([System.__ComObject]$outlook) | out-null
    $outlook = $null
    Write-Output "Closing application done"
}

Write-Output "Running GC..."
[System.GC]::Collect()
[System.GC]::WaitForPendingFinalizers()
Write-Output "Running GC done"

if ($mDate -ne $null) {
    Write-Output "Calculate file name..."

    $mDateF = "" + $mDate.Year + "-" + ("" + $mDate.Month).PadLeft(2, "0") + "-" + ("" + $mDate.Day).PadLeft(2, "0")
    $mNewFile = $mDateF + " " + $mSubject + " [" + $mFrom + "]"
    $mNewPath = $dirName + $mNewFile

    Write-Output "New filename: $mNewFile"
    Write-Output "New path:     $mNewPath"
    Write-Output "Calculate file name done"

    Wait-FileUnlocked "$path"

    Write-Output "Renaming the file..."
    Rename-Item $path $mNewPath
    Write-Output "Renaming the file done"
}


# Setup config variables
$profile = $env:USERPROFILE
$QEMUPath = "$profile\Documents\AUX_Dev\QEMU"
$devPath = "\Builds\AUXDev"
$ckPointDir = "\checkpoints"

# Check if QEMU is running
$QEMUProcCk = get-process | where ProcessName -eq "qemu-system-m68k"

if ($QEMUProcCk -eq $null){
    # Create checkpoints folder if not exists
    $ckPointTest = "$QEMUPath$devPath$ckPointDir"

    if (Test-Path $ckPointTest) {
    
        Write-Host "Checkpoints directory in place"
    }
    else
    {
        New-Item $ckPointTest -ItemType Directory
        Write-Host "Checkpoints directory created"

    }

    # Create directory to store checkpoint data
    $ckPointDate = get-date -format yyyyMMdd-HHmmss
    $ckPointDir = "$ckPointTest\$ckPointDate-Checkpoint"
    New-Item $ckPointDir -ItemType Directory

    # Backup QEMU machine
    $runPath = "$QEMUPath$devPath"
    Copy-Item -Path "$runPath\*.img" -Destination $ckPointDir
    Copy-Item -Path "$runPath\*.bat" -Destination $ckPointDir

    Write-Host "Checkpoint has been created."
    Write-Host "Checkpoint Location: $ckPointDir"
}
else {
    write-host "You must power off your QEMU machines and close QEMU in order to create a checkpoint."
    pause
}



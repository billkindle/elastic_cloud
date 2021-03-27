# Script that will download and install winlogbeat and filebeat for Windows x64. 
# Very useful script that helped me save a lot of time.

# Path
$TestTempPath = 'C:\Temp'

# Edit the beats version when needed

# Version to be deployed

$ver = '7.12.0'
$Winlogbeat = 'winlogbeat-'+$ver+'-windows-x86_64.msi'
$Filebeat = 'filebeat-'+$ver+'-windows-x86_64.msi'

# Elastic download URL's

$Beats = @(
    # Winlogbeat
    "https://artifacts.elastic.co/downloads/beats/winlogbeat/"+ $Winlogbeat

    # Filebeat
    "https://artifacts.elastic.co/downloads/beats/filebeat/"+ $Filebeat
)

# Test for C:\Temp Directory and create if it does not exist

if ($TestTempPath -eq $True) {
        Write-Host "Path found!"
    }
    else {
        Write-Host "Path NOT found!"
        New-Item -ItemType Directory -Name 'Temp' -Path 'C:\' -Verbose
    }

# Start in C:\Temp directory

Set-Location -Path 'C:\Temp'

# Download latest MSI files

Foreach ($Beat in $Beats) {
    Start-BitsTransfer -TransferType Download -Source $Beat -Destination '.\' -Verbose
}

# Install Beats
# Using ampersand call operator here to get MSI package to install

& .\$Winlogbeat /qn
& .\$Filebeat /qn

# Wait here while installation finishes up, otherwise Get-Service will error out prematurely. 

Start-Sleep -Seconds 10 -Verbose

# Check Services

Get-Service -ServiceName winlogbeat,filebeat -Verbose

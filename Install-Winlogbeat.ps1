# Path
$TestTempPath = 'C:\Temp'

# Edit the beats version when needed

# Version to be deployed

$ver = '7.12.0'

$Winlogbeat = 'winlogbeat-'+$ver+'-windows-x86_64.msi'

# Elastic download URL's

$Beat = "https://artifacts.elastic.co/downloads/beats/winlogbeat/"+ $Winlogbeat

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

Start-BitsTransfer -TransferType Download -Source $Beat -Destination '.\' -Verbose


# Install Beats
# Using ampersand call operator here to get MSI package to install

& .\$Winlogbeat /qn

Start-Sleep -Seconds 10 -Verbose

# Check Services

Get-Service -ServiceName winlogbeat -Verbose

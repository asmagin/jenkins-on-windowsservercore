$ProgressPreference = 'SilentlyContinue'

# SHOW CONTAINER INFO
$ip = Get-NetAdapter | 
    Select-Object -First 1 | 
    Get-NetIPAddress | 
    Where-Object { $_.AddressFamily -eq "IPv4"} |
    Select-Object -Property IPAddress | 
    ForEach-Object { $_.IPAddress }

Write-Host "= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = " -ForegroundColor Yellow
Write-Host "JENKINS MASTER CONTAINER" -ForegroundColor Yellow
Write-Host ("Started at:     {0}" -f [DateTime]::Now.ToString("yyyy-MMM-dd HH:mm:ss.fff")) -ForegroundColor Yellow
Write-Host ("Container Name: {0}" -f $env:COMPUTERNAME) -ForegroundColor Yellow
Write-Host ("Container IP:   {0}" -f $ip) -ForegroundColor Yellow
Write-Host ("Access URL:     http://{0}:8080" -f $ip) -ForegroundColor Yellow
Write-Host "= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = " -ForegroundColor Yellow


# Note: move default files to attached volume after the start of container
if(Test-Path 'c:/backups') {
    Get-ChildItem 'c:/backups/*' -Filter "FULL-*" | 
        Sort-Object Name -Descending | 
        Select-Object -First 1 | 
        Copy-Item -Destination 'c:/jenkins/' -Recurse -Force
}

# Note: download plugins
if(Test-Path 'c:/scripts/plugins.txt') {
    Get-Content 'c:/scripts/plugins.txt' |
        ForEach-Object {
            $plugin = $_
            $url = "$env:JENKINS_UC/download/plugins/$plugin/latest/${plugin}.hpi"

            if (Test-Path "c:/jenkins/plugins") {
                Write-Host "Skipping plugin:`t[$plugin]"
            }
            else {
                Write-Host "Downloading plugin:`t[$plugin]`tfrom`t$url"
                Invoke-WebRequest  $url -OutFile "c:/jenkins/plugins/${plugin}.jpi" -UseBasicParsing -ErrorAction SilentlyContinue
            }
        }

    Remove-Item 'c:/scripts/plugins.txt'
}

& 'java.exe' '-jar' 'c:/jenkins.war'

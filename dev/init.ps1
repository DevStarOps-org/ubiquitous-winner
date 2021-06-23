#requires -PSEdition Core
# Additional steps to initialize the development container

Install-Module sqlserver -Confirm:$False  -Force

# Create new database
# Source for the retry logic:
# https://stackoverflow.com/a/47712807/411428
$attempts=20
$sleepInSeconds=3
do
{
    try
    {
        Invoke-Sqlcmd -ServerInstance "db_instance,1433" -Username SA -Password 8y2xQG^tG!wsgPN5B2C!gCEzPn^1w -Query "CREATE DATABASE [ubiquitous-winner]";
        Write-Host "Database created successfully."
        break;
    }
    catch [Exception]
    {
        #Write-Host $_.Exception.Message
        Write-Host "Retrying..."
    }            
    $attempts--
    if ($attempts -gt 0) { Start-Sleep $sleepInSeconds }
} while ($attempts -gt 0)

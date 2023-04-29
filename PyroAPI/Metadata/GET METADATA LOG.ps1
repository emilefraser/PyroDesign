Export the Power BI audit log events
Export the PowerBI events from the O365 Audit Log into separate .CSV files for each of the last 90 days. See this Docs file for more information on this feature.

In [0]:
$UserCredential = Get-Credential 'your.email@somewhere.com'

90..1 |
foreach {

$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $UserCredential -Authentication Basic -AllowRedirection
Import-PSSession $Session

$Start=((Get-Date).Date).AddDays(-$_);            
Search-UnifiedAuditLog -StartDate $Start -EndDate $Start.AddDays(1) -RecordType PowerBI -ResultSize 5000 |
Export-Csv -Path "c:\temp\PowerBIAuditLogs\PowerBIAudit_Log_$(Get-Date -Date $Start.AddDays(1) -Format yyyyMMdd).csv" -NoTypeInformation

Remove-PSSession $Session

}

Use Get-PowerBIActivityEvent cmdlet
Once the service supporting the Get-PowerBIActivityEvent cmdlet is back online, you will only need to be a Power BI Admin in order to collect Power BI audit log events.

First things first, Login to the tenant you need to work with.

In [0]:
Login-PowerBI
The example below will retrieve the current day's audit log events. Please not the specific date-formatting required to use the cmdlet.

In [0]:
Get-PowerBIActivityEvent -StartDateTime (Get-Date ((Get-Date).Date) -Format yyyy-MM-ddTHH:mm:ss) -EndDateTime (Get-Date -Format yyyy-MM-ddTHH:mm:ss)
Retrieve the past 90 days worth of Power BI audit log events and save each day's events to it's own .json file.

In [0]:
90..1 |
foreach {
    $Date = (((Get-Date).Date).AddDays(-$_))
    $StartDate = (Get-Date -Date ($Date) -Format yyyy-MM-ddTHH:mm:ss)
    $EndDate = (Get-Date -Date ((($Date).AddDays(1)).AddMilliseconds(-1)) -Format yyyy-MM-ddTHH:mm:ss)
    
    Get-PowerBIActivityEvent -StartDateTime $StartDate -EndDateTime $EndDate -ResultType JsonString | 
    Out-File -FilePath "c:\temp\PowerBIAuditLogs\PowerBI_AudititLog_$(Get-Date -Date $Date -Format yyyyMMdd).json"
}
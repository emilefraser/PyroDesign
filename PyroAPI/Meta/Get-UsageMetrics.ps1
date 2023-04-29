<#
	This script produces a CSV file containing Power BI activity log events for one day
#>

#1. Retrieve credentials from Admin File

#. C:\BIAdminScripts\AdminCreds.ps1
# 346d2ea6-82fc-432a-9280-f84b4485632a
# Z92SnmBhTxc.=6hKD]g[eyBoc5C7jlPg
#2. Authenticate to Power BI
$PBIAdminUPN = "efrsaser@tharisa.co.za"
$PBIAdminPW = "HelloDolly1903"


$SecPasswd = ConvertTo-SecureString $PBIAdminPW -AsPlainText -Force
$myCred = New-Object System.Management.Automation.PSCredential($PBIAdminUPN,$SecPasswd)

Connect-PowerBIServiceAccount -Credential $myCred

#3. Define export path and current date to retrieve

$ActivityLogsPath = "C:\test\ActivityLogs.csv"

$RetrieveDate = Get-Date

$RetrieveYearStr = $RetrieveDate.ToString('yyyy')
$RetrieveMonthStr = $RetrieveDate.ToString('MM')
$RetrieveDayStr = $RetrieveDate.ToString('dd')

$StartDT = $RetrieveYearStr + '-' + $RetrieveMonthStr + '-' + $RetrieveDayStr + 'T00:00:00.000'
$EndDT = $RetrieveYearStr + '-' + $RetrieveMonthStr + '-' + $RetrieveDayStr + 'T23:59:59.999'

#4. Export out current date activity log events to CSV file

$ActivityLogs = Get-PowerBIActivityEvent -StartDateTime $StartDt -EndDateTime $EndDT | ConvertFrom-Json
$ActivityLogs
# $ActivityLogSchema = $ActivityLogs | `
#     Select-Object Id,RecordType,CreationTime,Operation,OrganizationId,UserType,UserKey,Workload, `
#         UserId,ClientIP,UserAgent,Activity,ItemName,WorkspaceName,DatasetName,ReportName, `
#         WorkspaceId,CapacityId,CapacityName,AppName,ObjectId,DatasetId,ReportId,IsSuccess, `
#         ReportType,RequestId,ActivityId,AppReportId,DistributionMethod,ConsumptionMethod, `
#         @{Name="RetrieveDate";Expression={$RetrieveDate}}

# $ActivityLogSchema | Export-Csv $ActivityLogsPath


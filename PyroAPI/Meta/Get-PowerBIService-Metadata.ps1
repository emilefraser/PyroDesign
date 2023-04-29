# Install-Module -Name MicrosoftPowerBIMgmt
# Update-Module -Name MicrosoftPowerBIMgmt

#Login
Connect-PowerBIServiceAccount

# or use aliases: Login-PowerBIServiceAccount, Login-PowerBI
# Get workspaces
Get-PowerBIWorkspace -All

# Get all workspacess for tennant
Get-PowerBIWorkspace -Scope Organization -All


# Reports
Get-PowerBIReport -Scope Organization

Get-PowerBIDashboard -Scope Organization

Get-PowerBITile -DashboardId 9a58d5e5-61bc-447c-86c4-e221128b1c99
Get-PowerBIImport -Scope Organization

Get-PowerBIDataset

# INVOKE REST API
Invoke-PowerBIRestMethod -Url 'reports/4eb4c303-d5ac-4a2d-bf1e-39b35075d983/Clone' -Method Post -Body ([pscustomobject]@{name='Cloned report'; targetModelId='adf823b5-a0de-4b9f-bcce-b17d774d2961'; targetWorkspaceId='45ee15a7-0e8e-45b0-8111-ea304ada8d7d'} | ConvertTo-Json -Depth 2 -Compress)



Get-PowerBIAccessToken -AsString
Resolve-PowerBIError -Last

Invoke-RestMethod -Uri
GET https://api.powerbi.com/v1.0/myorg/admin/activityevents?startDateTime=2019-08-13T07:55:00.000Z&endDateTime=2019-08-13T08:55:00.000Z&$filter=Activity eq 'ViewReport'



 https://api.powerbi.com/v1.0/myorg/admin/activityevents?startDateTime=2019-08-13T07:55:00.000Z&endDateTime=2019-08-13T08:55:00.000Z&$filter=Activity eq 'ViewReport'


 $Cred = Get-Credential


$Url = "https://api.powerbi.com/v1.0/myorg/admin/activityevents"
$Body = @{
    startDateTime = "2019-08-13T07:55:00.000Z"
    endDateTime = "2019-08-13T08:55:00.000Z"
    filter = "Activity eq 'ViewReport'"
}
*------------------
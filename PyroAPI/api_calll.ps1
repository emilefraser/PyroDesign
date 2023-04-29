
$pbiUsername = "abc.xyz@xxx.com"
$pbiPassword = "Password"
$clientId = "a81b2cc1-4c97-2323-bal4-eeb21c4c6e46"

$body = @{"resource" = "https://analysis.windows.net/powerbi/api"
    "client_id" = $clientId;
    "grant_type" = "password";
    "username" = $pbiUsername;
    "password" = $pbiPassword;
    "scope" = "openid"
}

$authUrl = "https://login.windows.net/common/oauth2/token/"
$authResponse = Invoke-RestMethod -Uri $authUrl –Method POST -Body $body

$headers = @{
    "Content-Type" = "application/json";
    "Authorization" = $authResponse.token_type + " " +
                      $authResponse.access_token
}

$restURL = "https://api.powerbi.com/v1.0/myorg/groups"
$restResponse = Invoke-RestMethod -Uri $restURL –Method GET -Headers $headers

powershell powerbi





Francois Senekal there you go (smile)

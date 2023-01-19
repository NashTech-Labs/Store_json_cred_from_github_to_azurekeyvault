$response = Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/Balraj0017/ADO_cred/main/test2.json' -UseBasicParsing
$response = $response | ConvertFrom-Json 
foreach ($r in $response.GetEnumerator()) {
    $SecureString = ConvertTo-SecureString $r.SecretKey -AsPlainText -Force
    $ApplicationName = $r.ApplicationName -Replace '\.',''
    Set-AzKeyVaultSecret -VaultName "demo1cred" -Name $ApplicationName -SecretValue $SecureString
    #getting the secret
    Get-AzKeyVaultSecret -VaultName "demo1cred" -Name $ApplicationName -AsPlainText
}

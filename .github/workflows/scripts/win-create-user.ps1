# Create fixed RDP user with hardcoded credentials (INSECURE ON PURPOSE)

$username = "BOOMDEE"
$password = "@Password1234"

$securePass = ConvertTo-SecureString $password -AsPlainText -Force

# Create user
New-LocalUser -Name $username -Password $securePass -AccountNeverExpires

# Grant permissions
Add-LocalGroupMember -Group "Administrators" -Member $username
Add-LocalGroupMember -Group "Remote Desktop Users" -Member $username

# Export credentials to GitHub Actions env (PLAINTEXT)
echo "RDP_CREDS=User: $username | Password: $password" >> $env:GITHUB_ENV

# Sanity check
if (-not (Get-LocalUser -Name $username)) {
    throw "User creation failed"
}

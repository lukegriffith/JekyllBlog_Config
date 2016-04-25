Import-Module "C:\Program Files (x86)\AWS Tools\PowerShell\AWSPowerShell"

$VerbosePreference = 'Continue'

$data = ConvertFrom-StringData (Get-Content -Path $PSScriptRoot\AWSCred.txt -Raw)

$cred = New-AWSCredentials -AccessKey $data.AWSAccessKeyId -SecretKey $data.AWSSecretKey

Write-Verbose "Cleaning bucket..."

Get-S3Object -BucketName lgjekyllblog -KeyPrefix "\" -Credential $cred | Remove-S3Object -BucketName lgjekyllblog -Force -Credential $cred

Write-Verbose "Starting Upload"

Write-S3Object -BucketName lgjekyllblog -Folder "C:\Users\lukem\Documents\GitHub\JekyllBlog_Site" -Recurse -Credential $cred -KeyPrefix '\' -Verbose


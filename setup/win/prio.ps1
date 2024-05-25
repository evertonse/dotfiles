$downloadUrl = "https://www.prnwatch.com/prio/download/prio.zip"
$outputPath = "$env:USERPROFILE\Downloads\prio.zip"

Invoke-WebRequest -Uri $downloadUrl -OutFile $outputPath

$zipPath = "$env:USERPROFILE\Downloads\prio.zip"
$extractPath = "$env:USERPROFILE\Downloads\prio"

Expand-Archive -Path $zipPath -DestinationPath $extractPath



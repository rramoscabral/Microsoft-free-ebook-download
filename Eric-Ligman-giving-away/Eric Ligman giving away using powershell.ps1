#You must run this script as administrator

Set-ExecutionPolicy RemoteSigned -Scope CurrentUser

# File with downloads link location
$file = "c:\MSFTEbooks\MSFTEbooks2.txt"

#File data to array
$shareArray = gc $file

#clean output
cls

#Verefy import data
foreach ($Data in $shareArray)
{
    #Write-Host $shareArray[0] 
    $Data = $Data -split(',')
    Write-Host $Data[0]
}


# Download directory
$downloadDir = 'c:\MSFTEbooks\Eric Ligman\'


# begin download
foreach ($Data in $shareArray)
 {
  $Data = $Data -split(',')
  $source = $Data[0]
  
  # Source without tiny url
  #$filename = [System.IO.Path]::GetFileName($source)

  # Source with tiny url
  $response = Invoke-WebRequest -Uri $source
  $filename = [System.IO.Path]::GetFileName($response.BaseResponse.ResponseUri.OriginalString)
  

  $dest = $downloadDir + $filename

  
  #Dowload using System.Net.WebClient without download information
  #$wc = New-Object System.Net.WebClient
  #$wc.DownloadFile($source, $dest)

  #Dowload with download information
  Import-Module BitsTransfer
  $start_time = Get-Date  
  Start-BitsTransfer -Source $source -Destination $dest
  Write-Output "Time taken: $((Get-Date).Subtract($start_time).Seconds) second(s)"  
  
   
  Write-Host "Downloaded $source to file location $dest" 
}

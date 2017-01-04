<#
.VERSION 1.0.0

.DEPENDENCIES

 - AzCopy.exe -> http://aka.ms/downloadazcopy


.PARAMETERS 

 - $SourceUrl
    Table Storage URL

 - $TargetFolder
    Folder path to save data

 - $AccessKey
    Storage account access key

#>

param(
    [Parameter(Mandatory=$true)]
    [String]
    $SourceUrl,
    [Parameter(Mandatory=$true)]
    [String]
    $TargetFolder,
    [Parameter(Mandatory=$true)]
    [String]
    $AccessKey
)

# Fields
$_azcopyExecutablePath = '';
$_azCopyDefaultPath = 'C:\Program Files (x86)\Microsoft SDKs\Azure\AzCopy';
$_currentPath = (Resolve-Path .\).Path;

$_isValidAzCopyPath = Test-Path $_azCopyDefaultPath;

# TODO : Verify if azcopy exists in the machine
if(!$_isValidAzCopyPath) 
{
    Get-Item -Path 'C:\**\*\*\azcopy.exe' -Force | Select FullName
    # $_azcopyExecutablePath = 
}
else {
    $_azcopyExecutablePath = $_azCopyDefaultPath;
}

# Run Backup
cd $_azcopyExecutablePath;

azcopy.exe `
    /Source:$SourceUrl `
    /Dest:$TargetFolder `
    /SourceKey:$AccessKey

cd $_currentPath;
$root = [System.IO.Path]::GetDirectoryName($myInvocation.MyCommand.Definition)
$projectName = "DevopsTest"
$SaPassword = "PassW@rd123"

$msbuildPath = "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\MSBuild\\Current\\Bin\\msbuild.exe"

Write-Host "Testing path: " $msbuildPath

if(!(Test-Path $msbuildPath)){
    Write-Host "Can't find msbuild?? make sur eyou installed visual studio 2015 or 2017"  
    Exit(1)
}

Write-Host "Using path: " $msbuildPath

& $msbuildPath .\DevopsTest.sln


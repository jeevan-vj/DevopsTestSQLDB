
# $msbuildPath = "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\MSBuild\\Current\\Bin\\msbuild.exe"

# Write-Host "Testing path: " $msbuildPath
<#
if(!(Test-Path $msbuildPath)){
    Write-Host "Can't find msbuild?? make sur eyou installed visual studio 2015 or 2017"  
    Exit(1)
}

Write-Host "Using path: " $msbuildPath

& $msbuildPath .\DevopsTest.sln
#>
& dotnet build   .\DevopsTest.Build\DevopsTest.Build.csproj


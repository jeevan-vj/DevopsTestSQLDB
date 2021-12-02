$root = [System.IO.Path]::GetDirectoryName($myInvocation.MyCommand.Definition)
$projectName = "DevopsTest"
$SaPassword = "PassW@rd123"

$SqlPackageExeLocation = "C:\jeevan\Softwares\sqlpackage-win7-x64-en-US-15.0.5084.2\sqlpackage.exe"
$buildOutPutDacpacFilePath = (Join-Path $root "DevopsTest\bin\Debug\DevopsTest.dacpac")
$buildOutPutDacpacFilePathTestProject = (Join-Path $root "DevopsTest.Tests\bin\Debug\DevopsTest.Tests.dacpac")

if(!(Test-Path $buildOutPutDacpacFilePath)){
    Write-Host "Can't find dacpac in : " $buildOutPutDacpacFilePath  
    Exit(1)
}
if(!(Test-Path $buildOutPutDacpacFilePathTestProject)){
    Write-Host "Can't find dacpac for Test project in : " $buildOutPutDacpacFilePathTestProject  
    Exit(1)
}

Write-Host "Creating SQL Server in Docker"

docker run -e "ACCEPT_EULA=Y" -e "SA_PASSWORD=PassW@rd123" `
   -p 1434:1433 --name sql1 -h sql1 `
   -d mcr.microsoft.com/mssql/server:2019-latest
     

docker exec  sql1 /opt/mssql-tools/bin/sqlcmd `
   -S localhost -U SA -P $SaPassword `
   -Q "EXEC sp_configure 'show advanced option', '1'; RECONFIGURE; EXEC sp_configure 'clr enabled', 1;RECONFIGURE; EXEC sp_configure 'clr strict security', 0;RECONFIGURE"

   
if(!($?) -or $lastExitCode -ne 0){
    exit(1)
}

Write-Host "Deploying Unit Tests"

& $SqlPackageExeLocation /action:Publish  /SourceFile:$buildOutPutDacpacFilePathTestProject /TargetDatabaseName:tSQLt /TargetServerName:'localhost,1434' /tu:sa /tp:$SaPassword  /Variables:DevopsTest=DevopsTest
& $SqlPackageExeLocation /action:Publish  /SourceFile:$buildOutPutDacpacFilePath /TargetDatabaseName:DevopsTest /TargetServerName:'localhost,1434' /tu:sa /tp:$SaPassword 

Write-Host "Successfully deployed to Unit Test DB"

Write-Host "Running Unit Tests"

docker exec  sql1 /opt/mssql-tools/bin/sqlcmd `
   -S localhost -U SA -P $SaPassword `
   -d tSQLt `
   -y0 `
   -Q "BEGIN TRY EXEC tSQLt.RunAll END TRY BEGIN CATCH END CATCH; EXEC tSQLt.XmlResultFormatter"


if(!($?) -or $lastExitCode -ne 0){
    exit(1)
}

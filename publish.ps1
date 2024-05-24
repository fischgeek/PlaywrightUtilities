Param(
  [switch]$SkipDuplicationCheck
)
pushDir
cd $PSScriptRoot
paket install
if($LASTEXITCODE){
    Write-Error "Failed to install paket dependencies"
}else{
    dotnet pack ./PlaywrightUtilities --include-source
    $f=dir *.nupkg -rec | sort LastWriteTime -desc | select -first 1
    ## NOTE: The WCRI_GITHUB_PACKAGES_PASSWORD is a Github classic personal access token with package write priivleges
    $url = "https://nuget.pkg.github.com/WesternCapital/index.json"
    if($SkipDuplicationCheck){
        dotnet nuget push $f --source $url --api-key $env:WCRI_GITHUB_PACKAGES_PASSWORD --skip-duplicate
    }else{
        dotnet nuget push $f --source $url --api-key $env:WCRI_GITHUB_PACKAGES_PASSWORD
    }
    if($LASTEXITCODE -eq 0){
        Write-Host "Successfully pushed package to Github Packages"
    }else{
        Write-Error "Failed to push package to Github Packages: $LASTEXITCODE"
    }
}
popdir

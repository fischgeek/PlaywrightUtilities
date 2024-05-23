dotnet pack ./PlaywrightUtilities --include-source

## NOTE: The WCRI_GITHUB_PACKAGES_PASSWORD is a Github classic personal access token with package write priivleges
dotnet nuget push "./PlaywrightUtilities/bin/Release/Fischgeek.PlaywrightUtilities.1.0.0.symbols.nupkg" --source "https://nuget.pkg.github.com/WesternCapital/index.json" --api-key $env:WCRI_GITHUB_PACKAGES_PASSWORD
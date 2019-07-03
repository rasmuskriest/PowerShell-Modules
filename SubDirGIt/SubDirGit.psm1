<#
 .Synopsis
  Runs git on multiple sub-directories.

 .Description
  Runs git on multiple sub-directories. It allows to forward almost every git command (e.g. status, pull, push) which then will be executed in every sub-directory that has a .git folder.

 .Parameter GitCommand
  The git command to forward.

 .Example
   # Pulls all git repositories in subdirecotires.
   Invoke-SubDirGit pull
#>

function Invoke-SubDirGit {
    param(
        [Parameter(mandatory = $true)]
        [String] $GitCommand
    )
    $Current = Get-Location
    Get-ChildItem | ForEach-Object {
        Set-Location $_.FullName
        Write-Output $_.FullName
        Get-ChildItem -Hidden | Where-Object { $_.Basename -eq ".git" } | ForEach-Object {
            git.exe $GitCommand
            Write-Output ""
        }
    }
    Set-Location $Current
}

Export-ModuleMember -Function Invoke-SubDirGit

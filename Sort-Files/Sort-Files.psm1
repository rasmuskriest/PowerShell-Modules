<#
 .Synopsis
  Sorts files by adding the creation time to the beginning of the file name.

 .Description
  Sorts files by adding the creation time to the beginning of the file name. The filetype needs to be specified. The date will be added at the beginning of the file name in form of yyyy_MM_dd_Filename.extension.

 .Parameter Folder
  The folder to sort files in.

  .Parameter Filetype
  The filetype to sort.

 .Example
   # Sort all screenshots taken in the *.png format. 
   Invoke-SortFiles -Folder 'D:\Screenshots' -Filetype '*.png'
#>

function Invoke-SortFiles {
    param(
        [Parameter(Position = 0, mandatory = $true)]
        [String] $Folder,
        [Parameter(Position = 1, mandatory = $true)]
        [String] $Filetype
    )
    Get-ChildItem -Path $Folder -Filter $Filetype | Where-Object { -Not ($_.Basename -match "^[0-9,_]{11}") } | ForEach-Object {
        $prefixedName = $_.CreationTime.ToString("yyyy_MM_dd") + "_" + $_.Name
        Rename-Item $_.FullName -NewName $prefixedName
        Write-Output $prefixedName
    }
}

Export-ModuleMember -Function Invoke-SortFiles

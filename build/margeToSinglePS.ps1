function convertTo-StandaloneScript(){
    param(
            [parameter(mandatory=$true)][String]$inFile,
            [parameter(mandatory=$true)][String]$outFile
    )
<#
           .SYNOPSIS 
           Merge source files to single ps1.file.
           This is the entry point of mergeToSinglePS.ps1


           .DESCRIPTION
           Replace Import-Module to content of the module.
           "Import-Module specific_module.ps1" in the inFile will replace the contents of specific_module.ps1.
           path to specific_module.ps1 should be absolute path or relateve path from inFile.
    
           .PARAMETER  InFile
           Specify input .ps1 script file.

           .PARAMETER  OutFile
           Specify output .ps1 script file.

           .INPUTS
           None. You cannot pipe objects.

           .OUTPUTS
           None. Return nothing.

           .EXAMPLE
           convertTo-StandaloneScript.ps1 -inFile "/path/to/input.ps1" -outFile "/path/to/input.ps1"
#>
    ## Show progress
    Write-Host("Start to convert");
    Write-Host("inFile  "+$inFile);
    Write-Host("outFile "+$outFile);


    ## Work on directory inFile placed.
    Set-Location(Split-Path($inFile));
    Write-Host("Current Directiory "+(Get-Location));

    $TmpInc=New-TemporaryFile
    $TmpBody=New-TemporaryFile

    foreach($line in Get-Content($inFile)){
        if($line.trimU() -match "^Import-Module"){
            $modName=($line.replace("Import-Module","")).trim(); 
            readAll -inFile $modName -outFile $outFile
        }else{
            Add-Content -Path $outFile -Value $line
        }        
    }

}
function readAll(){
    param(
            [parameter(mandatory=$true)][String]$inFile,
            [parameter(mandatory=$true)][String]$outFile
    )
    foreach($line in Get-Content($inFile)){
        Add-Content -Path $outFile -Value $line
    }
}

convertTo-StandaloneScript -inFile "C:\Users\TEMP.JP.000\Documents\mana-leka\build\margeToSinglePS.ps1" -outFile "margeToSinglePS.txt";

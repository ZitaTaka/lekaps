<#
.SYNOPSIS
.DESCRIPTION
.INPUTS
.OUTPUTS
.EXAMPLE
.LINK
#>

class ManaLekaService{
    [PSCustomObject]$properties

    [void]ready(){
    }
    [int]retrieve(){
        return 0
    }
    [int]replySync(){
        return 0
    }
    [void]term(){
    }
}

class ManaLekaClient{
    [PSCustomObject]$properties

    [void]ready(){
    }
    [int]submitSync(){
        return 0
    }
    [int]submitAsync(){
        return 0
    }
    [void]term(){
    }
}

class ManaLekaBuilder{

    static [PSCustomObject]getProperties(
        [string]$path
    ){
        Write-Host $path
        If( -not (Test-Path $path)){
            Throw "File does not exist[$path]"
        }

        $p=[PSCustomObject]@{}
        $x=New-Object System.Xml.XmlDocument
        $x.Load("$path")
        $x.Objects.Object.property | ForEach-Object{
            Add-Member -InputObject $p -MemberType NoteProperty -Name $_.Name -Value $_.InnerText
        }

        return $p
    }
    static [PSCustomObject]getProperties(){
        return [PSCustomObject]@{
            Type    =""
            Channel =""
        }
    }

    static [ManaLekaService]buildService(
        [PSCustomObject]$property = $null
    ){
        return $null
    }

    static [ManaLekaClient]buildClient(
        [PSCustomObject]$property = $null
    ){
        return $null
    }
}

class ManaLekaNamedPipeBuilder : ManaLekaBuilder {

    static [PSCustomObject]getProperties(){
        $p=[ManaLekaBuilder]::getProperties()
        $p.Type="NamedPipe"
        $p.Channel=""
        return $p
    }

    static [ManaLekaService]buildService(
        [PSCustomObject]$property = $null
    ){
        return $null
    }

    static [ManaLekaClient]buildClient(
        [PSCustomObject]$property = $null
    ){
        return $null
    }
}

# Test Code
$p=([ManaLekaNamedPipeBuilder]::getProperties() | ConvertTo-Xml -NoTypeInformation -As String)
Set-Content -Path "C:\hoge.txt" -Value $p
#Export-clixml -Path "C:\hoge.txt" -
"---"
[ManaLekaNamedPipeBuilder]::getProperties("C:\hoge.txt") | ConvertTo-Xml -NoTypeInformation -As String
[ManaLekaNamedPipeBuilder]::getProperties("C:\hoge.txt") | ConvertTo-Json

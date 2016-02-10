Write-Output ("Fetching directory list...")
$files = Get-ChildItem -Path "C:\temp" -Directory -Recurse -ErrorAction SilentlyContinue -ErrorVariable errArray 

$scriptPath = Split-Path $script:MyInvocation.MyCommand.Path
$outputFile = $scriptPath + "\" + "hierarchy.csv"
$errorLog = $scriptPath + "\" + "error.csv"

foreach ($p in $files)
{
    IF( Test-Path $p.FullName ) 
    {
        # Write the selected directory out to file
        Write-Output ("Directory: {0}" -f $p.Name)
        $value = 'dir,' + $p.FullName.Replace("\",",")
        Add-Content -Value $value -Path $outputFile

        # Find children in this directory, write them out to file
        $children = Get-ChildItem -Path $p.FullName -File -ErrorAction SilentlyContinue -ErrorVariable errArray 
        foreach ($c in $children)
        {
            Write-Output ("    File: {0}" -f $c)
            $value = 'file, ' + $c.FullName.Replace("\",",")
            Add-Content -Value $value -Path $outputFile
        }

        #Add-Content -Value $f.FullName.Replace("\",",") -Path $outputFile    
    } ELSE {
        Write-Output ("Error on: {0}" -f $file.FullName)
        #Add-Content -Value $f.FullName -Path $errorLog
    }
}


foreach ($err in $errArray) 
{
    Write-Output ("Write out to error log {0}" -f $err.TargetObject)
    if ($err.Exception -is [System.IO.PathTooLongException]) 
    {
        Add-Content -Value $err.TargetObject -Path $errorLog
    } else {
        Write-Error -ErrorRecord $err
    }
}


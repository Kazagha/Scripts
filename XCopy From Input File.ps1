# Source File: List of directory and filenames, new line for each
$sourceFile = "C:\temp\search\results.txt"
# Destinaton: The destination directory /w blackslash at the end
$dest = "C:\temp\Search\"

Get-Content $sourceFile | ForEach-Object {    

    $item = Get-Item $_.ToString()
    
    IF ( $item -is [System.IO.DirectoryInfo] )
    {
        # Copy Directories - Not required at the moment

        # Write-Output  ("Copying Directory: {0}" -f $item)               
    } ELSE {
        # Copy files

        # Write-Output ("Copying File {0}" -f $item)
        
        # Determine destination directory including the full source path 
        $destDir = $dest + $_.Substring(2, $_.LastIndexOf("\") - 1)

        # Copy the file to the destination directory 
        XCOPY /Y /I $item $destDir        
    }
}

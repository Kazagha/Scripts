
# Source File: List of directory and filenames, new line for each
$sourceFile = "C:\temp\search\results.txt"
# Destinaton: The destination directory /w blackslash at the end
$dest = "C:\temp\Search\"

Get-Content $sourceFile | ForEach-Object {    

    # Grab the item in the source file
    $item = Get-Item $_.ToString()

    # Determine destination directory including the full source path 
    $destDir = $dest + $_.Substring(2, $_.LastIndexOf("\") - 1)

    # Copy the item into the destination directory
    XCOPY /Y /S /I $item $destDir        
    
}

# Source File: List of directory and filenames, new line for each
$sourceFile = "C:\temp\search\results.txt"
# Destinaton: The destination directory /w blackslash at the end
$dest = "C:\temp\Search\"

Get-Content $sourceFile | ForEach-Object {    

    # Grab the file (or directory) name 
    $file = $_.toString().Substring($_.LastIndexOf("\") + 1)

    # Grab the source directory of the file
    $srcDir = $_.ToString().Substring(0, $_.LastIndexOf("\"))

    # Determine destination directory (the above $dest directory plus source directory)
    $destDir = $dest + $_.Substring(2, $_.LastIndexOf("\") - 2)

    # Copy the item into the destination directory
    #Write-Output ("{0} -> {1}" -f $srcDir, $file)
    ROBOCOPY "$srcDir" "$destDir" "$file"
}

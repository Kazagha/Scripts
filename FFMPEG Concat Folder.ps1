<#
 # Author: Kazagha
 # Date: 26/06/2015
 # 
 # The script requires FFMPEG (www.ffmpeg.com)
 #>

<#
 # Set Variables
 #
 # rootFolder: Directory where videos are located
 # outDir: Directory to save converted videos
 # ffmped: Location of ffmpeg.exe
 #>

$rootFolder = Get-ChildItem "C:\root"
$outDir = "C:\out"
$ffmpeg = "C:\ffmpeg\bin\ffmpeg.exe"

# Create blank array 
$array = @()

# Iterate through each element in the root directory
foreach($e in $rootFolder) {
    # Check if the element is a folder
    if($e.Mode.Equals("d----")) {

        # Collect all elements in the sub folder into the subArray variable
        $subArray = @()
        $subFiles = Get-ChildItem $e.FullName -filter "*.avi"
        
        foreach($s IN $subFiles) {
            $subArray += "file '{0}'" -f$s.FullName
        }

        $temp = New-Object psobject
        $temp | Add-Member NoteProperty -Name "Title" -Value $e.Name
        $temp | Add-Member NoteProperty -Name "Input" -Value $e.FullName
        $temp | Add-Member NoteProperty -Name "Out" -Value ("{0}\{1}.avi" -f $outDir, $e.Name)
        $temp | Add-Member NoteProperty -Name "Files" -Value $subArray

        $array += $temp
    }
}

foreach($e in $array) {
    # Set the name of the temp file
    $temp = ("{0}\{1}.txt" -f $outDir, $e.Title)

    # Write out a list of files to convert into the temp file
    $e.Files | Out-File $temp -Encoding ascii

    Write-Output ("{0} -f concat -i {1} -acodec copy -b:a 128k -vcodec mpeg4 -b:v 1200k -flags +aic+mv4 {2}" -f $ffmpeg, $temp, $e.Out)

    $command = ("{0} -f concat -i {1} -c copy {2}" -f $ffmpeg, $temp, $e.Out) 
    
    &$ffmpeg -f concat -i $temp -c copy $e.Out
    
    Remove-Item $temp
}
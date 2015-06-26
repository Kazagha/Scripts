$rootFolder = Get-ChildItem "C:\Temp\Video"
$outDir = "M:\Gaming\Chris"
$ffmpeg = "C:\chris.green\ffmpeg-20150610-git-913685f-win64-static\bin\ffmpeg.exe"
$array = @()

foreach($e in $rootFolder) {
    if($e.Mode.Equals("d----")) {
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
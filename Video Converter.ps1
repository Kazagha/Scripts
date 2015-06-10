$rootFolder = Get-ChildItem "C:\Temp"
$outDir = "C:\temp"
$ffmpeg = "C:\Chris.Green\Library\ffmpeg-20150610-git-913685f-win64-static\bin\ffmpeg.exe"
$array = @()

foreach($e in $rootFolder) {
    if($e.Mode.Equals("d----")) {
        $subArray = @()

        $subFiles = Get-ChildItem $e.FullName
        
        foreach($s IN $subFiles) {
            #Write-Output " -  $f.Name"
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
    $temp = ("{0}\list-{1}.txt" -f $outDir, $e.Title)
    $e.Files | Out-File $temp

    Write-Output ("{0} -f concat -i {1} -c copy {2}" -f $ffmpeg, $temp, $e.Out)

    Remove-Item $temp
}

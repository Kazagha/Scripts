$colItems = (Get-ChildItem \\dac-fs01\DWServer\dwtrain -recurse | Measure-Object -property length -sum) 
"{0:N2}" -f ($colItems.sum / 1MB) + " MB"

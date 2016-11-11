<#    
 # Author: Kazagha
 # 
 # The script requires FFMPEG (www.ffmpeg.com)
 #    
 # Download the NTFS Modules from the following location; https://gallery.technet.microsoft.com/scriptcenter/1abd77a5-9c0b-4a2b-acef-90dbb2b84e85 
 #
 # Extract to the following location; C:\Users\firstname.lastname\Documents\WindowsPowerShell\Modules\NTFSSecurity
 #>

# Set Variables

    # Location of the CSV
    $csv_file = 'C:\temp\ECM Directories\Users.csv'

    # Destination Directory (where the directories will be created)
    $out_dir = 'C:\temp\ECM Directories'

    # Error Log
    $err_file = 'C:\temp\ECM Directories\error.txt'

# Import the NTFS Security module 
    Import-Module NTFSSecurity
    
# Load the users CSV file 
    $users = Import-Csv $csv_file

# Begin Iterating through the users  
    foreach($u in $users)
    {  
        Write-Output ("Processing: {0}" -f ('WDRC\' + $u.UserName)) 

        TRY
        {   
            # Check that the user exists in AD                 
            Get-ADUser $u.UserName | Out-Null
                        
            # Set the Variables
            $dir_root = ("{0}\{1}\" -f $out_dir, $u.Directory)
            $dir_myFiles = ("{0}\{1}\{2}" -f $out_dir, $u.Directory, 'My Files')
            $dir_addToECM = ("{0}\{1}\{2}" -f $out_dir, $u.Directory, 'Add to ECM')
        
            # Create the Root Directory
            New-Item -ItemType Directory $dir_root | Out-Null

            # Change Permissions
            $usr = ('WDRC\' + $u.Username)
            Add-NTFSAccess -Path $dir_root -Account $usr -AccessRights FullControl

            # Create the directories
            New-Item -ItemType Directory $dir_myFiles | Out-Null
            New-Item -ItemType Directory $dir_addToECM | Out-Null
            
        } CATCH {
                    
            Add-Content -Value $u -Path $err_file
        
        }
   }

# Write the permissions out to file for review 
    Write-Output "Compiling permissions report"
    Get-ChildItem $out_dir | Get-NTFSAccess -ExcludeInherited | Export-Csv $out_dir\permissions.csv
 


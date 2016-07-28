<#
Title: Copy Script /w Environment Selection
Creator: Kazagha 
Creation Date: 26/07/2016
Current Version: 1.0
Edited: 

===============================================================

This script copies all files beginning with 'Super' from the Authority runtime 

===============================================================
#>

# Set Dynamic Vars
    
    $ScriptRoot = ($MyInvocation.MyCommand.Path | Split-Path | Resolve-Path).ProviderPath

# Prompt the user for input 
    
    $msg =  "
    --------------------------
        Select Environment
    --------------------------

        (1) LIVE
        (2) TEST
        (3) TRAIN
        (4) CONV
            "

    Write-Output $msg
    $auth_env_id = Read-Host 'Select'
    $auth_env = ""

    switch($auth_env_id)
        {
            1 { $auth_env = "live" }
            2 { $auth_env = "test" }
            3 { $auth_env = "train" }
            4 { $auth_env = "conv" }            
            default 
                { 
                    Write-Host "Invalid Option!"
                    exit
                }
        }   

# Set Source, Destination and Archive directories 

    $src_dir = "\\dir\" + $auth_env + "\dir\"   
    $dst_dir = $ScriptRoot + "\dest dir\"  
    $arcive_dir = $src_dir + '\' + (Get-Date).ToString("yyyy-MM-dd-HH-mm-ss")  
    
# Write Information to Console 

    $msg = (
"
    Selected Environment:     {0}
    Source Directory:         {1}
    Destination Directory:    {2}
    Number of files found:    {3}

"  -f $auth_env, $src_dir, $dst_dir, $files.Length )

    Write-Output $msg

# Fetch the files 

    $files = Get-ChildItem $src_dir -Filter 'Super*'

# Create the Destination and Archive Directory if required 

    IF ((Test-Path $dst_dir).Equals($false))
        {
            New-Item $dst_dir -ItemType Directory | Out-Null
        }

    New-Item  $arcive_dir -ItemType Directory | Out-Null

        
# Iterate through each file 
    foreach($f in $files) 
    {
        Write-Output ("    Copying file: {0}" -f $f.FullName)
        Copy-Item $f.FullName $dst_dir 
        #Move-Item $f.FullName $arcive_dir
    }     

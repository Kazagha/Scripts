#! /bin/bash

#Author: Kazagha
#Date: 31/12/2013
#Current Revision: 1.1

#Requirements
#googlecl; Google Command Line Tools - http://code.google.com/p/googlecl/
#sed; Stream EDitor - http://sed.sourceforge.net/
#   NOTE: sed is used to remove the directory path from the filenames.
#   In the below the /home/user/ path would be removed from the title.
#   Also removes the '.' from the beginning of hidden files,
#   which would ordinarily cause an error when uploading

#Change 'backup_folder' to match your google docs folder
#Remove the --folder switch if not required, --quiet shows only errors

export upload="google docs upload --folder backup_folder --quiet"

#Specify the files to backup

files="
/home/user/.hnb
/home/user/file_to_backup
"

echo "Google Docs Backup"

for f in $files
        do

        # Print the name of the file to screen
        echo " > Loading:" $(echo $f) | sed     \
                        -e s:\\.sh:: \
                        -e s:\\.:: \
                        -e s:\\/home\\/user\\/:: \
                        -e s:\\/path\\/to\\/backup\\/:: 

        # Upload the file to GoogleDocs
        $upload $f --title $(echo $f | sed -e s:\\.sh:: \
                        -e s:\\.:: \
                        -e s:\\/home\\/user\\/:: \
                        -e s:\\/path\\/to\\/backup\\/:: )
done

#! /bin/bash

#Author: Kazagha
#Date: 24/10/2013
#Current Revision: 1

#The below script uses youtube-dl
#For more information visit http://rg3.github.io/youtube-dl/

#Formats are specified with the -f switch, using the 'itag value'.
#For more information visit http://en.wikipedia.org/wiki/YouTube#Quality_and_codecs

#The output file/directory uses the built-in output templates -> %(title)
#For more information visit http://rg3.github.io/youtube-dl/documentation.html#d7

#Set the output directory
export output="-o /path/to/output/directory/%(uploader)s/%(title)s.%(ext)s -f 137/37/136/22"

#Set the youtube-dl command, if other switches are required
export download="youtube-dl"

#Input 
files="
http://www.youtube.com/watch?v=ABCDEFGHI_J
"

for f in $files
        do
        $download $output $f
        done

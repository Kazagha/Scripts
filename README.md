scripts
=======

A repository for various miscellaneous scripts

 	ffmpeg.bat
 	Simple wrapper script (Windows batch) to run ffmpeg over a list of files. 
 	  - Set list of files, input/output directory, settings and extension
 	  
 	googlecl-backup.sh
 	Simple wrapper (Linux bash) script that uploads a list of files to Google docs using googlecl. 
 	  - Removes the '.' from hidden files so they upload without errors (-e s:\\.:: \)
 	  - Removes .sh from bash scripts (-e s:\\.sh::)
 	  - Template for removing the file path from the title (-e s:\\/home\\/user\\/::)
 	  - pv for aesthetics; to remove pv delete code snippets '| pv -qL 10'.
 	  
 	youtube-download.sh
 	Simple wrapper (Linux bash) script to download a list of youtube videos
 	  - Add a list of videos
 	  - Set output file using built-in output templates (uploader/title)
 	  
 	  

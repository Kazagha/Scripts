@echo off

REM Author: Kazagha
REM Date: 24/10/2013
REM Current Revision: 1
REM 
REM The following script uses ffmpeg, which can be downloaded from www.ffmpeg.org

REM Location of ffmpeg
set ffmpeg=C:\directory\of\ffmpeg\ffmpeg.exe

REM Input directory, output directory
set input=C:\input\directory
set output=C:\output\directory

REM The settings that ffmpeg will use
REM -b:v is video quality
REM -b:a is audio quality
set settings=-acodec libfaac -b:a 128k -vcodec mpeg4 -b:v 1200k -flags +aic+mv4

REM Comma separated list of file names
REM NOTE: Filenames can contain spaces
    SET LIST=fileone.avi, filetwo.avi, filethree.avi

REM Black magic string manipulation;
REM Changes 'LIST' into something the for loop can work with
    SET LIST=ECHO %LIST:,=^^^&ECHO %

REM Loop though the list of files
    FOR /F "delims=" %%i IN ('%LIST%') DO (

      	ECHO =Converting %%i=

	%ffmpeg% -i "%input%\%%i" %settings% "%output%\%%i_converted.mp4"

    )

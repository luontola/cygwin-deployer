@echo off
cd "<%= @cygwin_home %>\bin"
ash /bin/rebaseall -v -T /rebaseall-filelist
echo.
pause
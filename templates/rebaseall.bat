@echo off
cd "<%= @cygwin_home %>\bin"
ash /bin/rebaseall -v -T /rebaseall-filelist.txt
echo.
echo. Rebase done. A reboot might still be needed.
echo.
pause

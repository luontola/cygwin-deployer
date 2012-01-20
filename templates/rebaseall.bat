@echo off
cd "<%= @cygwin_home %>\bin"
ash /bin/rebaseall -v -T /rebaseall-filelist.txt
echo.
echo Done. A reboot might still be needed.
echo If problems persist, try disabling ASLR:
echo   http://en.wikipedia.org/wiki/Address_space_layout_randomization#Microsoft_Windows
echo.
pause

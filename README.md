
Cygwin Deployer
===============

Automatically installs [Cygwin](http://www.cygwin.com/) using the latest installer into the directories `/config/paths.rb` with the packages `/config/packages.txt` and customizations `/templates/*`. Overwrites any files in `~/` with Cygwin's latest skeleton `/etc/skel` (after applying any customizations `/templates/home/*`). Adds "Open Bash Here" to the context menu of all files and directories in Explorer. Executes custom shell scripts `/config/[0-9]*.sh` to install programs that are not available in Cygwin. Provides a batch script for easily running [rebaseall](http://cygwin.wikia.com/wiki/Rebaseall).


Usage
-----

Use at your own risk. Don't ask for help. [RTFS](http://www.catb.org/jargon/html/R/RTFS.html).

Clone and customize. Start `cmd.exe` as Administrator. Run `deploy.bat`.


License
-------

Copyright © 2012 Esko Luontola <[www.orfjackal.net](http://www.orfjackal.net/)>  
This software is released under the Apache License 2.0.  
The license text is at <http://www.apache.org/licenses/LICENSE-2.0>

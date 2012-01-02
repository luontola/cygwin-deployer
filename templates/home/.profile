<%= include('/etc/skel/.profile') %>

# Start in specified directory (http://sources.redhat.com/ml/cygwin/2002-05/msg01645.html)
# Modifications also needed in cygwin.bat
if [ "$BASHHERE" != "" ]; then
  # remove surrounding quotes
  BASHHERE=$( echo $BASHHERE | tr -d \" )
  # convert Windows path to Unix path
  BASHHERE=$( cygpath "$BASHHERE" )
  # if a regular file, change to its directory
  if [ -f "$BASHHERE" ]; then
    BASHHERE=$BASHHERE/..
  fi
  cd "$BASHHERE"
fi

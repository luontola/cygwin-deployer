<%= include('/etc/skel/.bash_profile') %>

# Set PATH so it includes user's private bin if it exists
if [ -d "${HOME}/bin" ]; then
  PATH="${HOME}/bin:${PATH}"
fi

# Start in specified directory (http://sources.redhat.com/ml/cygwin/2002-05/msg01645.html)
# Modifications also needed in cygwin.bat
if [ "$BASH_HERE" != "" ]; then
  # remove surrounding quotes
  BASH_HERE=$( echo $BASH_HERE | tr -d \" )
  # convert Windows path to Unix path
  BASH_HERE=$( cygpath "$BASH_HERE" )
  # if a regular file, change to its directory
  if [ -f "$BASH_HERE" ]; then
    BASH_HERE=$BASH_HERE/..
  fi
  cd "$BASH_HERE"
fi

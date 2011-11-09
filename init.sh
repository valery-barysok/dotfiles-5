#!/bin/bash

##################################################
#                                                #
# Bootstrap the setup process.                   #
#                                                #
# Author: Nick Charlton <hello@nickcharlton.net> #
# Date: 09/11/11                                 #
# Version: 2.0                                   #
#                                                #
##################################################

directory=`pwd`

# call the right system setup script
# for Mac OS X
if [ "$(uname -s)" == 'Darwin' ]; then
	`$directory/_setup/osx.sh`
fi

# for Linux (this is enough, for now)
if [ "$(uname -s)" == 'Linux' ]; then
	`$directory/_setup/debian.sh`
fi

# then setup the symlinks
`$directory/_setup/symlinks.sh`
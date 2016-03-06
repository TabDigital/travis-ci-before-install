#!/bin/bash

# Check Travis setup
if [ -z $NPM_TOKEN ]; then
 echo "Please set NPM_TOKEN in Travis"
 exit 1
fi

# Now create the npmrc
# ...

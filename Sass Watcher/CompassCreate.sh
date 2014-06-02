#!/bin/sh

#  CompassCreate.sh
#  Sass Watcher
#
#  Created by Alex Seifert on 6/1/14.
#  Copyright (c) 2014 Alex Seifert. All rights reserved.

compass create $1 --sass-dir=$1 --css-dir=$1;
echo "Creating Compass project at " + $1;
#!/bin/bash

# Copyright (C) 2018 Mark D. Blackwell.
#   All rights reserved.
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

# See:
#   "How to run all tests with minitest?: answer", stackoverflow:
#   https://stackoverflow.com/a/31660885

# Run this script from the project directory.

#--------------

export airshows_location=test/fixture

export now_playing_basename=NowPlaying.xml

export now_playing_meta_basename=MetaNowPlaying.xml

export WideOrbit_file_location=test/var

ruby -I . test/qplaylist_runner_end_to_end_test.rb 0243

# ruby -I . -e "::Dir.glob('test/**/*_test.rb') {|f| require f}"

#!/bin/sh

# Copyright (C) 2018 Mark D. Blackwell.
#   All rights reserved.
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

# See:
#   "How to run all tests with minitest?: answer", stackoverflow:
#   https://stackoverflow.com/a/31660885

#--------------

ruby -I . -e "::Dir.glob('test/**/*_test.rb') {|f| require f}"

@echo off
rem Copyright (C) 2018 Mark D. Blackwell.
rem    All rights reserved.
rem    This program is distributed in the hope that it will be useful,
rem    but WITHOUT ANY WARRANTY; without even the implied warranty of
rem    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

rem See:
rem https://stackoverflow.com/a/31660885

rem #--------------
@echo on
ruby -I . -e "::Dir.glob('test/**/*_test.rb') {|f| require f}"

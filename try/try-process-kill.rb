# coding: utf-8

=begin
Copyright (C) 2018 Mark D. Blackwell.
   All rights reserved.
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
=end

begin
  pid = 12988
  p ::Process.kill 'KILL', pid
rescue ::Errno::ESRCH,     # Process ID not found
       ::RangeError,       # Process ID invalid (out of range?)
       ::Errno::EPERM => e # Privileges insufficient
  p 'error caught'
end

# coding: utf-8

=begin
Copyright (C) 2018 Mark D. Blackwell.
   All rights reserved.
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
=end

desc "The default is 'test:clean'"
task default: :'test:clean'

namespace :test do
  desc 'Clean up all test artifacts'
  task clean: %i[ clean_test_var ]

  desc 'Clean up test artifacts under test/var directory'
  task :clean_test_var do
    glob_var = "test/var/**"
    FileList.new(glob_var).each{|e| ::File.delete e unless ::File.directory? e}
  end
end

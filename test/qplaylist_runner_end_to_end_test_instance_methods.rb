# coding: utf-8

=begin
Copyright (C) 2018 Mark D. Blackwell.
   All rights reserved.
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
=end

require 'fileutils'
require 'my_file'

module ::QplaylistRunner
  class QplaylistRunnerEndToEndTest < QplaylistRunnerTest
    module InstanceMethods

      def test_end_to_end
        stub_things do
          reset_files
          load_and_run
          assert ! ::IO.read('test/var/process_ids.txt').chomp.empty?,                                     "\nprocess_ids.txt"
          assert   ::IO.read('test/var/log.txt').        end_with?("qplaylist-runner started 0243\n"),     "\nlog.txt"
          assert ::FileUtils.identical?('test/fixture/NowPlaying.xml',     'test/var/NowPlaying.xml'),     "\nNowPlaying.xml"

          fixture = air_time_strip ::IO.read('test/fixture/MetaNowPlaying.xml')
          var     = air_time_strip ::IO.read('test/var/MetaNowPlaying.xml')
          assert_equal fixture, var, "\nMetaNowPlaying.xml"
        end
        nil
      end

      private

      def air_time_regexp
        @@air_time_regexp ||= ::Regexp.new '<air_time>[0-9]{4,}</air_time>'
      end

      def air_time_strip(s)
        s.sub air_time_regexp, ''
      end

      def load_and_run
# Relative to the directory containing this Ruby script file:
        filename = ::File.join '..', 'lib', 'runner.rb'
        require_relative filename
        nil
      end

      def reset_files
        reset_files_var :basename_log
        reset_files_var :basename_now_playing
        reset_files_var :basename_now_playing_meta
        reset_files_var :basename_process_identifiers
        nil
      end

      def reset_files_var(method)
        basename = ::QplaylistRunner::MyFile.send method
# Relative to the shell's current directory:
        filename = ::File.join stub_directory_var, basename
        ::File.open(filename, 'w') {}
        nil
      end

      def stub_directory_songs
        'test/fixture'
      end

      def stub_directory_var
        'test/var'
      end

      def stub_things
        ::QplaylistRunner::  MyFile.stub :directory_songs, stub_directory_songs do
          ::QplaylistRunner::MyFile.stub :directory_var,   stub_directory_var   do
            yield
          end
        end
        nil
      end
    end
  end
end

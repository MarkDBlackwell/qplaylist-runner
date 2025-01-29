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
          assert ::FileUtils.identical?('test/fixture/NowPlaying.xml',     'test/var/NowPlaying.xml'),     "\nNowPlaying.xml"
          assert ::FileUtils.identical?('test/fixture/MetaNowPlaying.xml', 'test/var/MetaNowPlaying.xml'), "\nMetaNowPlaying.xml"
        end
      end

      private

      def directory_script_this
        ::Kernel.__dir__
      end

      def load_and_run
        filename = ::File.join '..', 'lib', 'runner.rb'
        require_relative filename
        nil
      end

      def reset_files
        filename = ::File.join 'test', 'var', 'log.txt'
        ::File.open(filename, 'w') {}
        nil
      end

      def stub_directory_songs
        'test/fixture'
      end

      def stub_directory_var
        'test/var'
      end

      def stub_filename_airshows
        'test/fixture/cart-numbers-airshows.txt'
      end

      def stub_filename_now_playing
        'test/var/NowPlaying.xml'
      end

      def stub_filename_now_playing_meta
        'test/var/MetaNowPlaying.xml'
      end

      def stub_things
        ::QplaylistRunner::      MyFile.stub :directory_songs,      stub_directory_songs      do
          ::QplaylistRunner::    MyFile.stub :directory_var,        stub_directory_var        do
            ::QplaylistRunner::  MyFile.stub :filename_airshows,    stub_filename_airshows    do
              ::QplaylistRunner::MyFile.stub :filename_now_playing, stub_filename_now_playing do
                yield
              end
            end
          end
        end
        nil
      end
    end
  end
end

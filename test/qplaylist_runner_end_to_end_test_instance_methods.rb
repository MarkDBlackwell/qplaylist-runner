# coding: utf-8

=begin
Copyright (C) 2018 Mark D. Blackwell.
   All rights reserved.
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
=end

require 'my_file'

module ::QplaylistRunner
  class QplaylistRunnerEndToEndTest < QplaylistRunnerTest
    module InstanceMethods

      def test_end_to_end
        stub_things do
#         flunk
        end
      end

      private

      def directory_fixture
        ::File.join directory_test, 'fixture'
      end

      def directory_test
        ::File.join MyFile.project_root, 'test'
      end

      def stub_directory_var
        ::File.join directory_test, MyFile.basename_var
      end

      def stub_filename_airshows
        ::File.join directory_fixture, MyFile.basename_airshows
      end

      def stub_filename_now_playing_in
        ::File.join directory_fixture, 'NowPlaying-in.XML.txt'
      end

      def stub_filename_now_playing_out
        ::File.join stub_directory_var, MyFile.basename_now_playing
      end

      def stub_things
        ::QplaylistRunner::      MyFile.stub :directory_var,            stub_directory_var            do
          ::QplaylistRunner::    MyFile.stub :filename_airshows,        stub_filename_airshows        do
            ::QplaylistRunner::  MyFile.stub :filename_now_playing_in,  stub_filename_now_playing_in  do
              ::QplaylistRunner::MyFile.stub :filename_now_playing_out, stub_filename_now_playing_out do
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

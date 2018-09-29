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
        ::File.join directory_test, 'var'
      end

      def stub_filename_airshows
        basename = 'cart-numbers-airshows.txt'
        ::File.join directory_fixture, basename
      end

      def stub_filename_log
        basename = 'log.txt'
        ::File.join stub_directory_var, basename
      end

      def stub_filename_now_playing_in
        basename = 'NowPlaying-in.XML'
        ::File.join directory_fixture, basename
      end

      def stub_filename_now_playing_out
        basename = MyFile.basename_now_playing
        ::File.join stub_directory_var, basename
      end

      def stub_things
        ::QplaylistRunner::        MyFile.stub :directory_var,            stub_directory_var            do
          ::QplaylistRunner::      MyFile.stub :filename_airshows,        stub_filename_airshows        do
            ::QplaylistRunner::    MyFile.stub :filename_log,             stub_filename_log             do
              ::QplaylistRunner::  MyFile.stub :filename_now_playing_in,  stub_filename_now_playing_in  do
                ::QplaylistRunner::MyFile.stub :filename_now_playing_out, stub_filename_now_playing_out do
                  yield
                end
              end
            end
          end
        end
        nil
      end
    end
  end
end

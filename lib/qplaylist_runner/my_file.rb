# coding: utf-8

=begin
Copyright (C) 2018 Mark D. Blackwell.
   All rights reserved.
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
=end

module ::QplaylistRunner
  module MyFile
    module ModuleMethods

      def directory_songs
        @@directory_songs ||= directory_var
      end

      def filename_airshows
        @@filename_airshows ||= begin
# Convert Windows backslashes to forward slashes:
          left = ::File.absolute_path ENV['airshows_location']
          ::File.join left, basename_airshows
        end
      end

      def filename_log
        @@filename_log ||= ::File.join directory_var, basename_log
      end

      def filename_now_playing
        @@filename_now_playing ||= ::File.join directory_wideorbit, basename_now_playing
      end

      def filename_now_playing_meta
        @@filename_now_playing_meta ||= ::File.join directory_wideorbit, basename_now_playing_meta
      end

      def filename_process_identifiers
        @@filename_process_identifiers ||= ::File.join directory_var, basename_process_identifiers
      end

      private

      def basename_airshows
        'cart-numbers-airshows.txt'
      end

      def basename_log
        'log.txt'
      end

      def basename_now_playing
        @@basename_now_playing ||= ENV['now_playing_basename']
      end

      def basename_now_playing_meta
        @@basename_now_playing_meta ||= ENV['now_playing_meta_basename']
      end

      def basename_process_identifiers
        'process_ids.txt'
      end

      def directory_var
        @@directory_var ||= ::File.join project_root, 'var'
      end

      def directory_wideorbit
# Convert Windows backslashes to forward slashes:
        @@directory_wideorbit ||= ::File.absolute_path ENV['WideOrbit_file_location']
      end

      def project_root
         @@project_root ||= ::File.realpath ::File.join('..', '..'), ::Kernel.__dir__
      end
    end

    extend ModuleMethods
  end
end

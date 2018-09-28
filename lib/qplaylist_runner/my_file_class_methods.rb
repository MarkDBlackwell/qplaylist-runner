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
    module ClassMethods

      def filename_airshows
        basename = 'cart-numbers-airshows.txt'
#       ::File.join 'Z:', 'Qplaylist', basename
        filename_var_within basename
      end

      def filename_log
        basename = 'log.txt'
        filename_var_within basename
      end

      def filename_now_playing_in
#       ::File.join 'Z:', basename_now_playing_in
        filename_var_within 'NowPlaying-in.XML'
      end

      def filename_now_playing_out
        basename = basename_now_playing_out
#       ::File.join 'Z:', basename
        filename_var_within basename
      end

      private

      def basename_now_playing_in
        basename_now_playing_wideorbit
      end

      def basename_now_playing_out
        basename_now_playing_wideorbit
      end

      def basename_now_playing_wideorbit
        'NowPlaying.XML'
      end

      def directory_script_this
        ::Kernel.__dir__
      end

      def directory_var
        ::File.join project_root, 'var'
      end

      def filename_var_within(basename)
        ::File.join directory_var, basename
      end

      def project_root
         @project_root_value ||= ::File.realpath ::File.join(*%w[..]*2), directory_script_this
      end
    end
  end
end

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

      def basename_now_playing
## Established by the Wideorbit company:
        'NowPlaying.XML'
      end

      def directory_var
        ::File.join project_root, 'var'
      end

      def filename_airshows
        basename = 'cart-numbers-airshows.txt'
#       ::File.join 'Z:', 'Qplaylist', basename
        ::File.join directory_var, basename
      end

      def filename_log
        basename = 'log.txt'
        ::File.join directory_var, basename
      end

      def filename_now_playing_in
#       ::File.join 'Z:', basename_now_playing
        ::File.join directory_var, 'NowPlaying-in.XML'
      end

      def filename_now_playing_out
        basename = basename_now_playing
#       ::File.join 'Z:', basename
        ::File.join directory_var, basename
      end

      def filename_playlist_in(basename)
        ::File.join directory_var, basename
      end

      def project_root
         @project_root_value ||= ::File.realpath ::File.join(*%w[..]*2), directory_script_this
      end

      private

      def directory_script_this
        ::Kernel.__dir__
      end
    end
  end
end

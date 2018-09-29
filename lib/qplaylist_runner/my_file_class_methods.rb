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

      def basename_airshows
        'cart-numbers-airshows.txt'
      end

      def basename_log
        'log.txt'
      end

      def basename_now_playing
## Set by the company, Wideorbit:
        'NowPlaying.XML'
      end

      def basename_var
        'var'
      end

      def directory_var
        ::File.join project_root, basename_var
      end

      def filename_airshows
        ::File.join 'Z:', 'Qplaylist', basename_airshows
      end

      def filename_log
        ::File.join directory_var, basename_log
      end

      def filename_now_playing_in
        ::File.join 'Z:', basename_now_playing
      end

      def filename_now_playing_out
        ::File.join 'Z:', basename_now_playing
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

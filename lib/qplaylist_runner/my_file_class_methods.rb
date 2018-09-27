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

      def basename_in
        basename_out
      end

      def basename_out
        'NowPlaying.XML'
      end

      def directory_script_this
        ::Kernel.__dir__
      end

      def directory_var
        ::File.join project_root, 'var'
      end

      def file_recreate_empty(filename)
        ::File.open(filename, 'w'){}
        nil
      end

      def filename_log
        basename = 'log.txt'
        ::File.join directory_var, basename
      end

      def filename_now_playing_in
#       ::File.join 'Z:', basename_in
        ::File.join Helper.directory_var, 'NowPlaying-in.XML'
      end

      def filename_out
#       ::File.join 'Z:', basename_out
        ::File.join Helper.directory_var, basename_out
      end

      def project_root
         @project_root_value ||= ::File.realpath ::File.join(*%w[..]*2), directory_script_this
      end

###Upward have been checked.

    end
  end
end

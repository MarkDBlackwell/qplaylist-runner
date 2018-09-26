# coding: utf-8

=begin
Copyright (C) 2018 Mark D. Blackwell.
   All rights reserved.
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
=end

module ::QplaylistRunner
  module Helper
    module ClassMethods

      def log_write(message)
        time = ::Time.now.strftime '%Y-%m-%d %H:%M:%S'
        basename = 'log.txt'
        filename = ::File.join directory_var, basename
        ::File.open filename, 'a' do |f|
          f.print "#{time} #{message}\n"
        end
      end

      private

      def directory_script_this
        ::Kernel.__dir__
      end

      def directory_var
        ::File.join project_root, 'var'
      end

      def project_root
         @project_root_value ||= ::File.realpath ::File.join(*%w[..]*2), directory_script_this
      end
    end
  end
end

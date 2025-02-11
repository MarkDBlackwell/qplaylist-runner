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
  module Helper
    module ModuleMethods

      def log_write(message)
        ::File.open MyFile.filename_log, 'a' do |f|
          f.print "#{time_log_string} #{message}\n"
        end
        nil
      end

      def process_identifier_self
        @@process_identifier_self ||= ::Process.pid
      end

      def whitespace_compress(s)
        s.strip.gsub whitespace_compress_regexp, ' '
      end

      private

      def time_log_string
        time_log = ::Time.now
        time_log.strftime '%Y-%m-%d %H:%M:%S'
      end

      def whitespace_compress_regexp
         @@whitespace_compress_regexp ||= ::Regexp.new '\s++'
      end
    end

    extend ModuleMethods
  end
end

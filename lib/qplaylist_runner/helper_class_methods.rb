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
    module ClassMethods

      def log_write(message)
        time = ::Time.now.strftime '%Y-%m-%d %H:%M:%S'
        ::File.open MyFile.filename_log, 'a' do |f|
          f.print "#{time} #{message}\n"
        end
      end

      def whitespace_compress(s)
        s.strip.gsub whitespace_compress_regexp, ' '
      end

      private

      def whitespace_compress_regexp
         @whitespace_compress_regexp_value ||= ::Regexp.new '\s++'
      end
    end
  end
end

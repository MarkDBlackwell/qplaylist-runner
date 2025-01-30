# coding: utf-8

=begin
Copyright (C) 2018 Mark D. Blackwell.
   All rights reserved.
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
=end

require 'helper'
require 'my_file'

module ::QplaylistRunner
  module SegmentsKill
    module ModuleMethods

      def run
        processes_kill
        process_identifiers_file_reset
        nil
      end

      private

      def process_identifiers
        process_identifiers_file_read.map(&:to_i).select {|e| e > 0}.reject {|e| Helper.process_identifier_self == e}
      end

      def process_identifiers_file_read
        filename = MyFile.filename_process_identifiers
        mode_handle_file_nonexistence = 'a+'
        ::File.open filename, mode_handle_file_nonexistence do |f|
          f.rewind
          f.readlines
        end
      end

      def process_identifiers_file_reset
        filename = MyFile.filename_process_identifiers
        ::File.open(filename, 'w') {}
        nil
      end

      def processes_kill
        process_identifiers.each do |pid|
          begin
            ::Process.kill signal_kill, pid
# Errno::EPERM means privilege error:
# Errno::ESRCH and RangeError mean invalid process ID:
          rescue \
              Errno::EPERM,
              Errno::ESRCH,
              RangeError
# Skip any process IDs which give these errors.
          end
        end
        nil
      end

      def signal_kill
        'KILL'
      end
    end
  end
end

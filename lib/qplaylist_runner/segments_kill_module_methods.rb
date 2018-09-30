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
        log_start
        processes_kill
        process_ids_file_reset
        nil
      end

      private

      def log_start
        Helper.log_write log_start_message
        nil
      end

      def log_start_message
        'qplaylist-runner-daemon-killer started'
      end

      def process_id_self
        @@process_id_self_value ||= ::Process.pid
      end

      def process_ids
        process_ids_file_read.map(&:to_i).select{|e| e > 0}.reject{|e| process_id_self == e}
      end

      def process_ids_file_read
        filename = MyFile.filename_process_identifiers
        mode_handle_file_nonexistence = 'a+'
        ::File.open filename, mode_handle_file_nonexistence do |f|
          f.rewind
          f.readlines
        end
      end

      def process_ids_file_reset
        filename = MyFile.filename_process_identifiers
        ::File.open filename, 'w' do |f|
          f.print "#{process_id_self}\n"
        end
        nil
      end

      def processes_kill
        process_ids.each do |pid|
          begin
            ::Process.kill signal_kill, pid
# Errno::EPERM means privilege error:
# Errno::ESRCH and RangeError mean invalid process ID:
          rescue \
              Errno::EPERM,
              Errno::ESRCH,
              RangeError => exception
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

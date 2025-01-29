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
  module Invoker
    module ModuleMethods

      def cartridge_number
        @@cartridge_number ||= ARGV[0]
      end

      def time_start
        @@time_start ||= ::Time.now
      end
    end
  end
end

# coding: utf-8

=begin
Copyright (C) 2018 Mark D. Blackwell.
   All rights reserved.
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
=end

require 'airshow'
require 'helper'
require 'my_file'

module ::QplaylistRunner
  module Airshows
    extend self

    def all
      @@all ||= airshows
    end

    def lookup(cartridge_number)
      no_airshow_found = ::Kernel.lambda {raise}
      all.find no_airshow_found do |airshow|
        airshow.cartridge_numbers.include? cartridge_number
      end
    end

    private

    def airshows
      lines_unfiltered = ::File.open(MyFile.filename_airshows, 'r') {|f| f.readlines}
      lines = lines_unfiltered.map {|e| Helper.whitespace_compress e}.reject {|e| e.empty? or e.start_with? '#'}
      result = lines.map {|e| Airshow.new e}.sort
      check result
      result
    end

    def check(airshows)
      all = airshows.map(&:cartridge_numbers).reduce :+
      raise unless all.length == all.uniq.length
      nil
    end
  end
end

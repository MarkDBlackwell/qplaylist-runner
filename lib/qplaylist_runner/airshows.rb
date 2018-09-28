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
      lines = ::File.open MyFile.filename_airshows do |f|
        f.readlines.map{|e| Helper.whitespace_compress e}.reject{|e| e.empty? or e.start_with? '#'}
      end
      lines.map{|e| Airshow.new e}.sort
    end
  end
end

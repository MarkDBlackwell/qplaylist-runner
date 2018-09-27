# coding: utf-8

=begin
Copyright (C) 2018 Mark D. Blackwell.
   All rights reserved.
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
=end

require 'helper'
require 'invoker'
require 'my_file'
require 'pp'
require 'song'

module ::QplaylistRunner
  module Segment
    module ClassMethods

      def run
        message = "qplaylist-runner-daemon started"
        Helper.log_write message
        file_default_recreate_empty
        a = nil # Predefine for block.
        ::File.open filename_in, 'r' do |f|
          a = f.readlines
        end
        lines = a.map{|e| e.chomp}.reject{|e| e.empty?}
        raise unless 0 == lines.length % 3
        songs_unsorted = []
        lines.each_slice 3 do |group|
          info = group.join "\n"
          songs_unsorted.push(Song.new info)
        end
        songs = songs_unsorted.sort
        songs.each do |song|
          time_running = ::Time.now
          time_song = Invoker.time_start + song.minute * 60 + song.second
          if time_song > time_running
            delay = time_song - time_running
            ::Kernel.sleep delay
          end
          ::File.open MyFile.filename_out, 'w' do |f|
            f.print song.xml_output
          end
        end
        nil
      end

      private

      def basename_default
        'input.txt'
      end

      def file_default_recreate_empty
        filename = ::File.join Helper.directory_var, basename_default
        MyFile.file_recreate_empty filename
        nil
      end

      def filename_in
        basename = case Invoker.cart_number
        when '0242'
          'young-at-heart-sat-1.txt'
        when '0243'
          'young-at-heart-sat-2.txt'
        when '0244'
          'young-at-heart-sat-3.txt'
        when '0021'
          'young-at-heart-sat-4.txt'
        else
          basename_default
        end
        ::File.join __dir__, basename
      end
    end
  end
end

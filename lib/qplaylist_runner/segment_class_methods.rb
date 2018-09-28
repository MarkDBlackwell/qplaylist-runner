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
        log_start
        songs.sort.each do |song|
          sleep song
          write song
        end
        nil
      end

      private

      def basename_default
        'nul:'
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

      def lines_containing_song_info
        lines_unfiltered = nil # Predefine for block.
        ::File.open filename_in, 'r' do |f|
          lines_unfiltered = f.readlines
        end
        result = lines_unfiltered.map{|e| e.chomp}.reject{|e| e.empty?}
        raise unless 0 == result.length % lines_per_song_standard
        result
      end

      def lines_per_song_standard
        3
      end

      def log_start
        Helper.log_write log_start_message
        nil
      end

      def log_start_message
        'qplaylist-runner-daemon started'
      end

      def sleep(song)
        time_song_start = Invoker.time_start + song.second + song.minute * 60
        delay = time_song_start - ::Time.now
        return if delay <= 0.0
        ::Kernel.sleep delay
        nil
      end

      def songs
        lines_containing_song_info.each_slice(lines_per_song_standard).map do |group|
          info = group.join "\n"
          Song.new info
        end
      end

      def write(song)
        ::File.open MyFile.filename_out, 'w' do |f|
          f.print song.xml_output
        end
        nil
      end
    end
  end
end

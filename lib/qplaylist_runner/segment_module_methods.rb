# coding: utf-8

=begin
Copyright (C) 2018 Mark D. Blackwell.
   All rights reserved.
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
=end

require 'airshows'
require 'helper'
require 'invoker'
require 'my_file'
require 'pp'
require 'song'

module ::QplaylistRunner
  module Segment
    module ModuleMethods

      def run
        log_start
        songs.sort.each do |song|
          sleep song
          write song
        end
        nil
      end

      private

      def basename_null_input
        'nul:'
      end

      def basename_playlist_in
        cartridge_number = Invoker.cart_number
        airshow = Airshows.lookup cartridge_number
        index = airshow.cartridge_numbers.find_index{|e| e == cartridge_number}
        basename = unless index
          basename_null_input
        else
          "#{airshow.name_show}-#{index.succ}.txt"
        end
      end

      def lines_containing_song_info
        filename = ::File.join MyFile.directory_var, basename_playlist_in
        lines_unfiltered = ::File.open filename, 'r' do |f|
          f.readlines
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
        sleep_kernel delay
        nil
      end

      def sleep_kernel(delay)
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
        ::File.open MyFile.filename_now_playing_out, 'w' do |f|
          f.print song.xml_output
        end
        nil
      end
    end
  end
end

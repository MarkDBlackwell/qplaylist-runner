# coding: utf-8

=begin
Author: Mark D. Blackwell (google me)
mdb April 22, 2018 - created
=end

require_relative 'song'
require 'pp'
require 'xmlsimple'

module ::QplaylistPrerecord
  module Impure
    class Run

      def self.run
        log_we_started
        recreate_empty_default_file
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
          time_song = time_start + song.minute * 60 + song.second
          if time_song > time_running
            delay = time_song - time_running
            ::Kernel.sleep delay
          end
          ::File.open filename_out, 'w' do |f|
            f.print song.xml_output
          end
        end
      end

      private

      def self.cart_number
        @@cart_number ||= relevant_hash['CutId'].first.strip
      end

      def self.default_basename
        'input.txt'
      end

      def self.filename_in
        basename = case cart_number
        when '0242'
          'young-at-heart-sat-1.txt'
        when '0243'
          'young-at-heart-sat-2.txt'
        when '0244'
          'young-at-heart-sat-3.txt'
        when '0021'
          'young-at-heart-sat-4.txt'
        else
          default_basename
        end
        ::File.join __dir__, basename
      end

      def self.filename_now_playing_in
        'Z:\NowPlaying.XML'
#       'NowPlaying-in.XML'
      end

      def self.filename_out
        'Z:\NowPlaying.XML'
#       'NowPlaying.XML'
      end

      def self.log_we_started
        dir = ::File.dirname __FILE__
        basename = 'log.txt'
        filename = ::File.join dir, basename

        message = "qplaylist-runner-daemon started"
        time = ::Time.now.strftime '%Y-%m-%d %H:%M:%S'

        ::File.open filename, 'a' do |f|
          f.print "#{time} #{message}\n"
        end
      end

      def self.recreate_empty_default_file
        filename = ::File.join __dir__, default_basename
        ::File.open(filename, 'w'){}
        nil
      end

      def self.relevant_hash
        @@relevant_hash ||= xml_tree['Events'].first['SS32Event'].first
      end

      def self.time_start
        @@time_start ||= ::Time.now
      end

      def self.xml_tree
# See http://xml-simple.rubyforge.org/
        @@xml_tree ||= XmlSimple.xml_in filename_now_playing_in, { KeyAttr: 'name' }
#puts @@xml_tree
#print @@xml_tree.to_yaml
#       @@xml_tree
      end
    end
  end
end

::QplaylistPrerecord::Impure::Run.run

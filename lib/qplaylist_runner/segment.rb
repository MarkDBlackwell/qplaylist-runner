# coding: utf-8

=begin
Author: Mark D. Blackwell (google me)
mdb April 22, 2018 - created
=end

require 'helper'
require 'my_file'
require 'pp'
require 'song'
require 'xmlsimple'

module ::QplaylistRunner
  class Segment

    def self.run
      message = "qplaylist-runner-daemon started"
      Helper.log_write message
      default_file_recreate_empty
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
        ::File.open MyFile.filename_out, 'w' do |f|
          f.print song.xml_output
        end
      end
    end

    private

    def self.basename_default
      'input.txt'
    end

    def self.cart_number
      @@cart_number ||= hash_relevant['CutId'].first.strip
    end

    def self.default_file_recreate_empty
      filename = ::File.join Helper.directory_var, basename_default
      MyFile.file_recreate_empty filename
      nil
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
        basename_default
      end
      ::File.join __dir__, basename
    end

    def self.hash_relevant
      @@hash_relevant ||= xml_tree['Events'].first['SS32Event'].first
    end

    def self.time_start
      @@time_start ||= ::Time.now
    end

    def self.xml_tree
# See http://xml-simple.rubyforge.org/
      @@xml_tree ||= XmlSimple.xml_in MyFile.filename_now_playing_in, { KeyAttr: 'name' }
#puts @@xml_tree
#print @@xml_tree.to_yaml
#     @@xml_tree
    end
  end
end

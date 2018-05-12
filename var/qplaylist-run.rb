# coding: utf-8

=begin
Author: Mark D. Blackwell (google me)
mdb April 22, 2018 - created
=end

require 'pp'

module ::QplaylistPrerecord
  module Impure
    class Run

      def self.run
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
            ::File.open filename_out, 'w' do |f|
              f.print song.xml_output
            end
          end
        end
      end

      private

      def self.filename_in
        'input.txt'
      end

      def self.filename_out
        'Z:\NowPlaying.XML'
#       'NowPlaying.XML'
      end

      def self.time_start
# Varies, by the show:
        ::Time.new 2018, 5, 12, 7, 0
#       ::Time.new 2018, 5, 11, 23, 47
      end
    end

    class Song

# Keep before attr_reader.
      def self.names
        %i[
            artist
            minute
            second
            title
            ]
      end

      attr_reader(*names)

      def initialize(song_info)
        lines = song_info.split "\n"
        raise unless 3 == lines.length
        time = (lines.at 0).split ' '
        raise unless 2 == time.length
        @minute, @second = time.map{|e| e.to_i}
        @artist, @title = (1..2).map{|i| (lines.at i).strip}
      end

      def xml_output
        [
            string_one,
            @title,
            string_two,
            @artist,
            string_three,
            "\n"
            ].join ''
      end

      def <=>(other)
        @minute * 60 + @second <=> other.minute * 60 + other.second
      end

      private

      def string_one
        <<HERE_STRING_ONE.chomp
<?xml version='1.0' encoding='ISO-8859-1'?>
<?xml-stylesheet type='text/xsl' href='NowPlaying.xsl'?>
<NowPlaying>
<Call>WTMD-FM</Call>
<Events>
<SS32Event pos='0' valid='true'>

<CatId>MUS</CatId>
<CutId>00PB</CutId>
<Type>SONG</Type>
<SecondsRemaining>  </SecondsRemaining>
<Title><![CDATA[
HERE_STRING_ONE
      end

      def string_two
        <<HERE_STRING_TWO.chomp
]]></Title>
<Artist><![CDATA[
HERE_STRING_TWO
      end

      def string_three
        <<HERE_STRING_THREE.chomp
]]></Artist>
<Intro>00</Intro>
<Len>04:57</Len>
<Raw><![CDATA[ ]]></Raw>

</SS32Event>
</Events>
</NowPlaying>
HERE_STRING_THREE
      end
    end
  end
end

::QplaylistPrerecord::Impure::Run.run

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
        filename_in = 'input.txt'
        a = nil # Predefine for block.
        ::File.open filename_in, 'r' do |f|
          a = f.readlines
        end
        lines = a.map{|e| e.chomp}.reject{|e| e.empty?}
#p 'lines='; pp lines
        raise unless 0 == lines.length % 3
        songs_unsorted = []
        lines.each_slice 3 do |group|
          info = group.join "\n"
          songs_unsorted.push(Song.new info)
        end
#print '(lines[0..2].join "\n")='; pp (lines[0..2].join "\n")
#print 'songs_unsorted.first='; pp songs_unsorted.first
#print 'songs_unsorted.first.artist='; pp songs_unsorted.first.artist
#print 'songs_unsorted.first.title='; pp songs_unsorted.first.title
#print 'songs_unsorted.first.minute='; pp songs_unsorted.first.minute
#print 'songs_unsorted.first.second='; pp songs_unsorted.first.second
        songs = songs_unsorted.sort
#print 'songs='; pp songs
        time_start = ::Time.new 2018, 4, 22, 16, 0
        songs.each do |song|
          time_running = ::Time.now
          time_song = time_start + song.minute * 60 + song.second
          if time_song > time_running
            delay = time_song - time_running
            ::Kernel.sleep delay
            filename_out = 'Z:\NowPlaying.XML'
            ::File.open filename_out, 'w' do |f|
              f.print song.xml_output
            end
          end
        end
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
#     attr_accessor(*names)
#     attr_accessor :artist

      def initialize(song_info)
        lines = song_info.split "\n"
#p 'lines='; pp lines
        raise unless 3 == lines.length
        time = (lines.at 0).split ' '
        raise unless 2 == time.length
        @minute, @second = time.map{|e| e.to_i}
        @artist, @title = (1..2).map{|i| (lines.at i).strip}
#print '@artist='; pp @artist
#print '@minute='; pp @minute
#print '@second='; pp @second
#print '@title='; pp @title
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
#print 'other='; pp other
#print 'other.minute='; pp other.minute
#print 'other.second='; pp other.second
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

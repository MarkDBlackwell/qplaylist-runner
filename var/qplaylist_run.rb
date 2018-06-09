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
=begin
Notes:
Regarding breaks (underwriting, etc.):

1. All are 1 minute, exactly.

1. A break happens before each segment, always (including the first).

However, neither the input and edit program, nor the runner program, need know about these break, because:

1. WideOrbit starts each segment after its preceding break is done.

As an exception:

1. Some DJs (e.g., Matt Galler) embed breaks in their airshow segments.

Therefore, when supplying their song start times, they must allow for these embedded breaks.

I.e., they must increment their song start times by the total duration of all preceding breaks.

For all segments, some program must ensure that no song starts within the first 20 seconds.

That program should be the runner.

This will prevent the song from overwriting the airshow name (or segment name) in the playlist.

The main Qplaylist program should pick up, from NowPlaying.XML, code 'SPL' (which stands for 'special') and the cart number (short for 'tape cartridge'), and then start the runner.

The cart numbers are a list. They cover the airshow's N segments, and never vary.

Those airshows, which regularly run twice, have two lists of cart numbers (which differ).

For N runs, there will be N differing lists.

A list of songs (artist, title, and start time) will be created in a file (a 'song-list file').

Each differing segment will have a separate song-list file.

The runner will read another file (a 'correspondence file'), which contains the correspondences between each cart number, and the filename of that song-list file.

The main Qplaylist program will pass the cart number to the runner.
=end

# Varies, by the airshow:
#       ::Time.new 2018, 5, 12, 7, 3   # Lisa Mathews
#       ::Time.new 2018, 6, 9, 7, 1, 0   # Lisa Mathews part 1 inexact
#       ::Time.new 2018, 6, 9, 7, 1, 52   # Lisa Mathews part 2
#       ::Time.new 2018, 6, 9, 7, 3, 42   # Lisa Mathews part 3
        ::Time.new 2018, 6, 9, 7, 4, 43   # Lisa Mathews part 4
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

# coding: utf-8

=begin
Copyright (C) 2018 Mark D. Blackwell.
   All rights reserved.
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
=end

module ::QplaylistRunner
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

    def <=>(other)
      @second + @minute * 60 <=> other.second + other.minute * 60
    end

    def xml_output_now_playing
      [
          fill_before_title_now_playing,
          @title,
          fill_before_artist_now_playing,
          @artist,
          fill_final_now_playing,
          "\n"
          ].join ''
    end

    def xml_output_now_playing_meta
      [
          fill_before_air_time_now_playing_meta,
          milliseconds_since_midnight,
          fill_before_title_now_playing_meta,
          @title,
          fill_before_artist_now_playing_meta,
          @artist,
          fill_final_now_playing_meta,
          "\n"
          ].join ''
    end

    private

    def fill_before_air_time_now_playing_meta
      <<HERE_FILL_BEFORE_AIR_TIME_NOW_PLAYING_META.chomp
<nowplaying>
<sched_time>00000000</sched_time>
<air_time>
HERE_FILL_BEFORE_AIR_TIME_NOW_PLAYING_META
    end

    def fill_before_artist_now_playing
      <<HERE_FILL_BEFORE_ARTIST_NOW_PLAYING.chomp
]]></Title>
<Artist><![CDATA[
HERE_FILL_BEFORE_ARTIST_NOW_PLAYING
    end

    def fill_before_artist_now_playing_meta
      <<HERE_FILL_BEFORE_ARTIST_NOW_PLAYING_META.chomp
</title>
<artist>
HERE_FILL_BEFORE_ARTIST_NOW_PLAYING_META
    end

    def fill_before_title_now_playing
      <<HERE_FILL_BEFORE_TITLE_NOW_PLAYING.chomp
<?xml version='1.0' encoding='ISO-8859-1'?>
<?xml-stylesheet type='text/xsl' href='NowPlaying.xsl'?>
<NowPlaying>
<Call>WTMD-FM</Call>
<Events>
<SS32Event pos='0' valid='true'>

<CatId>QPL</CatId>
<CutId>00PB</CutId>
<Type>SONG</Type>
<SecondsRemaining>  </SecondsRemaining>
<Title><![CDATA[
HERE_FILL_BEFORE_TITLE_NOW_PLAYING
    end

    def fill_before_title_now_playing_meta
      <<HERE_FILL_BEFORE_TITLE_NOW_PLAYING_META.chomp
</air_time>
<stack_pos></stack_pos>
<title>
HERE_FILL_BEFORE_TITLE_NOW_PLAYING_META
    end

    def fill_final_now_playing
      <<HERE_FILL_FINAL_NOW_PLAYING.chomp
]]></Artist>
<Intro>00</Intro>
<Len>04:57</Len>
<Raw><![CDATA[ ]]></Raw>

</SS32Event>
</Events>
</NowPlaying>
HERE_FILL_FINAL_NOW_PLAYING
    end

    def fill_final_now_playing_meta
      <<HERE_FILL_FINAL_NOW_PLAYING_META.chomp
</artist>
<trivia></trivia>
<category>MUS</category>
<cart>0000</cart>
<intro>0</intro>
<end></end>
<station>WTMD-FM</station>
<duration>180000</duration>
<media_type>SONG</media_type>
<milliseconds_left></milliseconds_left>
<Album></Album>
<Label></Label>
</nowplaying>
HERE_FILL_FINAL_NOW_PLAYING_META
    end

    def milliseconds_since_midnight
      now = ::Time.now
      midnight = ::Time.new now.year, now.month, now.mday
      clock = now - midnight.to_f
      seconds = clock.tv_sec
      subsecond_milliseconds = clock.tv_usec / 1000
      seconds * 1000 + subsecond_milliseconds
    end
  end
end

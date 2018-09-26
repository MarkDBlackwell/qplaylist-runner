# coding: utf-8

module ::QplaylistRunner
  class SegmentKill

    def self.run
      message = "qplaylist-runner-daemon-killer started"
      log_we_started message
    end

    private

    def self.log_we_started(message)
=begin
      dir = ::File.dirname __FILE__
      basename = 'log.txt'
      filename = ::File.join dir, basename

      time = ::Time.now.strftime '%Y-%m-%d %H:%M:%S'

      ::File.open filename, 'a' do |f|
        f.print "#{time} #{message}\n"
      end
=end
    end

  end
end

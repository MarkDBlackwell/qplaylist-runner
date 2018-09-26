# coding: utf-8

require 'helper'

module ::QplaylistRunner
  class SegmentKill

    def self.run
      message = "qplaylist-runner-daemon-killer started"
      Helper.log_write message
    end
  end
end

=begin
dir = ::File.dirname __FILE__
basename = 'log.txt'
filename = ::File.join dir, basename

message = "qplaylist-runner-daemon-killer started"
time = ::Time.now.strftime '%Y-%m-%d %H:%M:%S'

::File.open filename, 'a' do |f|
  f.print "#{time} #{message}\n"
end
=end

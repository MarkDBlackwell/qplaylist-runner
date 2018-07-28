begin
  pid = 12988
  p ::Process.kill 'KILL', pid
rescue ::Errno::ESRCH,     # Process ID not found
       ::RangeError,       # Process ID invalid (out of range?)
       ::Errno::EPERM => e # Privileges insufficient
  p 'error caught'
end

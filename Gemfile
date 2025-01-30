# coding: utf-8
source 'https://rubygems.org'

# For confining local variables to a small scope, see:
#   http://stackoverflow.com/a/27469713/1136063

def scope() yield end

# This is not being used.

# Which version of Ruby is running at WTMD?

scope do
  version_file = File.expand_path('../.ruby-version', __FILE__)
  ruby_version_required = ::File.open(version_file,'r'){|f| f.first.chomp}.prepend '='
#print 'Gemfile: ruby_version_required='; p ruby_version_required
  ruby                ruby_version_required,
      engine_version: ruby_version_required,
      engine:        'ruby',
      patchlevel: '319'
end

gem 'minitest', '5.4.3'

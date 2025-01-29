# coding: utf-8

=begin
Copyright (C) 2018 Mark D. Blackwell.
   All rights reserved.
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
=end

require_relative 'test_helper_minitest'
require 'pp'


def test_helper_supplement_load_path
  dirname_file_current = ::Kernel.__dir__
  project_root = ::File.join dirname_file_current, '..'

  test = ::File.join project_root, 'test'
  lib  = ::File.join project_root, 'lib'
  branches = [test, lib]

  package = 'qplaylist_runner'
  branches.push ::File.join lib, package

  branches.each do |branch|
    real = ::File.realpath branch
    $LOAD_PATH.unshift real unless $LOAD_PATH.include? real
  end
end

test_helper_supplement_load_path

module ::QplaylistRunner
  class QplaylistRunnerTest < ::Minitest::Test
  end
end

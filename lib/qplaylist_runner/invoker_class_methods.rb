# coding: utf-8

=begin
Copyright (C) 2018 Mark D. Blackwell.
   All rights reserved.
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
=end

require 'my_file'
require 'xmlsimple'

module ::QplaylistRunner
  module Invoker
    module ClassMethods

      def cart_number
        @@cart_number_value ||= hash_relevant['CutId'].first.strip
      end

      def time_start
        @@time_start_value ||= ::Time.now
      end

      private

      def hash_relevant
        @@hash_relevant_value ||= xml_tree['Events'].first['SS32Event'].first
      end

      def xml_tree
# See http://xml-simple.rubyforge.org/
        @@xml_tree_value ||= XmlSimple.xml_in MyFile.filename_now_playing_in, { KeyAttr: 'name' }
      end
    end
  end
end

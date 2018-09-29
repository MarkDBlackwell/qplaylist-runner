# coding: utf-8

=begin
Copyright (C) 2018 Mark D. Blackwell.
   All rights reserved.
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
=end

module ::QplaylistRunner
  class Airshow

    def self.fields_ordered
      %i[
        name_show
        cartridge_numbers
        ]
    end

    attr_reader :cartridge_numbers
    attr_reader :name_show

    def initialize(line)
      tokens =     line.split ' '
      @name_show = tokens.first
## Don't sort the cartridge numbers.
      @cartridge_numbers = tokens.drop name_show_token_count
      check tokens
      nil
    end

    private

    def cartridge_number_length_standard
      @@cartridge_number_length_standard_value ||= '0123'.length
    end

    def cartridge_number_regexp
      @@cartridge_number_regexp_value ||= ::Regexp.new '\A\d++\z', ::Regexp::MULTILINE
    end

    def check(     tokens)
      raise unless tokens.length > name_show_token_count
      @cartridge_numbers.each do |cart|
        raise unless cart.length == cartridge_number_length_standard
        raise unless cartridge_number_regexp =~ cart
      end
      nil
    end

    def name_show_token_count
      1
    end
  end
end

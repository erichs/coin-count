#!/usr/bin/env bundle exec ruby

require 'colorize'

class CoinCount
  attr_accessor :cents

  TYPES = {
    :quarters => 25,
    :dimes => 10,
    :nickels => 5,
    :pennies => 1
  }

  def initialize(cents=100)
    begin
      @cents = Integer(cents)
    rescue
      raise InvalidInput
    end
  end

  def change
    [{:pennies => @cents}]

  end

end

class InvalidInput < Exception; end

if __FILE__ == $0
  # this will only run if the script was the main, not load'd or require'd
  puts CoinCount.new( ARGV[0] ).name
end


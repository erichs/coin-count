#!/usr/bin/env bundle exec ruby

require 'colorize'

class CoinCount
  attr_accessor :cents, :change_array

  TYPES = {
    :quarters => 25,
    :dimes => 10,
    :nickels => 5,
    :pennies => 1
  }

  def initialize(cents=100)
    begin
      @cents = Integer(cents)
      @change_array = []
    rescue
      raise InvalidInput
    end
  end

  def change
    @change_array.push( {:pennies => @cents} )
    @change_array.push( {:nickels => Integer( @cents / 5 )} ) if @cents >= 5
    @change_array
  end

end

class InvalidInput < Exception; end

if __FILE__ == $0
  # this will only run if the script was the main, not load'd or require'd
  puts CoinCount.new( ARGV[0] ).name
end


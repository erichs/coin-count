#!/usr/bin/env bundle exec ruby

require 'colorize'

class CoinCount
  attr_accessor :cents, :change_array, :normal

  def initialize(cents=100, mode=:normal)
    begin
      @cents = Integer(cents)
      @change_array = []
      @mode = mode
    rescue
      raise InvalidInput
    end
  end

  def change
    make_change_and_descend(@cents, {:pennies => 0, :nickels => 0, :dimes => 0, :quarters => 0})
    @change_array.uniq
  end

  private

  def debug( str )
    puts str if @mode == :debug
  end

  def make_change_and_descend(remaining, change_hash)
    debug "make_change called with remaining: #{remaining}, hash: #{change_hash}"
    if remaining == 0
      debug "pushing leaf node: #{change_hash}"
      @change_array.push( change_hash )
      return
    end

    make_change_and_descend(remaining - 1, change_hash.merge(:pennies => change_hash[:pennies] + 1)) if remaining >= 1
    make_change_and_descend(remaining - 5, change_hash.merge(:nickels => change_hash[:nickels] + 1)) if remaining >= 5
    make_change_and_descend(remaining - 10, change_hash.merge(:dimes => change_hash[:dimes] + 1)) if remaining >= 10
    make_change_and_descend(remaining - 25, change_hash.merge(:quarters => change_hash[:quarters] + 1)) if remaining >= 25
  end
end

class InvalidInput < Exception; end

if __FILE__ == $0
  # this will only run if the script was the main, not load'd or require'd
  puts CoinCount.new( ARGV[0] ).name
end


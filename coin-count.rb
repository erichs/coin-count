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
    make_change_and_descend(@cents, {:pennies => 0, :nickels => 0, :dimes => 0, :quarters => 0})
    puts @change_array
    @change_array
  end

  private

  def make_change_and_descend(remaining, change_hash)
    puts "make_change called with remaining: #{remaining}, hash: #{change_hash}"
    if remaining == 0
      puts "pushing leaf node: #{change_hash}"
      @change_array.push( change_hash )
      return
    end
    nexthash = change_hash.clone.merge(:pennies => change_hash[:pennies] += 1)
    nextremaining = remaining - 1
    puts "pennies case: #{nextremaining}, #{nexthash}"
    if remaining >= 1
      puts "descending with #{nextremaining}, #{nexthash}"
      make_change_and_descend(nextremaining, nexthash)
    end

    nexthash = change_hash.clone.merge(:nickels => change_hash[:nickels] += 1)
    nextremaining = remaining - 5
    puts "nickels case: #{nextremaining}, #{nexthash}"
    if remaining >= 5
      puts "descending with #{nextremaining}, #{nexthash}"
      make_change_and_descend(nextremaining, nexthash)
    end

    nexthash = change_hash.clone.merge(:dimes => change_hash[:dimes] += 1)
    nextremaining = remaining - 10
    if remaining >= 10
      puts "descending with #{nextremaining}, #{nexthash}"
      make_change_and_descend(nextremaining, nexthash)
    end

    nexthash = change_hash.clone.merge(:quarters => change_hash[:quarters] += 1)
    nextremaining = remaining - 25
    if remaining >= 25
      puts "descending with #{nextremaining}, #{nexthash}"
      make_change_and_descend(nextremaining, nexthash)
    end
  end
end

class InvalidInput < Exception; end

if __FILE__ == $0
  # this will only run if the script was the main, not load'd or require'd
  puts CoinCount.new( ARGV[0] ).name
end


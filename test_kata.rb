require 'simplecov'
require 'turn/autorun'
require 'colorize'

SimpleCov.start do
  add_filter 'vendor'
end

require './coin-count'

describe CoinCount do
  it "makes change for 1 penny" do
    CoinCount.new(1).change.count.must_equal 1
  end

  it "makes change for 5 cents" do
    CoinCount.new(5).change.count.must_equal 2
  end

  it "makes change for 10 cents" do
    CoinCount.new(10).change.count.must_equal 4
  end

end

require 'simplecov'
require 'turn/autorun'
require 'colorize'

SimpleCov.start do
  add_filter 'vendor'
end

require './coin-count'

describe CoinCount do
  it "makes change for 1 penny" do
    CoinCount.new(1).change.must_equal [ { :pennies => 1 } ]
  end

end

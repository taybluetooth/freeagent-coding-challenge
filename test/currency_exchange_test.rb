# These are just suggested definitions to get you started.  Please feel
# free to make any changes at all as you see fit.


# http://test-unit.github.io/
require 'test/unit'
require 'currency_exchange'
require 'date'

class CurrencyExchangeTest < Test::Unit::TestCase
  def setup
  end

  def test_empty_date
    assert_raise StandardError do
      CurrencyExchange.rate(nil, "GBP", "USD")
    end
  end

  def test_empty_from_currency
    assert_raise StandardError do
      CurrencyExchange.rate(Date.new(2018,11,22), nil, "USD")
    end
  end

  def test_empty_to_currency
    assert_raise StandardError do
      CurrencyExchange.rate(Date.new(2018,11,22), "USD", nil)
    end
  end

  def test_unknown_exchange_rate
    assert_raise StandardError do
      CurrencyExchange.rate(Date.new(2018,11,22), "USD", "YAY")
    end
  end

  def test_non_base_currency_exchange_is_correct
    correct_rate = 1.287
    assert_equal correct_rate, CurrencyExchange.rate(Date.new(2018,11,22), "GBP", "USD")
  end

  def test_base_currency_exchange_is_correct
    correct_rate = 0.007
    assert_equal correct_rate, CurrencyExchange.rate(Date.new(2018,11,22), "JPY", "EUR")
  end
end

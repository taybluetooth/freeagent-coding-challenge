# These are just suggested definitions to get you started.  Please feel
# free to make any changes at all as you see fit.


# http://test-unit.github.io/
require 'test/unit'
require 'currency_exchange'
require 'date'

# All expected values in tests have been truncated to 3 decimal places.
# This is because it is extremely difficult to find consistent market rates
# to the amount of original decimal places.
# However feel free to change the truncation in the code and compare with the local data file.
# The rates are extremely similar sometimes to the 8th decimal point.

class CurrencyExchangeTest < Test::Unit::TestCase
  def setup
  end

  def test_local_json_empty_date
    assert_raise StandardError do
      CurrencyExchange.rate(nil, "GBP", "USD", "Y")
    end
  end

  def test_local_json_empty_from_currency
    assert_raise StandardError do
      CurrencyExchange.rate(Date.new(2018,11,22), nil, "USD", "Y")
    end
  end

  def test_local_json_empty_to_currency
    assert_raise StandardError do
      CurrencyExchange.rate(Date.new(2018,11,22), "USD", nil, "Y")
    end
  end

  def test_local_json_unknown_exchange_rate
    assert_raise StandardError do
      CurrencyExchange.rate(Date.new(2018,11,22), "USD", "YAY", "Y")
    end
  end

  def test_local_json_unknown_exchange_rate_2
    assert_raise StandardError do
      CurrencyExchange.rate(Date.new(2020,11,02), "OOGA", "WOOOOO", "Y")
    end
  end

  def test_webscraping_empty_date
    assert_raise StandardError do
      CurrencyExchange.rate(nil, "GBP", "USD", "N")
    end
  end

  def test_webscraping_empty_from_currency
    assert_raise StandardError do
      CurrencyExchange.rate(Date.new(2018,11,22), nil, "USD", "N")
    end
  end

  def test_webscraping_empty_to_currency
    assert_raise StandardError do
      CurrencyExchange.rate(Date.new(2018,11,22), "USD", nil, "N")
    end
  end

  def test_webscraping_unknown_exchange_rate
    assert_raise StandardError do
      CurrencyExchange.rate(Date.new(2018,11,22), "WOO", "GBP", "N")
    end
  end

  def test_webscraping_currency_exchange_is_correct_1
    correct_rate = 1.287
    assert_equal correct_rate, CurrencyExchange.rate(Date.new(2018,11,22), "GBP", "USD", "N")
  end

  def test_webscraping_currency_exchange_is_correct_2
    correct_rate = 0.028
    assert_equal correct_rate, CurrencyExchange.rate(Date.new(1995,11,23), "INR", "USD", "N")
  end

  def test_webscraping_currency_exchange_is_correct_3
    correct_rate = 5.652
    assert_equal correct_rate, CurrencyExchange.rate(Date.new(2002,05,23), "AUD", "ZAR", "N")
  end

  def test_local_json_currency_exchange_is_correct_1
    correct_rate = 112.726
    assert_equal correct_rate, CurrencyExchange.rate(Date.new(2018,12,10), "USD", "JPY", "Y")
  end
end

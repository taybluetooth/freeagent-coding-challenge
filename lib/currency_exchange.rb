module CurrencyExchange
  # Import JSON into module for parsing.
  require 'json'

  # Returns file_contents array containing parsed contents of JSON file.
  def self.get_file_contents()
    # Read JSON file and parse into a indexed data_hash array.
    file = File.read("data/eurofxref-hist-90d.json")
    file_contents = JSON.parse(file)

    return file_contents
  end

  # Returns a currency's value on a certain date.
  # Returns an exception if there is no date provided.
  # Returns an exception if there is no currency provided.
  def self.get_currency(date, currency)
    file_contents = get_file_contents

    date = date.to_s
    currency = currency.to_s

    currency = file_contents[date][currency]

    return currency
  end

  # Return the exchange rate between from_currency and to_currency on date as a float.
  # Raises an exception if unable to calculate requested rate.
  # Raises an exception if there is no rate for the date provided.
  def self.rate(date, from_currency, to_currency)
    puts "FreeAgent Foreign Exchange Rate Program."
    puts "Foreign Exchange Rate Between #{from_currency} and #{to_currency}."
    puts "Data Gathered #{date}."

    from_currency_val = get_currency(date, from_currency)
    to_currency_val = get_currency(date, to_currency)
    rate = to_currency_val / from_currency_val

    puts "#{from_currency}: #{from_currency_val}."
    puts "#{to_currency}: #{to_currency_val}."
    puts "Exchange Rate: #{rate}."

    return rate
  end

end

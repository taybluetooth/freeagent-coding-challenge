module CurrencyExchange
  # Import JSON into module for parsing.
  require 'json'
  # Import Pry into module for debugging purposes.
  require 'pry'
  # Import Nokogiri into module for HTML parsing.
  require 'nokogiri'
  # Import Open-Uri into module to make a get request to web page.
  require 'open-uri'

  # Returns current exchange rate from valuta exchange.
  def self.get_website_data()
    doc = Nokogiri::HTML(URI.open("https://www.xe.com/currencytables/?from=USD&date=2021-03-01"))
    # Extract table from parsed HTML.
    table = doc.css("table#historicalRateTbl")

    # Sift through all data entries in table selecting only currency code and exchange rate.
    data = table.css('tr').map do |row|
      row.xpath('./td').map(&:text)[0,3].join(' - ')
    end

    return data
  end

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
    webdata = get_current_exchange_rate()

    puts "#{from_currency}: #{from_currency_val}."
    puts "#{to_currency}: #{to_currency_val}."
    puts "Exchange Rate: #{rate}."
    puts "Data: #{webdata}"

    return rate
  end

end

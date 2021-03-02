module CurrencyExchange
  # Import JSON into module for parsing.
  require 'json'
  # Import Pry into module for debugging purposes.
  require 'pry'
  # Import Nokogiri into module for HTML parsing.
  require 'nokogiri'
  # Import Open-Uri into module to make a get request to web page.
  require 'open-uri'

  # Returns current exchange rate from XE exchange.
  def self.get_website_data(date, from_currency, to_currency)
    doc = Nokogiri::HTML(URI.open("https://www.xe.com/currencytables/?from=#{from_currency}&date=#{date}"))
    # Extract table from parsed HTML.
    table = doc.css("table#historicalRateTbl")
    exchange_rate = 0

    # Sift through all data entries in table and check against user input.
    data = table.css('tr').map do |row|
      # If the row selected contains the currency to be converted to, assign to exchange rate var.
      if row.xpath('./td').map(&:text)[0] == to_currency
        exchange_rate = row.xpath('./td').map(&:text)[2]
      end
    end

    # Check exchange rate exists and is not 0.
    unless exchange_rate == 0
      # Truncate exchange rate to 3 decimal places for testing purposes.
      exchange_rate = exchange_rate.to_f.truncate(3)

      return exchange_rate

    else
      raise StandardError.new "get_website_data: An exchange rate for the given currencies could not be found."
    end
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

    unless date.nil? || currency.nil?
      date = date.to_s
      currency = currency.to_s
      currency = file_contents[date][currency]
      return currency

    else
      raise StandardError.new "get_currency: Please make sure a date and currency have been provided."
    end
  end

  # Return the exchange rate between from_currency and to_currency on date as a float.
  # Will use internet source if argument specifies not to use local file.
  # Raises an exception if unable to calculate requested rate.
  # Raises an exception if there is no rate for the date provided.
  def self.rate(date, from_currency, to_currency, local)

    # Check all arguments are not empty.
    unless date.nil? || from_currency.nil? || to_currency.nil?

      # Use local file data if local variable equals 'Y'.
      unless local == "Y"
        web_rate = get_website_data(date, from_currency, to_currency)
      else
        from_currency_val = get_currency(date, from_currency)
        to_currency_val = get_currency(date, to_currency)
        rate = (to_currency_val / from_currency_val).truncate(3)
        return rate
      end

      # Check the exchange_rate is valid
      unless web_rate.nil?
        return web_rate
      else
        unless rate.nil?
          return rate
        else
          raise StandardError.new "rate: An exchange_rate could not be found for the given currencies"
        end
      end

    else
      raise StandardError.new "rate: Please make sure a date and 2 currencies to convert between have been provided."
    end
  end
end

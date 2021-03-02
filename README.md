# FreeAgent Coding Challenge

Thank you for your interest in the FreeAgent Coding Challenge.  This template is a barebones guide to get you started.  Please add any gems, folders, files, etc. you see fit in order to produce a solution you're proud of.

## Coding Challenge Instructions

Please see the INSTRUCTIONS.md file for more information.

## Your Solution Setup and Run Instructions

1. Ensure all dependencies and prerequisites predefined in the instructions are installed.
2. Install JSON gem using the following command:- gem install `json`.
3. Install Nokogiri gem using the following command:- gem install `nokogiri`.
4. Install gems into project using bundle:- `bundle install`.
5. Run all tests: - `bundle exec ruby test/run_tests.rb`.

### Syntax for running.

CurrencyExchange.rate([date], [currency to convert from], [currency to convert to], [use local file or not (Y/N)])

## Your Design Decisions

I decided to focus primarily on using a dynamic data source rather than focusing on allowing for different file formats. This is because user inputted files can have input errors or the data itself can be incorrect and unreliable.

To fix this, I made a webscraper that takes data from XE currency exchange, one of the world's most reliable foreign exchange sources. If the user does not wish to use local data, they can choose to use the web scraped data for any valid date, of which XE provides an extensive choice.

I added a significant amount of tests to account for things such as invalid dates, currencies and choices for using a local file. I also decided to truncate all exchange rates to the 3rd nearest decimal point. This is because not every data source provide the exact same rate to very specific decimal places, therefore I decided to use only up to the 3rd decimal place.

If I had more time, I would have created my own API to call from that would provide more data to show the user, such as the daily fluctuations of exchange rates and so on.

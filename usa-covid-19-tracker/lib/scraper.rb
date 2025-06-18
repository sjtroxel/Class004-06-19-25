require "nokogiri"
require "open-uri"
require "byebug"
require_relative 'country.rb'

module Scraper
  URL = "https://www.worldometers.info/coronavirus/country/us/"

  # extract USA info from page
    def self.extract_usa_data(doc)
      country_main = doc.css(".maincounter-number")
      usa_confirmed_cases = country_main[0].text.strip
      usa_deaths = country_main[1].text.strip
      usa_recovered = country_main[2].text.strip
      
      Country.new("USA", usa_confirmed_cases, usa_deaths, usa_recovered)
    end

  # extract states info from page
    def self.extract_states_data

    end

  # scrape data
    def self.scrape_data
      puts "Scraping data..."
      unparsed_page = URI.open(URL)
      doc = Nokogiri::HTML(unparsed_page)
      extract_usa_data(doc)
    end
end
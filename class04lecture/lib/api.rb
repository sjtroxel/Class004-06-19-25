require 'nokogiri'
require 'open-uri'
require 'json'

class API
  BASE_URL = "https://www.scrapethissite.com/pages/ajax-javascript/?ajax=true&year="

  def self.find_films_by_year(year)
    doc = Nokogiri::HTML(URI.open(BASE_URL + year))
     scraped_movies = JSON.parse(doc.text)

     if scraped_movies.empty?
      puts "Sorry, I couldn't find any Oscar winning films for #{year}."
     end

     scraped_movies.each do |movie|
      puts "| #{movie['title']} | #{movie['year']} | #{movie['nominations']} | #{movie['best_picture']}"
     end
  end
end
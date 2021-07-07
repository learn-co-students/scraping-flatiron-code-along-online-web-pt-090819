require 'pry'
require 'nokogiri'
require 'open-uri'

require_relative './course.rb'

class Scraper
  
  SITE = "http://learn-co-curriculum.github.io/site-for-scraping/courses"
  
  def get_page
    # site = "http://learn-co-curriculum.github.io/site-for-scraping/courses"
    html = open(SITE) # exposes the html on the website
    Nokogiri::HTML(html) # creating Nokogiri objects
  end
  
  def get_courses
    get_page.css(".posts-holder")
  end
  
  def make_courses
#    binding.pry
    get_courses.css("#course-grid.block") # 1) Need a new selector; 2) Iterate
    
    get_courses.css("h2"). each do |element|
      course = Course.new
      course.title = element.css("h2").text
      course.schedule = element.css("em").text
      course.description = element.css("p").text
    end
    # Create instances of Courses using the data
    
  end
  
  
  def print_courses
    self.make_courses
    Course.all.each do |course|
      if course.title && course.title != ""
        puts "Title: #{course.title}"
        puts "  Schedule: #{course.schedule}"
        puts "  Description: #{course.description}"
      end
    end
  end
  
end





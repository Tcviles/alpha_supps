require'pry'
require'open-uri'
require'nokogiri'

class AlphaSupps::CLI
  attr_accessor :categories

  def call
    AlphaScraper.scrape_sites
    supplement_types
    menu
  end

  def supplement_types
    puts "Welcome to Alpha Supplements!"
    puts "Here are the categories of products that we offer!", ""
    @categories = ["Pre-Workout", "Protein", "Amino Acids", "Fat Burner", "Other"]
    @categories.each.with_index(1){|category, i| puts "#{i}. #{category}!"}
    puts
  end

  def menu
    puts "Select the number of the category to see our products!!"
    puts "Or type 'phone', 'address', 'menu', or 'exit'"
    input = gets.strip
    puts
    if input.to_i > 0
      list = AlphaScraper.list_by_type("#{@categories[input.to_i-1]}")
      list.each.with_index(1) {|item, i| puts "#{i}. #{item.name} - #{item.type} - #{item.price}"}
      puts
      menu
    elsif input == "exit" || input == "exit!"
      goodbye
    elsif input == "phone"
      puts "Give us a call! (317)884-9521"
      puts ""
      menu
    elsif input == "address"
      puts "1984 E. Stop 13 Rd."
      puts "Indianapolis, IN 46227"
      puts ""
      menu
    elsif input == "menu"
      call
    else
      puts "IDK what you are talking about"
      call
    end
  end

  def goodbye
    puts "Thank you for shopping at Alpha Supplements!"
  end
end

require'pry'
require'open-uri'
require'nokogiri'

class AlphaSupps::CLI

  def call
    AlphaScraper.scrape_sites
    supplement_types
    menu
  end

  def supplement_types
    puts "Welcome to Alpha Supplements!"
    puts "Here are the categories of products that we offer!", ""
    puts "1. Pre-workouts"
    puts "2. Protein Powders"
    puts "3. Amino Acids"
    puts "4. Fat Burners"
    puts "5. Other", ""
  end

  def menu
    puts "Select the number of the category to see our products!!"
    puts "Or type 'phone', 'address', 'menu', or 'exit'"
    input = gets.strip
    puts
    case input
    when "1"
      list = AlphaScraper.list_by_type("Pre-Workout")
      list.each.with_index(1) {|item, i| puts "#{i}. #{item.name} - #{item.type} - #{item.price}"}
      puts
      menu
    when "2"
      list = AlphaScraper.list_by_type("Protein")
      list.each.with_index(1) {|item, i| puts "#{i}. #{item.name} - #{item.type} - #{item.price}"}
      puts""
      menu
    when "3"
      list = AlphaScraper.list_by_type("Amino Acids")
      list.each.with_index(1) {|item, i| puts "#{i}. #{item.name} - #{item.type} - #{item.price}"}
      puts""
      menu
    when "4"
      list = AlphaScraper.list_by_type("Fat Burner")
      list.each.with_index(1) {|item, i| puts "#{i}. #{item.name} - #{item.type} - #{item.price}"}
      puts ""
      menu
    when "5"
      list = AlphaScraper.list_by_type("Other")
      list.each.with_index(1) {|item, i| puts "#{i}. #{item.name} - #{item.type} - #{item.price}"}
      puts ""
      menu
    when "phone"
      puts "Give us a call! (317)884-9521"
      puts ""
      menu
    when "address"
      puts "1984 E. Stop 13 Rd."
      puts "Indianapolis, IN 46227"
      puts ""
      menu
    when /exit(!)?/
      goodbye
    when "menu"
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

require'pry'

class AlphaSupps::CLI
  attr_accessor :categories

  def call
    AlphaSupps::Products.scrape_sites
    supplement_types
    menu
  end

  def supplement_types
    puts "Welcome to Alpha Supplements!"
    puts "Here are the categories of products that we offer!", ""
    @categories = ["Pre-Workout", "Protein", "Amino Acids", "Fat Burner", "Other"]
    @categories.each.with_index(1){|item, i| puts "#{i}. #{item}!"}
    puts
  end

  def menu
    puts "Select the number of the category to see our products!!"
    puts "Or type 'phone', 'address', 'menu', or 'exit'"
    input = gets.strip
    puts
    if input.to_i.between?(1, categories.size)
      product_list = AlphaSupps::Products.list_by_type("#{categories[input.to_i-1]}")
      product_list.each.with_index(1) {|item, i| puts "#{i}. #{item.name} - #{item.type} - #{item.price}"}
      puts "", "What item would you like to learn more about?"
      puts "Or type 'menu' or 'exit' to go back"
      index = gets.strip
      index.to_i.between?(1, product_list.size) ? AlphaSupps::Products.get_info(product_list[index.to_i-1]) : nil
    elsif input == "all"
      AlphaSupps::Products.all.each.with_index(1){|item, i| puts "#{i}. #{item.name} - #{item.type} - #{item.price}"}
      puts
    elsif input == "phone"
      puts "Give us a call! (317)884-9521", ""
    elsif input == "address"
      puts "1984 E. Stop 13 Rd.", "Indianapolis, IN 46227", ""
    elsif input == "menu"
      call
    elsif input == "exit" || input == "exit!"
      puts "Thank you for shopping at Alpha Supplements!", ""
      exit
    else
      puts "IDK what you are talking about", ""
    end
  menu
  end
end

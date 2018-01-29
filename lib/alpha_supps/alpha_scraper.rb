require'pry'
require'open-uri'
require'nokogiri'

class AlphaScraper
  attr_accessor :type, :name, :price, :list

  def self.create_list(supplement)
    items = []
    puts "You picked #{supplement}!"
    puts ""
    product = self.new
    product.type = supplement
    product.name = 'Magnatude Mach 50'
    product.price = '$50'
    items << product
    items
  end

  def self.scrape_sites
    @list = []

    page_1 = Nokogiri::HTML(open('http://alphafitnesssupplements.net/shop/'))
    page_2 = Nokogiri::HTML(open('http://alphafitnesssupplements.net/shop/page/2/'))
    page_3 = Nokogiri::HTML(open('http://alphafitnesssupplements.net/shop/page/3/'))
    pages = [page_1, page_2, page_3]

    pages.each do |page|
      page.css("li.type-product").each do |product|
        item = self.new
        item.name = product.css("h2").text
        !product.css("span.amount")[0] ? item.price = "Call for price!" : item.price = product.css("span.amount")[0].text
        # item.price = product.css("span.amount").text
        if item.name.include?("Pre-Workout")||item.name.include?("Pump")
          item.type = "Pre-Workout"
        elsif item.name.include?("LB") || item.name.include?("Protein") || item.name.include?("Mass")
          item.type = "Protein"
        elsif item.name.include?("BCAA") || item.name.include?("Carnitine")||item.name.include?("Creatine")
          item.type = "Amino Acids"
        elsif item.name.include?("Thermogenic") || item.name.include?("Burner")
          item.type = "Fat Burner"
        else
          item.type = "Other"
        end
        @list<<item
      end
    end
    @list
  end

  def self.list_by_type(type)
    type_list = []
    @list.each do |item|
      if item.type == type
        type_list<<item
      end
    end
    type_list
  end

end

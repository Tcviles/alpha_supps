require'pry'
require'open-uri'
require'nokogiri'

class AlphaScraper
  attr_accessor :type, :name, :price, :list

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
          item.name.chomp!(" (Pre-Workout)")
          item.name.chomp!(" (Pump Powder)")
          item.type = "Pre-Workout"
        elsif item.name.include?("LB") || item.name.include?("Protein") || item.name.include?("Mass")
          item.name.chomp!(" (Protein Powder)")
          item.type = "Protein"
        elsif item.name.include?("BCAA") || item.name.include?("Carnitine")||item.name.include?("Creatine")
          item.type = "Amino Acids"
        elsif item.name.include?("Thermogenic") || item.name.include?("Burner")
          item.name.chomp!(" (Thermogenic)")
          item.type = "Fat Burner"
        else
          item.type = "Other"
        end
        @list<<item
      end
    end
  end

  def self.list_by_type(type)
    @list.select {|item| item.type == type}
  end
end

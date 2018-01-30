class AlphaSupps::Products
  attr_accessor :type, :name, :price, :list, :url

  @@all = []

  def self.all
    @@all
  end

  def self.scrape_sites
    page_1 = Nokogiri::HTML(open('http://alphafitnesssupplements.net/shop/'))
    page_2 = Nokogiri::HTML(open('http://alphafitnesssupplements.net/shop/page/2/'))
    page_3 = Nokogiri::HTML(open('http://alphafitnesssupplements.net/shop/page/3/'))
    pages = [page_1, page_2, page_3]

    pages.each do |page|
      page.css("li.type-product").each do |product|
        item = self.new
        item.name = product.css("h2").text
        item.url = product.css("a")[0]['href']
        !product.css("span.amount")[0] ? item.price = "Call for price!" : item.price = product.css("span.amount")[0].text

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
        @@all<<item
      end
    end
  end

  def self.list_by_type(type)
    @@all.select {|item| item.type == type}
  end

  def self.get_info(item)
    product_site = Nokogiri::HTML(open(item.url))
    if product_site.css("h2")[0].text== "Additional information"
      puts "","#{item.name}!", "Additional Information!", ""
      item_info = product_site.css("table.shop_attributes").text.delete!("\t").split("\n").reject {|c| c.empty?}
      item_info.each.with_index(0) {|info, i| item_info.index(info).odd? ? (puts "#{item_info[i-1]}. #{item_info[i]}") : nil}
      puts
    end
  end
end

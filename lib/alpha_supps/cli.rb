class AlphaSupps::CLI

  def call
    supplement_types
    menu
  end

  def supplement_types
    puts "Welcome to Alpha Supplements!"
    puts "1. Pre-workout"
    puts "2. Protein"
    puts "3. Aminos"
    puts "4. Fat Burner"
  end

  def menu
    puts "Select the number of the product youd like to shop!"
    input = gets.strip
    case input
    when "1"
      puts "BEAST MODE"
    when "2"
      puts "GET SWOLE!"
    when "3"
      puts "GUMMY BEARS!"
    when "4"
      puts "YOURE A FATTY!"
    when "exit"
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

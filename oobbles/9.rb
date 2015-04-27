password = "yup"
(1..3).each do
  puts "what's your deal? "
  guess = gets.chomp
  if guess == password
    puts "YOU WIN!"
    exit
  end
end
puts "YOU LOSE"

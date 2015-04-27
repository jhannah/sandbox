3.times do
  password = "Lisa"
  puts "Guess my password: "
  guess=gets.chomp
  if guess == password
    puts "Yes"
    break
  else
    puts "Guess again"
  end
end


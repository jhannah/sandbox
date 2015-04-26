moves = ["r", "p", "s"]
while true
  puts "yur move holmes"
  they = gets.chomp
  i = moves.sample
  puts "my move: #{i}"
  if they == "r"
    if i == "p"
      puts "you lose"
      break
    elsif i == "s"
      puts "you win"
      break
    end
  elsif they == "p"
    if i == "r"
      puts "you win"
      break
    elsif i == "s"
      puts "you lose"
      break
    end
  elsif they == "s"
    if i == "p"
      puts "you win"
      break
    elsif i == "r"
      puts "you lose"
      break
    end
  end
end

#(1..10).each do
#  puts moves.sample
#end





puts "yo, gimme a positive odd, fool"
STDOUT.flush
n = gets.to_i
if n > 0 && n % 2 == 1 
  puts "YAY"
else 
  puts "NOOOOOO"
end




puts "yo, gimme a positive odd, fool"
STDOUT.flush
n = gets.to_i
if n > 0 
  if n % 2 == 0 
    puts "that was even BOO #{n%2}"
  else 
    puts "odd. holla. #{n%2}"
  end
else 
  puts "that was negative. BOO"
end




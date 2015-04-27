puts "que es su numbre?"
STDOUT.flush
n = gets.to_i
if n > 0 and n < 11 
   puts "valid"
else 
   puts "invalid"
end


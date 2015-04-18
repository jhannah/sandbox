puts "que es su numbre 1?"
STDOUT.flush
n1 = gets.to_i
puts "que es su numbre 2?"
STDOUT.flush
n2 = gets.to_i
puts "que es su numbre 3?"
STDOUT.flush
n3 = gets.to_i

if n1 <= n2 and n1 <= n3
  print n1
  if n2 <= n3
    puts " #{n2} #{n3}"
  else
    puts " #{n3} #{n2}"
  end
elsif n2 <= n1 and n2 <= n3
  print n2
  if n1 <= n3
    puts " #{n1} #{n3}"
  else
    puts " #{n3} #{n1}"
  end
elsif n3 <= n1 and n3 <= n2
  print n3
  if n1 <= n2
    puts " #{n1} #{n2}"
  else
    puts " #{n2} #{n1}"
  end
end


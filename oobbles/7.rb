puts "yo, gimme an int, fool"
n = gets.to_i
(1..n).each do |x|
  if n % x == 0
    print "#{x} "
  end
end


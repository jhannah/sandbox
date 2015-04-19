puts "yo, gimme an int, fool"
n = gets.to_i
factx = Array.new
(1..n).each do |x|
  if n % x == 0
    factx.push x
  end
end
puts factx.join(" ")


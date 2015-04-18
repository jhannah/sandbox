(1..100).step(2) do |x|
  print "#{x} "
end
puts ""
(1..100).step(3) do |x|
  print "#{x} "
end
puts ""
puts "yo, gimme a step, fool"
n = gets.to_i
(1..100).step(n) do |x|
  print "#{x} "
end


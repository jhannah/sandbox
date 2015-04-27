module One
  class Fred
  end
  $f1 = :Fred
end
module Two
  Fred = 1
  $f2 = :Fred
end
# def Fred()
#end
$f3 = :Fred
puts $f1.object_id   #=> 2514190
puts $f2.object_id   #=> 2514190
puts $f3.object_id   #=> 2514190


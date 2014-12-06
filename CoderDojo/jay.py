import math, sys, time

def Fib(x):
   a = 1
   b = 1
   print a
   while (x > 0):
      x = x - 1
      a = a + b
      b = a + b
      print a, b


#Fib(7)

# Sawyer
# Wolf



a = 12379182371
b = a % 3












def Dev():
   i = 0
   while (1):
      i = i + 1
      print "i: ", i
      if (i % 3 == 0):
         print "            3"
      if (i % 4 == 0):
         print "            4"
      if (i % 5 == 0):
         print "            5"
      time.sleep(1)

#Dev()




def Dev2():
   i = 0
   while True:
      i = i + 1
      print "i: ", i
      counter = 0
      for j in range(2,i):
         if (i % j == 0):
            counter = counter + 1
            print "           ", j
      if (counter == 0):
            print "          P R I M E ! ! ! ! !"
      time.sleep(1)

Dev2()
 

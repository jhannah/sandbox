## http://www.thirdeyevis.com/pi-page-2.php
## Blink 3 LEDs

import RPi.GPIO as GPIO ## Import GPIO library
import time ## Import 'time' library. Allows us to use 'sleep'

GPIO.setmode(GPIO.BOARD) ## Use board pin numbering
GPIO.setup(7,  GPIO.OUT) ## Setup GPIO Pin 7 to OUT
GPIO.setup(11, GPIO.OUT)
GPIO.setup(12, GPIO.OUT)

##Define a function named Blink()
def Blink(numTimes,speed):
  for i in range(0,numTimes):## Run loop numTimes
    print "Iteration " + str(i+1)## Print current loop
    GPIO.output(7,True)## Switch on pin 7
    time.sleep(speed)
    GPIO.output(7,False)
    GPIO.output(11,True)
    time.sleep(speed)
    GPIO.output(11,False)
    GPIO.output(12,True)
    time.sleep(speed)
    GPIO.output(12,False)
    time.sleep(speed)
  print "Done" ## When loop is complete, print "Done"
  GPIO.cleanup()

## Ask user for total number of blinks and length of each blink
iterations = raw_input("Enter total number of times to blink: ")
speed = raw_input("Enter length of each blink(seconds): ")

## Start Blink() function. Convert user input from strings to numeric data types and pass to Blink() as parameters
Blink(int(iterations),float(speed))




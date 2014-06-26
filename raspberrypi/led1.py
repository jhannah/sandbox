## http://www.thirdeyevis.com/pi-page-2.php
## Turn on an LED

import RPi.GPIO as GPIO ## Import GPIO library
GPIO.setmode(GPIO.BOARD) ## Use board pin numbering
GPIO.setup(7, GPIO.OUT) ## Setup GPIO Pin 7 to OUT
GPIO.output(7,True) ## Turn on GPIO pin 7



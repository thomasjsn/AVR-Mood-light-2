'--------------------------------------------------------------
'                   Thomas Jensen | uCtrl.net
'--------------------------------------------------------------
'  file: AVR_MOOD_LAMP_2_v1.2
'  date: 14/09/2011
'--------------------------------------------------------------
$regfile = "m8def.dat"
$crystal = 1000000
Config Watchdog = 1024
Config Portb = Output
Config Portc = Input
Dim A As Byte , R As Integer , Fade As Integer

Config Timer1 = Pwm , Pwm = 8 , Prescale = 1 , Compare A Pwm = Clear Down , Compare B Pwm = Clear Down
Config Timer2 = Pwm , Prescale = 1 , Compare Pwm = Clear Up

'input switches not in use

Pwm1a = 0
Pwm1b = 0
Ocr2 = 0

'boot start blue LED
For A = 1 To 255
Incr Ocr2
Waitms 50
Next A

Do
Gosub random

'increase red
For A = 1 To 255
Incr Pwm1a
Waitms Fade
Next A

Gosub Random

'decrease blue
For A = 1 To 255
Decr Ocr2
waitms Fade
Next A

Gosub random

'increase green
For A = 1 To 255
Incr Pwm1b
waitms Fade
Next A

Gosub random

'decrease red
For A = 1 To 255
Decr Pwm1a
waitms Fade
Next A

Gosub random

'increase blue
For A = 1 To 255
Incr Ocr2
waitms Fade
Next A

Gosub random

'decrease green
For A = 1 To 255
Decr Pwm1b
waitms Fade
Next A

Loop
End

Random:
Fade = Rnd(450)                                             '450
Fade = Fade + 250                                           '250

Return
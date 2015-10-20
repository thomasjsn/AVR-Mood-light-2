'--------------------------------------------------------------
'                   Thomas Jensen | uCtrl.net
'--------------------------------------------------------------
'  file: AVR_MOOD_LAMP_2_v1.1
'  date: 14/03/2007
'--------------------------------------------------------------
$regfile = "m8def.dat"
$crystal = 1000000
Config Watchdog = 1024
Config Portb = Output
Config Portc = Input
Dim A As Byte , R As Integer , Speed As Integer , Fade As Integer , Random As Integer

Config Timer1 = Pwm , Pwm = 8 , Prescale = 1 , Compare A Pwm = Clear Up , Compare B Pwm = Clear Up
Config Timer2 = Pwm , Prescale = 1 , Compare Pwm = Clear Down

'input
'2. Stable time
'3. Fade speed
'4. Mode one/two color
'5. Stabile red

Ddrb.1 = 1
Ddrb.2 = 1
Ddrb.3 = 1

Pwm1a = 255
Pwm1b = 255
Ocr2 = 255

'boot start blue LED
For A = 1 To 255
Decr Ocr2
If Pinc.3 = 0 Then Waitms 5 Else Waitms 15
Next A

Gosub Switches

Main:
Do

If Pinc.4 = 0 Then Goto Flerfarget

'increase red, decrease blue
For A = 1 To 255
Decr Pwm1a
Incr Ocr2
Waitms Fade
Next A

Gosub Switches

'decrease red, increase green
For A = 1 To 255
Decr Pwm1b
Incr Pwm1a
Waitms Fade
Next A

Gosub Switches

'decrease green, increase blue
For A = 1 To 255
Decr Ocr2
Incr Pwm1b
Waitms Fade
Next A

Gosub Switches

If Pinc.4 = 1 Then Loop
If Pinc.4 = 0 Then Goto Flerfarget

Switches:
If Pinc.2 = 0 Then Speed = 500 Else Speed = 1000
If Pinc.3 = 0 Then Fade = 15 Else Fade = 30
If Pinc.5 = 0 Then

   Gosub Switches
   End If

Random = Rnd(speed)

For R = 1 To Random
Waitms 10
Next R

Return

Flerfarget:
Pwm1a = 255
Pwm1b = 255
'start blue
Ocr2 = 0
Do
If Pinc.4 = 1 Then
     Pwm1a = 255
     Pwm1b = 255
     Ocr2 = 0
     Goto Main
   End If

'increase red
For A = 1 To 255
Decr Pwm1a
Waitms Fade
Next A

Gosub Switches

'decrease blue
For A = 1 To 255
Incr Ocr2
Waitms Fade
Next A

Gosub Switches

'increase green
For A = 1 To 255
Decr Pwm1b
Waitms Fade
Next A

Gosub Switches

'decrease red
For A = 1 To 255
Incr Pwm1a
Waitms Fade
Next A

Gosub Switches

'increase blue
For A = 1 To 255
Decr Ocr2
Waitms Fade
Next A

Gosub Switches

'decrease green
For A = 1 To 255
Incr Pwm1b
Waitms Fade
Next A

Gosub Switches
Loop
End
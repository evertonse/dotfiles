# https://superuser.com/questions/1058474/increase-keyboard-repeat-rate-beyond-control-panel-limits-in-windows-10#1223508
# Set-ExecutionPolicy Unrestricted
Set-Location "HKCU:\Control Panel\Accessibility\Keyboard Response"

Set-ItemProperty -Path . -Name AutoRepeatDelay       -Value 180
# Set-ItemProperty -Path . -Name AutoRepeatDelay       -Value 200
Set-ItemProperty -Path . -Name AutoRepeatRate        -Value 30
Set-ItemProperty -Path . -Name DelayBeforeAcceptance -Value 0
Set-ItemProperty -Path . -Name BounceTime            -Value 0
Set-ItemProperty -Path . -Name Flags                 -Value 59
# Set-ItemProperty -Path . -Name Flags                 -Value 47

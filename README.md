This script, when set to run automatically or run manually, will email you your machine's visible IP, and also runs a reverse DNS lookup and GeoIP lookup on the IP.

1. Run command line as administrator (browse to c:\windows\system32, right-click on cmd.exe), run 'powershell'.
2. At powershell prompt, type "Set-ExecutionPolicy RemoteSigned" to allow your script to run
3. Put the script.ps1 somewhere safe/sane and add to either Task Scheduler (gui) or 'at' (Win 7) or 'schtasks' (Win 8)

Syntax for cronjob as follows: powershell.exe 'c:\scripts\script.ps1'

Note: It's preconfigured for Gmail. You may need to tweak settings, especially if you're getting authentication errors.
Note: Make sure you add your API key if you want to do geolocation on the IP.

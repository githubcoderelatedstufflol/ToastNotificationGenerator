# ToastNotificationGenerator
Generates toast notifications using PowerShell
### IMPORTANT!! READ THIS
```diff
- It seems my program is being flagged as a trojan. This is a false positive, if you're that scared, use the source code version instead.
```
# Usage
Just launch the application, and enter in anything in the parameters. Then click Generate.
# Source Code
If you haven't already done this, unblock the file.  
Using PowerShell: (assuming it's in your C drive's Downloads library)  
```powershell
Unblock-File -Path C:\Users\<REPLACE THIS WITH YOUR USER NAME>\Downloads\Untitled1.ps1
```
![image](https://github.com/githubcoderelatedstufflol/ToastNotificationGenerator/assets/90093071/0dd67b7d-f8f8-430a-8b6c-5ff4521029ea)

  
Using Explorer:  
  
![image](https://github.com/githubcoderelatedstufflol/ToastNotificationGenerator/assets/90093071/8944d90a-96f5-4b43-991f-ece709689942)  
Now just run the script. Make sure to add .\ so as to avoid PowerShell from yelling at you because Untitled1.ps1 isn't a valid cmdlet.  
```powershell
.\Untitled1.ps1
```
# Troubleshooting
The only thing that could go wrong here is threading. If the normal download doesn't work, try the one with MTA added after it.

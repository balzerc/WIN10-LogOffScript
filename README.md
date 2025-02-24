# WIN10-LogOffScript
This is a Windows 10 batch file that can be added to the Local group policy sign out that will clear credentials from various applications, such as Zoom, Office 2019, Teams etc.
This script is a work in progress, and may be changed to a powershell script in the future.

Enable this script for a local user by opening **Local Group Policy Editor** and navigating to **User Configuration > Windows Settings > Scripts (Logon/Logoff) > Logoff** as below:
![image](https://github.com/user-attachments/assets/4c0b36cc-afc8-443e-bc0e-8dcc6a0e942e)

Use the **Show Files** button to locate the folder location to store the batch file

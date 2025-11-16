[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
![GitHub followers](https://img.shields.io/github/followers/dorktoast?label=dorktoast)![Bluesky followers](https://img.shields.io/bluesky/followers/dorktoast.gib.games?label=dorktoast.gib.games)![YouTube Channel Subscribers](https://img.shields.io/youtube/channel/subscribers/UCKzyNJr9-1p55WJiYycgBjQ?label=@dorktoast)
# kill-adobe.bat
A Windows batch script that terminates common Adobe background processes (Adobe CEF Helper, CCXProcess, CoreSync, AGMService, AdobeIPCBroker, etc.) that often remain running after Adobe applications are closed.

**Sometimes, we are forced, often against our will, to use Adobe software.** Adobe applications are known for spawning many helper processes, some of which continue running even after the main program exits. This script locates and terminates those processes safely.

### Features
- Automatically elevates to Administrator if needed  
- Fetches an up-to-date process list from the repository (with built-in fallback)  
- Iteratively kills processes until no Adobe tasks remain  
- Displays randomized “fun” but factual Adobe criticisms
- 90's ASCII-art banner because **I CAN**  
- Lightweight, portable, no dependencies

---

## Download & Run

### Easy mode
You can simply download **kill-adobe.bat** and run it.

### **PowerShell**
```powershell
Invoke-WebRequest `
  -Uri "https://raw.githubusercontent.com/dorktoast/adobe-killer/main/kill-adobe.bat" `
  -OutFile "kill-adobe.bat"

.\kill-adobe.bat
```

**CMD:**

```cmd
curl -L -o kill-adobe.bat https://raw.githubusercontent.com/dorktoast/adobe-killer/main/kill-adobe.bat
kill-adobe.bat
```

**Wget:**

```bash
wget -O kill-adobe.bat https://raw.githubusercontent.com/dorktoast/adobe-killer/main/kill-adobe.bat
./kill-adobe.bat
```

## Process List

The script attempts to download the latest list of Adobe processes from `https://raw.githubusercontent.com/dorktoast/adobe-killer/main/processes-list.txt` . If the download fails (offline, firewall, etc.), it uses the built-in list.

## FAQ

### **Does this script break Adobe updates?**
No. The script only terminates _running processes_. It does **not** modify files, registry entries, services, or installers.  
If an Adobe updater is running at the moment you execute the script, it may be closed—but Adobe’s auto-updater will try again later on its own.

### **Can I use this on a work computer without admin rights?**
Usually not. Many Adobe background processes run with elevated or SYSTEM privileges, and a standard user cannot terminate them. The script auto-elevates for this reason.
In most workplace environments, users are also restricted from running arbitrary batch files or scripts, especially those that attempt to kill licensed software processes. Even if the script runs, only a subset of Adobe processes would be killable without admin rights.

### **Will this damage my Adobe installation?**
No. Killing background processes does **not** remove or corrupt any Adobe applications.  
At worst, you may need to relaunch a program if it was in the middle of something.

### **Is it safe to run this while an Adobe app is open?**
It won’t break anything, but expect the Adobe app to crash or close immediately.  
The script is intended for use _after_ you're done using Adobe software.

### **Will this interfere with Creative Cloud syncing or fonts?**
Only temporarily.  If you kill Adobe’s sync or licensing helpers, Creative Cloud will restart them automatically the next time you launch an Adobe app or the Creative Cloud desktop.

### **Does it delete anything?**
No. It only calls: `taskkill /IM <process> /F` . No file deletion, no configuration changes, nothing persistent.

### **Can Adobe get angry at me for using this?**
No. You are simply terminating processes on your own computer. This is normal system administration and completely within your rights.

### **Will Adobe just restart the processes anyway?**
Sometimes, yes. Creative Cloud has services that will self-restart later. This script is meant for freeing up RAM/CPU _right now_, not permanently disabling Adobe services.

### **Can I schedule this to run automatically?**
Yes. You can run it from Task Scheduler, a desktop shortcut, or even a startup script. Just keep in mind it will auto-elevate (triggering UAC) unless UAC is disabled or the task is set to “Run with highest privileges.”

<h1 align="center">Schooi's Multitool</h1>
<p align="center">The most powerful batchfile multitool ever made</p>
<p align="center"><img src="https://github.com/SchooiCodes/file_hosting/blob/main/SMT_v2.3_734x377.png"></p>
<p align="center">
	<img src="https://img.shields.io/github/languages/top/SchooiCodes/smt" alt="GitHub top language">
    <img src="https://img.shields.io/github/commit-activity/w/SchooiCodes/smt" alt="GitHub commit activity">
    <img src="https://img.shields.io/github/v/tag/SchooiCodes/smt" alt="GitHub Version">
	<img src="https://img.shields.io/github/commits-since/SchooiCodes/smt/latest" alt="GitHub commits since tagged version">
	<img src="https://img.shields.io/github/languages/code-size/SchooiCodes/smt" alt="GitHub code size in bytes">
    <img src="https://img.shields.io/github/downloads/SchooiCodes/smt/total" alt="GitHub Downloads (all assets, all releases)">
    <img src="https://img.shields.io/github/license/SchooiCodes/smt" alt="GitHub License">
</p>

About
-
Schooi's Multitool is a collection of over **130** self-made[^1] command line tools, that offer advanced OS-level functionality, tailored for everyday problems or needs.

Features
-

**You can find all the features [here](https://schooicodes.github.io/smtweb/features/index.html)**, including system administration and networking tools as well as general-use utilities, but here are some notable ones:
- Command Line Gradients Generator
- Bootable USB Creator
- FGRDown
- Private Folder Manager
- MegaTemp (Mega Account Manager)
- System Restore Points
- URL Shortener
- Minecraft Server Creator
- Schnuker, a discord bot :)
- Windows User management
- ~50 App installers + tricks
- Organized launcher interface
- Auto-updating system
- PATH implementation
- Fun Easter eggs and secret tools
- Various customization features

Compatibility
-
| Requirement | Minimum | Recommended |
| ----------- | ------- | ----------- |
| Windows Version | 7+ | 10+ |
| Disk Space | ~300kB needed for **just** SMT | size may vary based on usage |
| Network Availability | None | Connected |
| Powershell Version | 3.0 | 5.1 |

Installation
-
### Recommended Method
To install Schooi's Multitool, simply open Powershell as an Administrator and run one of the following commands:
```ps1
irm "https://smt.gleeze.com/" | iex
```
```ps1
irm "http://smt.farted.net/" | iex
```
```ps1
irm "http://getsmt.ftp.sh/" | iex
```
```ps1
irm "http://getsmt.us.to" | iex
```
([VirusTotal scan](https://www.virustotal.com/gui/file/77553494de93dfe8dec7986109f1cd93675d77d81969e1a8dabd3289b5f500a8)[^2] - [script contents](https://smt.gleeze.com/))

### Other Methods
#### Direct Installation
Download [the installer](https://github.com/SchooiCodes/smt/blob/main/Schooi's%20Multitool%20Setup.exe) directly.[^2]

#### Git
If you have Github Desktop or git installed, you can use `git` to clone the repo:

```
git clone https://github.com/SchooiCodes/smt
```

If you don't have git, check [this script](https://github.com/SchooiCodes/smt/blob/main/Files/Apps/git.bat) out.

Usage
-
### Utilities and Tools
Navigate through the SMT menu using numbers provided on-screen. Tools are organized by section. Various other sections exist as well, such as an installation info tab, a credits tab, and some subcategories.
Each tool can be ran standalone from the `Files` folder that exists in the SMT installation directory. (typical: `C:\Program Files\SMT\Files`)
You can also type `sc` in the main menu to view some secret commands! :)

### Command Line Arguments
All command line arguments can have `/` or `-`/`--` prepended to them. (`-` for short versions, `--` for normal versions)
```
Microsoft Windows [Version 10.0.26200.9168]
(c) Microsoft Corporation. All rights reserved.

C:\Program Files\SMT>SchooiMultitool.bat /d
C:\Program Files\SMT>SchooiMultitool.bat /debug
C:\Program Files\SMT>SchooiMultitool.bat -d
C:\Program Files\SMT>SchooiMultitool.bat --debug
```

| Command Line Arguments | Description |
| ---------------------- | ----------- |
| d / debug | Enters debug mode |
| h / help | Prints the help manual |
| rp / restore-point | Creates a system restore point |          
| s / sync | Syncs SMT files with the upstream repo to make sure they all exist |          
| 32 / system32 | Adds SMT to PATH (old, happens automatically) |
| pf / program-files | Adds SMT to `C:\Program Files` and creates a shortcut on the desktop (old, use [exe installer](https://github.com/SchooiCodes/smt/blob/main/Schooi's%20Multitool%20Setup.exe) instead)
| na / no-admin | Runs SMT without admin if it is installed in an admin folder (e.g. `C:\Program Files`) |

Contributing
-

Contributions to SMT are welcome! If you have any ideas for new features, improvements, or bug fixes, please open an issue or submit a pull request. See CONTRIBUTING.md (SOON) for more information on how to contribute.

License
-

SMT uses the MIT license, find more [here](https://github.com/SchooiCodes/smt/blob/main/LICENSE).

![Repobeats Analytics](https://repobeats.axiom.co/api/embed/f1c55495f7862d043d4f8ec42fa49c91704ca110.svg "Repobeats analytics image")

[^1]: A few tools are not made by me. The credits section in SMT includes all of them.
[^2]: The .exe installer made in NSIS gets flagged by many AVs, including Windows Defender, due to it downloading SMT's files. Many pieces of malware download .bat files, and are called "droppers", so AVs immediately flag anything that does the same. For that reason, use the commands or disable your antivirus instead.
<p align="center"><img src="https://github.com/SchooiCodes/file_hosting/blob/main/SMT_v2.3_734x377.png"></p>

<p align="center">
    <img src="https://img.shields.io/github/commit-activity/w/SchooiCodes/smt" alt="GitHub commit activity">
    <img src="https://img.shields.io/github/v/tag/SchooiCodes/smt" alt="GitHub Version">
    <img src="https://img.shields.io/github/downloads/SchooiCodes/smt/total" alt="GitHub Downloads (all assets, all releases)">
    <img src="https://img.shields.io/github/license/SchooiCodes/smt" alt="GitHub License">
</p>

# Schooi's Multitool

I AM NOT EVEN GOING TO LIE, this is the MOST POWERFUL batch multitool I **have ever seen**, let alone **MADE**. I swear, this is unbiased. 👀

Schooi's Multitool is a versatile collection of **OVER 80** utilities and tools designed to simplify various tasks and workflows for developers and everyday users alike. From IP Geolocation to .zip Password cracking, Schooi's Multitool offers a wide array of functionalities to streamline your work.

Features
-

- IP Geolocator
- SMB Bruteforcer
- Tweaking
- .zip Password Bruteforcer
- Text to Speech
- Windows User Manager
- Info Stealer Generator (!)
- Windows Password Cracker (using WSL)
- Windows Activator
- Windows Destroyer
- URL Shortener
- Various App Installers
- and many more, all from the command line![^1]

Compatibility
-

Schooi's Multitool is 100% compatible with Windows 10 and above. Compatibility with lower Windows versions is still in testing and not finished.

Installation
-
> [!NOTE]
> See a VirusTotal scan [here](https://www.virustotal.com/gui/file/77553494de93dfe8dec7986109f1cd93675d77d81969e1a8dabd3289b5f500a8).

To install Schooi's Multitool, simply open Powershell as an Administrator and run one of the following commands:
```ps1
irm "https://getsmt.duckdns.org/" | iex
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
(Recommended)

Alternatively, download [the latest release zip archive](https://github.com/SchooiCodes/smt/releases/latest) or [the installer](https://github.com/SchooiCodes/smt/blob/main/Schooi's%20Multitool%20Setup.exe)[^2].

If you have Github Desktop or git installed, you can use `git` to clone the repo:

```
git clone https://github.com/SchooiCodes/smt
```

If you don't have git, check [this script](https://github.com/SchooiCodes/smt/blob/main/Files/git.bat) out.

Usage
-

Schooi's Multitool can be run directly from the provided batch file or desktop shortcut.

For detailed usage instructions and command options, refer to the documentation (COMING SOON).

Contributing
-

Contributions to SMT are welcome! If you have any ideas for new features, improvements, or bug fixes, please open an issue or submit a pull request. See CONTRIBUTING.md (SOON) for more information on how to contribute.

License
-

SMT uses the MIT liscense, find more [here](https://github.com/SchooiCodes/smt/blob/main/LICENSE.md).

Acknowledgements
-

- SMT is built using Batch.
- If you plan on using this for any social media, please credit me. Read the [license](LICENSE.md) for more information
‎‎‎‎‎‎‎‎‎
‎

![Repobeats Analytics](https://repobeats.axiom.co/api/embed/f1c55495f7862d043d4f8ec42fa49c91704ca110.svg "Repobeats analytics image")

[^1]: You may notice that github says that 30% of this is in Python. That is not true. I wrote about 300 lines to make a Discord nukebot in python. It is more like 15%. The multitool itself and the tools are mostly written in Batch and Powershell.
[^2]: The .exe installer made in NSIS gets flagged by many AVs, including Windows Defender, due to it downloading SMT's files. Many pieces of malware download .bat files, and are called "droppers", so AVs immediately flag anything that does the same. For that reason, use the commands or disable your antivirus instead.
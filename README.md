# Resomonitor
## An open source resource monitor within Resonite
### Intended Use
Monitoring PC resources, most importantly of which being RAM and VRAM usage, from within Resonite. Because of the way this works, it will only work on Linux without significant modifications.  
This allows users with limited system resources to monitor how much RAM and VRAM is in use by the system, allowing them to exit resonite before it fills up the RAM and crashes the system.
### Default setup
- Updates local files every quarter of a second
- Pulls GPU data via the nvidia-settings command
- Pulls CPU data via the sensors command
- Pulls RAM usage via the free command
- Configured with two scripts: A script that starts the web server, and a script that updates local files, intended for use within Fedora Atomic Desktop (more specifically the Bazzite image).

### Setting up
  
Resomon has two sides, a web server, and a script to update the plaintext files within said web server. Resonite currently has no way to shell out and grab the sensor data itself, so it must pull from a web server on local host  
#### The web server
Any web server that will respond with plaintext will do.  
By default, the start script is configured for webfsd, running within a distrobox.  
The port the protoflux points to is 8225. Ensure that port is not in use by another process. **You do NOT need to forward this port. Doing so is NOT ADVISABLE, as it opens your home network to attack. I am not responsible for any network intrusions if you do this.**  
The start.sh script will, by default, start the server in the current directory. You can hardcode the directory if you wish by changing the value of the -R command line argument.
#### The sensor data
Use your text editor of choice to edit the monitor.sh script. The script runs in a loop, and uses awk, sed, and cut in order to isolate extracted data to just the raw numbers.
#### Resonite's side
This folder has premade flux that I use to create my system monitor on my context menu:  
resrec:///U-1VhHpnnRH9s/R-F0367F7DDCDEB7B0E01A8C495B8585CB01D216F399A5E19C0AACD02E9A41DF48
#### Modification
You are free to modify Resomonitor to suit your needs, but if you do publish it, ensure to credit me.  
A script to make modification easier is included, named "protomonitor.sh". Once you're finished making the command, you can drop it in monitor.sh's loop. Don't forget to pipe it to a file!

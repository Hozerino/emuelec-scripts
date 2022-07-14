# emuelec-scripts
Repository containing some custom EmuELEC scripts

Please note that this was not mass-tested and was only tested on EmuELECs installed in internal memory (not tested on EmuELECs booted by SDCard).

If you have the same console folder on both internal and an external drive, the script will prioritize the external fodler. For example:
Let's say you have the n64 folder on both places:
`internal/roms/n64` and `external/roms/n64`
the internal will be renamed to `internal/roms/n64_bkp` and a symbolic link called `internal/roms/n64` will be created, pointing to the external drive.

It is UNKNOWN what could happen if you have the same console folder on more than one external drive.

To run the scripts, save them as .sh files (example: folder_links.sh and clear_folder_links.sh) and leave them in "/emuelec/scripts". Open the user-scripts on your EmuELEC, run them and reboot the console.

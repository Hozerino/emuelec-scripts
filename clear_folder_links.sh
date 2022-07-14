#!/bin/bash
 
 
########################################
############## DISCLAIMER ##############
########################################
#This is an experimental script, this script will cleanup all symlinks inside "roms" folder (except for the bios folder) and restore all folders named like "name_bkp" to "name" without the "_bkp" suffix.
 
 
EXTERNAL_PATH="/var/media/*"
INTERNAL_PATH="/storage"
ROMS_SUFFIX="/roms"
# iterate through ROMS_PATH and delete symlinks
for file in "$INTERNAL_PATH"$ROMS_SUFFIX/*; do
    #echo "checking if [$file] is fucked up"
    # if file contains bios, skip
    if [[ $file == *"roms/bios"* ]]; then
        continue
    fi
 
    if [ -L "$file" ]; then
        echo "Deleting symlink: $file"
        rm "$file"
    fi
done
 
echo ""
echo "##################"
echo "CLEANING BACKUPS"
echo "##################"
echo ""
for console_folder in "$INTERNAL_PATH"$ROMS_SUFFIX/*; do
    # if file contains bios, skip
    if [[ $console_folder == *"_bkp" ]]; then
        echo "Folder is a backup folder [$console_folder]"
        new_name=${console_folder::-4}
        if [[ -d  $new_name ]]; then
                echo "Folder $new_name already exists, keeping backup"
                continue
        else
                echo "Renaming to $new_name"
                mv "$console_folder" "$new_name"
        fi
    fi
done
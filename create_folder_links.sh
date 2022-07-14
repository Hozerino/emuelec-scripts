#!/bin/bash


########################################
############## DISCLAIMER ##############
########################################
#This is an experimental script, it will scan all external drives (located on /var/media/*) and search a folder called "roms" inside it.
#However, if you have a n64 folder in your EmuELEC storage AND in a external drive, your internal folder will be renamed to n64_bkp and #the script will prioritize external folders.

#To cleanup all bakcups and restore the original folders, check the clear_folder_links.sh

#THIS SCRIPT WAS TESTED ON EMUELEC INSTALLED ON INTERNAL STORAGE. IT WAS NOT TESTED ON EMUELEC INSIDE SD_CARDs AND PENDRIVES!



EXTERNAL_DRIVES="/var/media"
INTERNAL_HD="/storage"
ROMS_FOLDER="/roms"

# iterate through ROMS_HD and delete symlinks
for console_folder in "$INTERNAL_HD"$ROMS_FOLDER/*/**; do
    # if file contains bios, skip
    if [[ $console_folder == *"roms/bios"* ]]; then
        echo "Skipping bios folder - $console_folder"
        continue
    fi

    if [[ -L $console_folder && -d  $console_folder ]]; then
        # if symlink exists, delete it
        echo "Deleting symlink: $console_folder"
        rm -f "$console_folder"
    fi
done

echo "######################"
echo "STARTING LINK CREATION"
echo "######################"

# iterate through files and create symlinks
for EXTERNAL_HD in $EXTERNAL_DRIVES/*; do
    echo "Checking for roms inside $EXTERNAL_HD"
    if [ ! -d "$EXTERNAL_HD$ROMS_FOLDER" ]; then
        echo "Directory $EXTERNAL_HD$ROMS_FOLDER DOES NOT exist, ignoring this external drive."
        continue
    fi
    for console_folder in "$EXTERNAL_HD$ROMS_FOLDER"/*; do
        # replace EXTERNAL with ROMS_HD
        link=${console_folder/$EXTERNAL_HD/$INTERNAL_HD}

        # if link doesn't exists, create it
        last_folder=$(basename "$console_folder")
        echo
        #$INTERNAL_HD$ROMS_FOLDER/$last_folder
        if [ -d "$link" ]; then
            echo "Folder $link exists on internal drive, creating a backup"
            mv $link $link"_bkp"
        fi
        if [ ! -f "$link" ]; then
            echo "Creating symlink: $console_folder -> $link"
            ln -s "$console_folder" "$link"
        fi
    done
done
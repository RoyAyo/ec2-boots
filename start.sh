#!/bin/bash

$BASEPROFILE="~/.config/google-chrome"

# update amazon-linux
sudo yum update -y amazon-linux-extras

function installchrome {
    echo "export APP_ENV=dev" >> /etc/environment
    echo "export TYPE_SERVER=AWS" >> /etc/environment
    sudo wget -y https://dl.google.com/linux/chrome/rpm/stable/x86_64/google-chrome-stable-110.0.5481.177-1.x86_64.rpm && yum localinstall -y google-chrome-stable-110.0.5481.177-1.x86_64.rpm    
    installdisplay
    createprofile $2
}

function installdisplay {
    # install dependency
    sudo yum install -y xorg-x11-server-Xvfb
    # copy current service script required to start service
    sudo cp Xvfb.service /etc/systemd/system/

    # Start Xvfb
    sudo systemctl enable Xvfb.service
    sudo systemctl start Xvfb.service
    Xvfb -ac :99 -screen 0 1280x1024x16 & export DISPLAY=:99
}

function createprofile {
    if [ $# -lt 2 ];
    then
        $PROFILENAME = "Roy"
    else
        $PROFILENAME = $2
    fi

    $DEFAULTPROFILE="$BASEPROFILE/Default"
    $NEWPROFILE="$HOME/chromeprofiles/$PROFILENAME"

    # Create a new directory for your profile
    mkdir -p $NEWPROFILE

    # copy contents of default profile into new profile 
    cp -r "$DEFAULTPROFILE/." "$NEWPROFILE"

    cat "$BASEPROFILE/Preferences"  | \
    jq ".profile.name=\"$PROFILENAME\"" > "$NEWPROFILE/Preferences" 

    google-chrome --user-data-dir="$NEWPROFILE"
}

installchrome $2
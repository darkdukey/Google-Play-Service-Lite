#!/bin/sh

#
# Pack Google Play Services >= 30 in one jar file
#

#
# Author: Jimmy Yin (jimmy.yin5@gmail.com)
#

#INSERT HERE YOUR ANDROID SDK PATH
if [ -z ${ANDROID_SDK_ROOT+x} ];
    then echo "failed to find ANDROID_SDK_ROOT, please set it to your android sdk path";
else echo "ANDROID_SDK_ROOT is set to '$ANDROID_SDK_ROOT'";
fi

# ANDROID_SDK_ROOT=/Users/Astrovic/Dati/Applicazioni/android-sdk

PLAY_SERVICES_PATH=$ANDROID_SDK_ROOT/extras/google/m2repository/com/google/android/gms
PLAY_SERVICES_VERSION=11.0.0

PLAY_SERVICES_FILENAME="google-play-services.jar"
PLAY_SERVICES_TEMP_DIR="google-play-services-temp"
PLAY_SERVICES_STRIP_FILE="gms_lite.conf"
PLAY_SERVICES_NESTED_PATH="com/google/android/gms"
PLAY_SERVICES_OUTPUT_FILE="google-play-services-full.jar"

pack_gms() {
    echo ""
    echo "Packing google play services from " + $PLAY_SERVICES_PATH + "..."
    echo ""

    PLAY_SERVICES_STRIP_FILE=$1
    PLAY_SERVICES_OUTPUT_FILE=$2

    # Check if file exists in the same directory
    if [ ! -d $PLAY_SERVICES_PATH ]; then
        echo "\nPlease config $ANDROID_SDK_ROOT, then run it again\n\n"
        exit -1
    fi

    # Preventive cleanup
    rm -rf $PLAY_SERVICES_TEMP_DIR

    # Create temporary work folder
    mkdir $PLAY_SERVICES_TEMP_DIR
    cd $PLAY_SERVICES_TEMP_DIR

    # If the configuration file doesn't exist, create it
    if [ ! -f ../$PLAY_SERVICES_STRIP_FILE ]; then
        # Create the file
        touch ../$PLAY_SERVICES_STRIP_FILE
        FOLDERS=`ls $PLAY_SERVICES_PATH`
        for index in $FOLDERS
        do
            echo "$index=true" >> ../$PLAY_SERVICES_STRIP_FILE
        done

        sed "1d" ../$PLAY_SERVICES_STRIP_FILE > ../$PLAY_SERVICES_STRIP_FILE.bak
        sed "s/play-services-//g" ../$PLAY_SERVICES_STRIP_FILE.bak > ../$PLAY_SERVICES_STRIP_FILE
    fi

    # Read configuration from file
    while read -r FOLDERS
    do
        CURRENT_FOLDER=$FOLDERS
        CURRENT_FOLDER_NAME=`echo $CURRENT_FOLDER | awk -F'=' '{print $1}'`
        CURRENT_FOLDER_ENABLED=`echo $CURRENT_FOLDER | awk -F'=' '{print $2}'`

        if [ "$CURRENT_FOLDER_ENABLED" = true ]; then
            ARR_FILE=$PLAY_SERVICES_PATH/play-services-$CURRENT_FOLDER_NAME/$PLAY_SERVICES_VERSION/play-services-$CURRENT_FOLDER_NAME-$PLAY_SERVICES_VERSION.aar

            echo "Extracting " $CURRENT_FOLDER_NAME
            if [ -f $ARR_FILE ]; then
                unzip $ARR_FILE -d $CURRENT_FOLDER_NAME      > /dev/null
            fi
            if [ -f $CURRENT_FOLDER_NAME/classes.jar ]; then
                jar xvf $CURRENT_FOLDER_NAME/classes.jar     > /dev/null
            fi
            echo "Extracting Done."
        else
            echo "Skip extracting " $CURRENT_FOLDER_NAME
        fi
    done < ../"$PLAY_SERVICES_STRIP_FILE"

    # Create final stripped JAR
    jar cf $PLAY_SERVICES_OUTPUT_FILE com/
    cp $PLAY_SERVICES_OUTPUT_FILE ../
    cd ..

    # Clean up
    echo "\nFolders removed, cleaning up.."
    rm -rf $PLAY_SERVICES_TEMP_DIR
    rm -fr $PLAY_SERVICES_STRIP_FILE.bak
}

main() {
    pack_gms "gms_full.conf" "google-play-services-full.jar"
    rm -fr "gms_full.conf"
    pack_gms "gms_lite.conf" "google-play-services.jar"

    echo "All done, exiting!"
    exit 0
}

main

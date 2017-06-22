#!/bin/sh

#
# Pack Google Play Services >= 30 in one jar file
#

#
# Author: Jimmy Yin (jimmy.yin5@gmail.com)
#

FIREBASE_PATH=$ANDROID_SDK_ROOT/extras/google/m2repository/com/google/firebase
FIREBASE_VERSION=11.0.0

FIREBASE_FILENAME="firebase.jar"
FIREBASE_TEMP_DIR="firebase-temp"
FIREBASE_STRIP_FILE="firebase-config.conf"
FIREBASE_NESTED_PATH="com/google/android/gms"
FIREBASE_OUTPUT_FILE="firebase.jar"

pack_gms() {
    echo ""
    echo "Packing google firebase ..."
    echo ""

    FIREBASE_STRIP_FILE=$1
    FIREBASE_OUTPUT_FILE=$2

    # Check if file exists in the same directory
    if [ ! -d $FIREBASE_PATH ]; then
        echo "\nPlease config $ANDROID_SDK_ROOT, then run it again\n\n"
        exit -1
    fi

    # Preventive cleanup
    rm -rf $FIREBASE_TEMP_DIR

    # Create temporary work folder
    mkdir $FIREBASE_TEMP_DIR
    cd $FIREBASE_TEMP_DIR

    # If the configuration file doesn't exist, create it
    if [ ! -f ../$FIREBASE_STRIP_FILE ]; then
        # Create the file
        touch ../$FIREBASE_STRIP_FILE
        FOLDERS=`ls $FIREBASE_PATH`
        for index in $FOLDERS
        do
            echo "$index=true" >> ../$FIREBASE_STRIP_FILE
        done

        sed "1d" ../$FIREBASE_STRIP_FILE > ../$FIREBASE_STRIP_FILE.bak
        sed "s/firebase-//g" ../$FIREBASE_STRIP_FILE.bak > ../$FIREBASE_STRIP_FILE
    fi

    # Read configuration from file
    while read -r FOLDERS
    do
        CURRENT_FOLDER=$FOLDERS
        CURRENT_FOLDER_NAME=`echo $CURRENT_FOLDER | awk -F'=' '{print $1}'`
        CURRENT_FOLDER_ENABLED=`echo $CURRENT_FOLDER | awk -F'=' '{print $2}'`

        if [ "$CURRENT_FOLDER_ENABLED" = true ]; then
            ARR_FILE=$FIREBASE_PATH/firebase-$CURRENT_FOLDER_NAME/$FIREBASE_VERSION/firebase-$CURRENT_FOLDER_NAME-$FIREBASE_VERSION.aar

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
    done < ../"$FIREBASE_STRIP_FILE"

    # Create final stripped JAR
    jar cf $FIREBASE_OUTPUT_FILE com/
    cp $FIREBASE_OUTPUT_FILE ../
    cd ..

    # Clean up
    echo "\nFolders removed, cleaning up.."
    rm -rf $FIREBASE_TEMP_DIR
    rm -fr $FIREBASE_STRIP_FILE.bak
}

main() {
    pack_gms "firebase_full.conf" "firebase-full.jar"
    #rm -fr "firebase_full.conf"

    echo "All done, exiting!"
    exit 0
}

main

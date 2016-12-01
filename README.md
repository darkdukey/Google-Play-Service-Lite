# Google Play Service Lite

## Intro
This script is for eclipse/ant user who has problem building their android app because of the 65535 methods limit

In a word, if you encountered a `Unable to execute dex: method ID not in [0, 0xffff]: 65536` error, this is for you.

> Note: For gradle/android studio users, google has posted a fix [here](http://developer.android.com/intl/ru/tools/building/multidex.html)

It contains a original copy of google play serivce 10.0.1(v38), which can be customized based on your project

## How to update full Google Play Service Package
1. edit `pack_gms.sh` and insert your `ANDROID_SDK_ROOT` and the `PLAY_SERVICES_VERSION` (it must be available in `$ANDROID_SDK_ROOT/extras/google/m2repository/com/google/android/gms/play-services`)
2. run `pack_gms.sh`
3. done, you have a new `google-play-services.jar` with `PLAY_SERVICES_VERSION` chosen version
4. you can customize it with a lite strip version, enabling/disabling the services you want, using the following instructions

## How to customize your own Google Play Service Package
1. edit strip.conf to enable/disable sevice as you want
2. run strip_play_services.sh

## Google Play Service dependency table
Check out the dependency table [here](docs/gps_dependency.md)

## Credits
All Credit gose to @dextorer for his great [blog](https://medium.com/@rotxed/dex-skys-the-limit-no-65k-methods-is-28e6cb40cf71#.627jhqeu8) and [gist](https://gist.github.com/dextorer/a32cad7819b7f272239b)

Dependency data is from [yyama2](http://qiita.com/yyama2)'s [blog](http://qiita.com/yyama2/items/ef717383f776429abaa4)

Contributors
@darkdukey
@yinjimmy
@Astrovic

This script is mainly for eclipse/ant user who has problem building their android app because of the 65535 methods limit

In a word, if you encountered a `Unable to execute dex: method ID not in [0, 0xffff]: 65536` error, this is for you.

> Note: For gradle/android studio users, google has posted a fix [here](http://developer.android.com/intl/ru/tools/building/multidex.html)

It contains a original copy of google play serivce v28, which you can be customized based on your project

## How update full Google Play Service Package
1. edit `pack_gms.sh` and insert your `ANDROID_SDK_ROOT` and the `PLAY_SERVICES_VERSION` (it must be available in `$ANDROID_SDK_ROOT/extras/google/m2repository/com/google/android/gms/play-services`)
2. run `pack_gms.sh`
3. done, you have a new `google-play-services.jar` with `PLAY_SERVICES_VERSION` chosen version
4. you can customize it with a lite strip version, enabling/disabling the services you want, using the following instructions

## How to customize your own Google Play Service Package
1. edit strip.conf to enable/disable sevice as you want
2. run strip_play_services.sh

## Google Play Service dependency table
| No | name | build.gradle | aar  | API count | Dependency |
| --- | --- | --- | --- | --- | --- |
| 1 | Google+ | com.google.android.gms:play-services-plus:8.4.0 | play-services-plus-8.4.0 | - | 3,23,27,28 |
| 2 | Google Account Login | com.google.android.gms:play-services-auth:8.4.0 | play-services-auth-8.4.0 | - | 3,23,27,28 |
| 3 | Google Actions, Base Client Library | com.google.android.gms:play-services-base:8.4.0 | play-services-base-8.4.0 | - | 23,27,28 |
| 4 | Google Address API | com.google.android.gms:play-services-identity:8.4.0 | play-services-identity-8.4.0 | - | 3,23,27,28 |
| 5 | Google App Indexing | com.google.android.gms:play-services-appindexing:8.4.0 | play-services-appindexing-8.4.0 | - | 3,23,27,28 |
| 6 | Google App Invites | com.google.android.gms:play-services-appinvite:8.4.0 | play-services-appinvite-8.4.0 | - | 3,23,27,28 |
| 7 | Google Analytics | com.google.android.gms:play-services-analytics:8.4.0 | play-services-analytics-8.4.0 | - | 23,27,28 |
| 8 | Google Cast | com.google.android.gms:play-services-cast:8.4.0 | play-services-cast-8.4.0 | - | 3,23,25,26,27,28 |
| 9 | Google Cloud Messaging | com.google.android.gms:play-services-gcm:8.4.0 | play-services-gcm-8.4.0 | - | 3,23,24,27,28 |
| 10 | Google Drive | com.google.android.gms:play-services-drive:8.4.0 | play-services-drive-8.4.0 | - | 3,23,27,28 |
| 11 | Google Fit | com.google.android.gms:play-services-fitness:8.4.0 | play-services-fitness-8.4.0 | - | 3,12,13,23,27,28 |
| 12 | Google Location, Activity Recognition, and Places | com.google.android.gms:play-services-location:8.4.0 | play-services-location-8.4.0 | - | 3,13,23,27,28 |
| 13 | Google Maps | com.google.android.gms:play-services-maps:8.4.0 | play-services-maps-8.4.0 | - | 3,23,27,28 |
| 14 | Google Mobile Ads | com.google.android.gms:play-services-ads:8.4.0 | play-services-ads-8.4.0 | - | 23,27,28 |
| 15 | Mobile Vision | com.google.android.gms:play-services-vision:8.4.0 | play-services-vision-8.4.0 | - | 3,23,27,28 |
| 16 | Google Nearby | com.google.android.gms:play-services-nearby:8.4.0 | play-services-nearby-8.4.0 | - | 3,23,27,28 |
| 17 | Google Panorama Viewer | com.google.android.gms:play-services-panorama:8.4.0 | play-services-panorama-8.4.0 | - | 3,23,27,28 |
| 18 | Google Play Game services | com.google.android.gms:play-services-games:8.4.0 | play-services-games-8.4.0 | - | 3,10,23,27,28 |
| 18 | SafetyNet | com.google.android.gms:play-services-safetynet:8.4.0 | play-services-safetynet-8.4.0 | - | 3,23,27,28 |
| 20 | Google Wallet | com.google.android.gms:play-services-wallet:8.4.0 | play-services-wallet-8.4.0 | - | 3,4,13,23,27,28 |
| 21 | Android Wear | com.google.android.gms:play-services-wearable:8.4.0 | play-services-wearable-8.4.0 | - | 3,23,27,28 |
| 22 | - | - | play-services-appstate-8.4.0 | - | 3,23,27,28 |
| 23 | - | - | play-services-basement-8.4.0 | - | 27,28 |
| 24 | - | - | play-services-measurement-8.4.0 | - | 23,27,28 |
| 25 | - | - | appcompat-v7-23.0.0 | - | 27,28 |
| 26 | - | - | mediarouter-v7-23.0.0 | - | 23,27,28,29 |
| 27 | - | - | support-annotations-23.0.0 | - |
| 28 | - | - | support-v4-23.0.0 | - | 27 |
| 29 | - | - | palete-v7-23.0.0 | - | 27,28 |

## Links
All Credit gose to @dextorer for his great [blog](https://medium.com/@rotxed/dex-skys-the-limit-no-65k-methods-is-28e6cb40cf71#.627jhqeu8) and [gist](https://gist.github.com/dextorer/a32cad7819b7f272239b)

Dependency data is from [yyama2](http://qiita.com/yyama2)'s [blog](http://qiita.com/yyama2/items/ef717383f776429abaa4)

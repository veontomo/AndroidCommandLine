set ANDROID_HOME=d:\Users\Andrey\Documents\AndroidSDK
set DEV_HOME=d:\Users\Andrey\Documents\Repos\AndroidCommandLine

set JACK_JAR="%ANDROID_HOME%\build-tools\24.0.1\jack.jar"
set AAPT_PATH="%ANDROID_HOME%\build-tools\24.0.1\aapt.exe"
set ANDROID_JAR="%ANDROID_HOME%\platforms\android-24\android.jar"
set ADB="%ANDROID_HOME%\platform-tools\adb.exe"
set JAVAVM="%JAVA_HOME%\bin\java.exe"

set PACKAGE_PATH=com/veontomo/cli
set PACKAGE=com.veontomo.cli
set MAIN_CLASS=MainActivity
set APP_NAME=AndroidCLI
set KEYSTORE_PATH=%DEV_HOME%/%APP_NAME%.keystore

call %AAPT_PATH% package -f -m -S %DEV_HOME%\res -J %DEV_HOME%\src -M %DEV_HOME%\AndroidManifest.xml -I %ANDROID_JAR%

%JAVAVM% -jar %JACK_JAR% --output-dex "%DEV_HOME%\bin" -cp %ANDROID_JAR% -D jack.java.source.version=1.8 "%DEV_HOME%\src\%PACKAGE_PATH%\R.java" "%DEV_HOME%\src\%PACKAGE_PATH%\%MAIN_CLASS%.java" 

call %AAPT_PATH% package -f -M %DEV_HOME%/AndroidManifest.xml -S %DEV_HOME%/res -I %ANDROID_JAR% -F %DEV_HOME%/bin/%APP_NAME%.unsigned.apk %DEV_HOME%/bin

REM call "%JAVA_HOME%/bin/keytool" -genkey -validity 10000 -dname "CN=AndroidDebug, O=Android, C=ITA" -keystore %KEYSTORE_PATH% -storepass android -keypass android -alias androiddebugkey -keyalg RSA -v -keysize 2048
call "%JAVA_HOME%/bin/jarsigner" -sigalg SHA1withRSA -digestalg SHA1 -keystore %KEYSTORE_PATH% -storepass android -keypass android -signedjar %DEV_HOME%/bin/%APP_NAME%.signed.apk %DEV_HOME%/bin/%APP_NAME%.unsigned.apk androiddebugkey


call %ADB% uninstall %PACKAGE%
call %ADB% install %DEV_HOME%/bin/%APP_NAME%.signed.apk
call %ADB% shell am start %PACKAGE%/%PACKAGE%.%MAIN_CLASS%
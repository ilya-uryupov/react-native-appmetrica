[![Build Status](https://travis-ci.org/doochik/react-native-appmetrica.svg?branch=master)](https://travis-ci.org/doochik/react-native-appmetrica)
[![NPM version](https://badge.fury.io/js/react-native-appmetrica.svg)](https://www.npmjs.com/package/react-native-appmetrica)


# react-native-appmetrica
React Native bridge to the [AppMetrica](https://appmetrica.yandex.com/) on both iOS and Android.

## Installation

1. **Only for iOS**: [setup AppMetrica](https://tech.yandex.com/appmetrica/).
`YandexMobileMetrica.framework` should be placed at `<project_dir>/ios/` or `<project_dir>/ios/Frameworks/`.
Otherwise you'll get build error.
2. `npm install --save react-native-appmetrica`
3. `react-native link react-native-appmetrica`

**iOS notice**: If you build failed after installing SDK and `react-native-appmetrica`
make sure `YandexMobileMetrica.framework` and `libRCTAppMetrica.a` are included at Build Phase -> Link Binary With Libraries

## Android Manual Linking

**MainApplication.java**
```diff
import android.app.Application;

import com.facebook.react.ReactApplication;
import com.facebook.react.ReactNativeHost;
import com.facebook.soloader.SoLoader;

+import com.yandex.metrica.YandexMetrica;
+import com.doochik.RNAppMetrica.AppMetricaPackage;

public class MainApplication extends Application implements ReactApplication {

+   private static final String YandexAppMetricaApiKey = "YOUR_API_KEY";

    @Override
    public void onCreate() {
        super.onCreate();

+       // Initializing the AppMetrica SDK
+       YandexMetrica.activate(getApplicationContext(), YandexAppMetricaApiKey);
+   
+       // Tracking user activity
+       YandexMetrica.enableActivityAutoTracking(this);
    
        SoLoader.init(this, /* native exopackage */ false);
    }

    ...
+       // This method is inside ReactNativeHost 
        @Override
        protected List<ReactPackage> getPackages() {
            return Arrays.<ReactPackage>asList(
                            new MainReactPackage(),
+                           new AppMetricaPackage()
            );
        }
    ...
}
```

**build.gradle**
```diff
dependencies {
    compile fileTree(dir: "libs", include: ["*.jar"])
    compile "com.android.support:appcompat-v7:23.0.1"
    compile "com.facebook.react:react-native:+"  // From node_modules
+   compile project(':react-native-appmetrica')
}
```

**settings.gradle**
```diff
rootProject.name = 'project_name'

+include ':react-native-appmetrica'
+project(':react-native-appmetrica').projectDir = new File(rootProject.projectDir, '../node_modules/react-native-appmetrica/android')

include ':app'
```

## Example

```js
import AppMetrica from 'react-native-appmetrica';

AppMetrica.activateWithApiKey('2dee16d2-1143-4cd3-a904-39ce10ac2755');

AppMetrica.reportEvent('Hello world');
```

## Usage

```js
import AppMetrica from 'react-native-appmetrica';

// Starts the statistics collection process.
AppMetrica.activateWithApiKey('...KEY...');

// Sends a custom event message and additional parameters (optional).
AppMetrica.reportEvent('My event');
AppMetrica.reportEvent('My event', { foo: 'bar' });

// Send a custom error event.
AppMetrica.reportError('My error');
```

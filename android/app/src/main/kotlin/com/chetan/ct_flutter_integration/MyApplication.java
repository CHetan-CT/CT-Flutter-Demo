package com.chetan.ct_flutter_integration;


import com.clevertap.android.sdk.ActivityLifecycleCallback;
import io.flutter.plugin.common.PluginRegistry.PluginRegistrantCallback;

import io.flutter.app.FlutterApplication;
import io.flutter.plugin.common.PluginRegistry;
import io.flutter.plugins.GeneratedPluginRegistrant;
import io.flutter.plugins.firebasemessaging.FlutterFirebaseMessagingService;
import io.flutter.plugins.firebasemessaging.FirebaseMessagingPlugin;

public class MyApplication extends FlutterApplication implements PluginRegistrantCallback {

    @java.lang.Override
    public void onCreate() {
        ActivityLifecycleCallback.register(this);
        FlutterFirebaseMessagingService.setPluginRegistrant(this);
        super.onCreate();
    }

    @Override
    public void registerWith(PluginRegistry pluginRegistry) {
        FirebaseMessagingPlugin.registerWith(pluginRegistry.registrarFor("io.flutter.plugins.firebasemessaging.FirebaseMessagingPlugin"));
    }
}

package com.chetan.ct_flutter_integration;

import android.os.Bundle;
import android.util.Log;

import com.clevertap.android.sdk.CleverTapAPI;
import com.clevertap.android.sdk.NotificationInfo;
import com.google.firebase.messaging.RemoteMessage;

import java.util.Map;

import io.flutter.plugins.firebasemessaging.FlutterFirebaseMessagingService;

public class MyFirebaseMessagingservice extends FlutterFirebaseMessagingService {

    @Override
    public void onMessageReceived(RemoteMessage message) {
        try {
            if (message.getData().size() > 0) {
                Bundle extras = new Bundle();
                for (Map.Entry<String, String> entry : message.getData().entrySet()) {
                    extras.putString(entry.getKey(), entry.getValue());
                }

                NotificationInfo info = CleverTapAPI.getNotificationInfo(extras);

                if (info.fromCleverTap) {
                    CleverTapAPI.createNotification(getApplicationContext(), extras);
                } else {
                    // not from CleverTap handle yourself or pass to another provider
                }
            }
        } catch (Throwable t) {
            Log.d("MYFCMLIST", "Error parsing FCM message", t);
        }
    }
}

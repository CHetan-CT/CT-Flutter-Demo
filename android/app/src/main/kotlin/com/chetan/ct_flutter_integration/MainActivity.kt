package com.chetan.ct_flutter_integration

import androidx.annotation.NonNull;
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant
import io.flutter.plugins.firebasemessaging.FirebaseMessagingPlugin
//import dev.flutter.plugins.e2e.E2EPlugin

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);
        flutterEngine.plugins.add(FirebaseMessagingPlugin())
//        flutterEngine.plugins.add(E2EPlugin())
    }

    FirebaseInstanceId.getInstance().instanceId
    .addOnCompleteListener(OnCompleteListener { task ->
        if (!task.isSuccessful) {
            Log.w(TAG, "getInstanceId failed", task.exception)
            return@OnCompleteListener
        }

        val token = task.result?.token

        clevertapDefaultInstance.pushFcmRegistrationId(token,true)

    })
}

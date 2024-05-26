package com.xpectcorps.kerala_wings

import android.app.NotificationChannel
import android.app.NotificationManager
import android.os.Build
import android.net.Uri
import android.media.AudioAttributes
import android.os.Bundle // Import Bundle class
import androidx.core.content.getSystemService
import io.flutter.embedding.android.FlutterActivity

class MainActivity : FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val channel = NotificationChannel(
                "high_importance_kw", // Ensure this matches the manifest
                "High Importance Notifications",
                NotificationManager.IMPORTANCE_HIGH
            )
            channel.description = "This channel is used for important notifications."
            val soundUri = Uri.parse("android.resource://com.xpectcorps.kerala_wings/${R.raw.notification}")
            channel.setSound(soundUri, AudioAttributes.Builder().setUsage(AudioAttributes.USAGE_NOTIFICATION).build())
            val manager = getSystemService(NotificationManager::class.java)
            manager?.createNotificationChannel(channel)
        }
    }
}

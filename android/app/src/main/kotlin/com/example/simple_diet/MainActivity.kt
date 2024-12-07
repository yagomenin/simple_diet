package com.example.simple_diet

import android.app.NotificationChannel
import android.app.NotificationManager
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.os.BatteryManager
import androidx.core.app.NotificationCompat
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {

    private val CHANNEL = "com.example.yourapp/battery"
    private val NOTIFICATION_ID = 1

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "checkBattery") {
                val isBatteryLow = checkBatteryLevel()
                result.success(isBatteryLow)
            } else {
                result.notImplemented()
            }
        }
    }

    // Função para verificar o nível da bateria
    private fun checkBatteryLevel(): Boolean {
        val batteryStatus: Intent? = IntentFilter(Intent.ACTION_BATTERY_CHANGED).let { ifilter ->
            applicationContext.registerReceiver(null, ifilter)
        }
        val level = batteryStatus?.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) ?: -1
        val scale = batteryStatus?.getIntExtra(BatteryManager.EXTRA_SCALE, -1) ?: -1
        val batteryPct: Float = level / scale.toFloat()

        return if (batteryPct < 0.2) {
            sendLowBatteryNotification()
            true
        } else {
            false
        }
    }

    // Função para enviar a notificação de bateria baixa
    private fun sendLowBatteryNotification() {
        val notificationManager = getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
        val builder = NotificationCompat.Builder(this, "battery_channel")
            .setSmallIcon(android.R.drawable.ic_dialog_alert)
            .setContentTitle("Bateria baixa")
            .setContentText("A bateria do seu dispositivo está abaixo de 20%.")
            .setPriority(NotificationCompat.PRIORITY_HIGH)

        // Criação do canal de notificação (necessário para Android 8.0 ou superior)
        if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.O) {
            val channel = NotificationChannel(
                "battery_channel",
                "Bateria",
                NotificationManager.IMPORTANCE_HIGH
            )
            notificationManager.createNotificationChannel(channel)
        }

        // Exibe a notificação
        notificationManager.notify(NOTIFICATION_ID, builder.build())
    }
}
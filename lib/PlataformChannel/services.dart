import 'package:flutter/services.dart';

class BatteryService {
  static const MethodChannel _channel = MethodChannel('com.example.yourapp/battery');


  Future<void> checkBatteryLevel() async {
    try {
      final bool isBatteryLow = await _channel.invokeMethod('checkBattery');
      if (isBatteryLow) {
        _showLowBatteryNotification();
      }
    } on PlatformException catch (e) {
      print("Erro ao verificar a bateria: $e");
    }
  }


  void _showLowBatteryNotification() {
    print('Bateria baixa. Enviando notificação.');
  }
}
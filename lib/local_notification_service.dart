import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  late FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;
  late AndroidNotificationChannel _channel;

  LocalNotificationService() {
    _channel = const AndroidNotificationChannel(
      'default',
      'default',
      description: 'Default Notification Channel',
      importance: Importance.max,
    );

    _config().then((value) {
      _flutterLocalNotificationsPlugin = value;
    });
  }

  Future<FlutterLocalNotificationsPlugin> _config() async {
    final localNotificationPlugin = FlutterLocalNotificationsPlugin();

    await localNotificationPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_channel);

    return localNotificationPlugin;
  }

  init() {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iOS = IOSInitializationSettings();

    _flutterLocalNotificationsPlugin.initialize(const InitializationSettings(
      android: android,
      iOS: iOS,
    ));
  }

  void display(
    RemoteMessage message,
  ) {
    final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    _flutterLocalNotificationsPlugin.show(
      id,
      message.notification?.title,
      message.notification?.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          _channel.id,
          _channel.name,
          channelDescription: _channel.description,
          icon: '@mipmap/ic_launcher',
        ),
      ),
    );
  }
}

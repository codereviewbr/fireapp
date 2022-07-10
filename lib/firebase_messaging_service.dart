import 'package:fireapp/local_notification_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class FirebaseMessagingService {
  final _messaging = FirebaseMessaging.instance;

  final LocalNotificationService _localNotificationService;

  FirebaseMessagingService._(this._localNotificationService);

  static final FirebaseMessagingService _instance =
      FirebaseMessagingService._(LocalNotificationService());

  factory FirebaseMessagingService() => _instance;

  Future<void> init() async {
    debugPrint(await _messaging.getToken());
    debugPrint(await _messaging.getAPNSToken());
    await _messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onMessage.listen((message) {
      RemoteNotification? notification = message.notification;
      if (notification != null) {
        _localNotificationService.display(message);
      }
    });
  }
}

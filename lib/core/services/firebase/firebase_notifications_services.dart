import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../../../main.dart';
import '../../routing/routing.dart';

class NotificationService {
  // Firebase
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  // Local notifications
  final FlutterLocalNotificationsPlugin _localNotifications = FlutterLocalNotificationsPlugin();

  // Singleton
  static final NotificationService instance = NotificationService._();
  NotificationService._();

  // Initialize notification service
  Future<void> initialize() async {
    await _requestPermission();
    await _initializeLocalNotifications();
    _setupFirebaseListeners();
  }

  // ------------------------------------------------------------
  // 1. Request notification permission
  // ------------------------------------------------------------

  Future<void> _requestPermission() async {
    if (Platform.isIOS) {
      await _firebaseMessaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );
    }

    if (Platform.isAndroid) {
      await _localNotifications
          .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
          ?.requestNotificationsPermission();
    }
  }

  // ------------------------------------------------------------
  // 2. Initialize local notifications
  // ------------------------------------------------------------

  Future<void> _initializeLocalNotifications() async {
    const androidSettings =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    const iosSettings = DarwinInitializationSettings();

    const settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _localNotifications.initialize(
      settings: settings,
      onDidReceiveNotificationResponse: (response) {
        _openNotificationsScreen();
      },
    );

    // Android notification channel
    const channel = AndroidNotificationChannel(
      'notifications',
      'Notifications',
      description: 'App notifications',
      importance: Importance.high,
    );

    await _localNotifications
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  // ------------------------------------------------------------
  // 3. Firebase listeners
  // ------------------------------------------------------------

  void _setupFirebaseListeners() {
    // App is open
    FirebaseMessaging.onMessage.listen((message) {
      debugPrint('Foreground message received');

      _showNotification(message);
    });

    // App was in background and user tapped notification
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      debugPrint('Notification tapped');

      _openNotificationsScreen();
    });
  }

  // ------------------------------------------------------------
  // 4. Show notification when app is open
  // ------------------------------------------------------------

  Future<void> _showNotification(RemoteMessage message) async {
    const androidDetails = AndroidNotificationDetails(
      'notifications',
      'Notifications',
      importance: Importance.high,
      priority: Priority.high,
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _localNotifications.show(
      id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title: message.notification?.title ?? 'Notification',
      body: message.notification?.body ?? '',
      notificationDetails: details,
    );
  }

  // ------------------------------------------------------------
  // 5. Open notifications screen
  // ------------------------------------------------------------

  void _openNotificationsScreen() {

    navigatorKey.currentState?.pushNamed(
      Routes.notifications,
    );
  }

  // ------------------------------------------------------------
  // 6. Handle notification when app was completely closed
  // ------------------------------------------------------------

  Future<void> handleInitialNotification() async {
    final message =
    await _firebaseMessaging.getInitialMessage();

    if (message != null) {
      _openNotificationsScreen();
    }
  }

  // ------------------------------------------------------------
  // 7. Get FCM token
  // ------------------------------------------------------------

  Future<String?> getDeviceToken() async {
    final token = await _firebaseMessaging.getToken();

    debugPrint('FCM Token: $token');

    return token;
  }
}
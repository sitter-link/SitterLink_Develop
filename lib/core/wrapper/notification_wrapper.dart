// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/foundation.dart';
import 'package:nanny_app/app/env.dart';
import 'package:nanny_app/core/injector/injection.dart';
import 'package:nanny_app/core/model/push_notif.dart';
import 'package:nanny_app/core/services/navigation_service.dart';
import 'package:nanny_app/features/auth/repository/user_repository.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  var data = message.data;

  _handleNoitifPayload(data);

  ///
}

_handleDeepLinking(PushNotification notif) async {
  if (notif.type.toLowerCase() == "order") {}
}

_handleNoitifPayload(Map data) async {
  if (data.isNotEmpty) {
    PushNotification notifData = PushNotification.fromJson(data);
    await _handleDeepLinking(notifData);
  }
}

class NotificationWrapper extends StatefulWidget {
  final Widget child;
  const NotificationWrapper({super.key, required this.child});

  @override
  _NotificationWrapperState createState() => _NotificationWrapperState();
}

class _NotificationWrapperState extends State<NotificationWrapper> {
  final AndroidNotificationChannel channel = AndroidNotificationChannel(
    '${Random().nextInt(1000)}', // id
    'SitterLink', // title
    description: 'SitterLink', // description
    importance: Importance.high,
    playSound: true,
    enableLights: true,
    ledColor: Colors.blue,
  );

  final FlutterLocalNotificationsPlugin localNotif =
      FlutterLocalNotificationsPlugin();

  Future<void> initialiseFirebase() async {
    await Firebase.initializeApp();
  }

  @override
  void initState() {
    initialiseFirebase().then((value) async {
      await initialiseFCM();
      getAndSetFcmToken();
      listenRefreshToken();
      initLocalNotif();

      ///listening notifications
      subcribeToNotification();
      onForegroundMessageListen();
      onBackgroundMessageListened();
      onNotifOpenedFromTerminated();
    });
    super.initState();
  }

  subcribeToNotification() {
    try {
      FirebaseMessaging.instance.subscribeToTopic("defaults");
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  listenRefreshToken() async {
    FirebaseMessaging.instance.onTokenRefresh.listen((token) async {
      await _postTokenToApi(token);
    });
  }

  _postTokenToApi(String token) async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      final dio = DI.instance<Dio>();
      final env = DI.instance<Env>();
      final user =
          RepositoryProvider.of<UserRepository>(NavigationService.context)
              .user
              .value;
      if (user != null) {
        final _ = await dio.post(
          "${env.baseUrl}/user/register-device",
          data: {"token": token},
        );
        if (kDebugMode) {
          print(_);
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> getAndSetFcmToken() async {
    final String? token = await FirebaseMessaging.instance.getToken();
    // print("--------------Firebase Token------------------------------");
    // print(token);
    await Future.delayed(const Duration(seconds: 2));
    if (token != null) {
      final _ = await _postTokenToApi(token);
    }
  }

  Future<void> initialiseFCM() async {
    if (Platform.isIOS) {
      await FirebaseMessaging.instance.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );
    }

    try {
      FirebaseMessaging.onBackgroundMessage(
          _firebaseMessagingBackgroundHandler);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  initLocalNotif() async {
    final localNotification = localNotif.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await localNotification?.requestNotificationsPermission();
    localNotification?.createNotificationChannel(channel);

    localNotif.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings("launcher_icon"),
        iOS: DarwinInitializationSettings(),
      ),
      onDidReceiveNotificationResponse: (details) {
        parseLocalPayload(details);
      },
    );
  }

  parseLocalPayload(NotificationResponse response) {
    try {
      if (response.payload?.isNotEmpty ?? false) {
        var decoded = json.decode(response.payload!);

        PushNotification notifData = PushNotification.fromJson(decoded);
        _handleDeepLinking(notifData);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> onBackgroundMessageListened() async {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _handlePushNotificationData(message);
    });
  }

  onNotifOpenedFromTerminated() async {
    try {
      final message = await FirebaseMessaging.instance.getInitialMessage();

      await Future.delayed(const Duration(seconds: 2), () {
        _handlePushNotificationData(message);
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  _handlePushNotificationData(RemoteMessage? message) {
    if (message != null) {
      _handleNoitifPayload(message.data);
    }
  }

  Future<void> onForegroundMessageListen() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;

      ///
      if (notification != null) {
        String pay = message.data.isNotEmpty ? json.encode(message.data) : "";

        localNotif.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              icon: 'launcher_icon',
            ),
            iOS: const DarwinNotificationDetails(),
          ),
          payload: pay,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

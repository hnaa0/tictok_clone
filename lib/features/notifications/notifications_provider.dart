import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/authentication/repos/authentication_repo.dart';

class NotificationsProvider extends AsyncNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  Future<void> updateToken(String token) async {
    final user = ref.read(authRepo).user;
    await _db.collection("users").doc(user!.uid).update({"token": token});
  }

  Future<void> initListeners() async {
    final permission = await _messaging.requestPermission();
    // 권한을 거부했을 때
    if (permission.authorizationStatus == AuthorizationStatus.denied) {
      return;
    }
    // 유저가 어플을 열고 있을 때 받는 메세지 (foreground)
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      print("메세지 받았고 foreground");
      print(event.notification?.title);
    });
  }

  @override
  FutureOr build() async {
    // token을 사용해서 사용자를 특정할 수 있음.
    final token = await _messaging.getToken();
    if (token == null) return;
    await updateToken(token);
    await initListeners();
    // token이 바뀌는 경우 대비
    _messaging.onTokenRefresh.listen((newToken) async {
      await updateToken(newToken);
    });
  }
}

final notificationsProvider = AsyncNotifierProvider(
  () => NotificationsProvider(),
);

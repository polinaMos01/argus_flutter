import 'package:flutter/foundation.dart';

class NotificationState {
  static final NotificationState _instance = NotificationState._internal();
  factory NotificationState() => _instance;
  NotificationState._internal();

  final ValueNotifier<bool> hasUnreadNotifications = ValueNotifier(true);

  void markAsRead() {
    hasUnreadNotifications.value = false;
  }
}

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class FirebaseMessagingService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void initializeMessaging() {
    // Request permission for notifications
    requestPermission();

    // Handle messages when the app is in the background
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // Handle messages when the app is in the foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("onMessage: Received a message in the foreground!");
      print("Message data: ${message.data}");
      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification!.title}, ${message.notification!.body}');
        Get.snackbar(
          message.notification!.title ?? "Notification",
          message.notification!.body ?? "You have a new message",
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    });

    // Handle messages when the user taps on the notification in the notification tray
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("onMessageOpenedApp: A message was opened!");
      if (message.data['route'] != null) {
        print("Navigating to: ${message.data['route']}");
        Get.toNamed(message.data['route']);
      }
    });

    // Listen for changes in the Firestore collection
    _firestore.collection('notifications').snapshots().listen((snapshot) {
      snapshot.docChanges.forEach((change) {
        if (change.type == DocumentChangeType.added) {
          final notificationData = change.doc.data();
          _handleFirestoreNotification(notificationData!);
        }
      });
    });
  }

  Future<void> requestPermission() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );
    print('Permissions status: ${settings.authorizationStatus}');
  }

  static Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    print("Handling a background message: ${message.messageId}");
    print("Background message data: ${message.data}");
  }

  void _handleFirestoreNotification(Map<String, dynamic> notificationData) {
    // Handle the notification data received from Firestore collection
    // You can trigger FCM notifications, display in-app notifications, or any other action here
  }
}

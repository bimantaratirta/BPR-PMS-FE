import 'package:bpr_pms/app/common/constant/app_constants.dart';
import 'package:get_storage/get_storage.dart';
import 'package:bpr_pms/app/common/utils/helper.dart';
import 'package:bpr_pms/app/common/utils/location_service.dart';
import 'package:bpr_pms/app/data/main/api/api_params_model.dart';
import 'package:bpr_pms/app/data/storage/storage_client.dart';
import 'package:bpr_pms/app/network/api_client.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:bpr_pms/firebase_options.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await GetStorage.init();
  await FirebaseMessagingService.initLocalNotifications();

  if (message.notification == null) {
    await FirebaseMessagingService.showLocalNotification(message);
  }

  await FirebaseMessagingService.handleMessage(message);
}

class FirebaseMessagingService {
  static final FlutterLocalNotificationsPlugin _localNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static Future<void> initLocalNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings = InitializationSettings(android: initializationSettingsAndroid);
    await _localNotificationsPlugin.initialize(settings: initializationSettings);
  }

  static Future<void> showLocalNotification(RemoteMessage message) async {
    String title = message.data['title'] ?? message.notification?.title ?? 'Notifikasi BPR PMS';
    String body = message.data['body'] ?? message.notification?.body ?? message.data['type'] == 'REQUEST_LOCATION'
        ? 'Mengirimkan data lokasi...'
        : 'Memproses data...';

    const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'bpr_pms_channel',
      'BPR PMS Notifications',
      importance: Importance.max,
      priority: Priority.high,
    );
    const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);

    await _localNotificationsPlugin.show(
      id: message.hashCode,
      title: title,
      body: body,
      notificationDetails: platformChannelSpecifics,
    );
  }

  static Future<void> init() async {
    await initLocalNotifications();
    // Pastikan izin lokasi diminta dan di-approve terlebih dahulu
    await LocationService.handlePermission();

    // Request permission (terutama untuk iOS) untuk notifikasi
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    await messaging.requestPermission();

    // Ambil dan simpan FCM token saat ini jika user sudah login
    String? token = await messaging.getToken();
    if (token != null) {
      await saveFcmToken(token);
    }

    // Dengarkan perubahan token FCM
    messaging.onTokenRefresh.listen((fcmToken) async {
      await saveFcmToken(fcmToken);
    });

    // Foreground message listener
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      await handleMessage(message);
    });
  }

  /// Menyimpan FCM token ke server
  static Future<void> saveFcmToken(String fcmToken) async {
    try {
      String userId = "";
      final accessToken = StorageClient.getAccessToken();
      if (accessToken != null) {
        final payload = Helper().decodeJwt(accessToken);
        if (payload != null) {
          userId = payload['id']?.toString() ?? payload['sub']?.toString() ?? "";
        }
      }

      // Jika belum ada user yang login, tidak perlu kirim token
      if (userId.isEmpty) return;

      final apiParams = ApiParams(path: AppConstants.saveFcmTokenEndpoint, body: {"user_id": userId, "fcm_token": fcmToken});

      final response = await apiClient.put(apiParams);

      if (kDebugMode) {
        print("Save FCM Token respons: ${response.code} - ${response.message}");
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error saving FCM token: $e");
      }
    }
  }

  /// Logika utama untuk menangani pesan FCM
  static Future<void> handleMessage(RemoteMessage message) async {
    if (kDebugMode) {
      print("Handling FCM message: ${message.messageId}");
    }

    if (message.data['type'] == 'REQUEST_LOCATION') {
      await handleLocationRequest();
    }
  }

  /// Menangani request lokasi: ambil GPS, lalu kirim via Dio
  static Future<void> handleLocationRequest() async {
    try {
      final position = await LocationService.getCurrentPosition();
      if (position == null) {
        if (kDebugMode) print("Gagal mendapatkan lokasi untuk FCM request.");
        return;
      }

      String userId = "";
      final token = StorageClient.getAccessToken();
      if (token != null) {
        final payload = Helper().decodeJwt(token);
        if (payload != null) {
          userId = payload['id']?.toString() ?? payload['sub']?.toString() ?? "";
        }
      }

      final apiParams = ApiParams(
        path: AppConstants.currentLocationEndpoint,
        body: {"user_id": userId, "latitude": position.latitude, "longitude": position.longitude},
      );

      final response = await apiClient.post(apiParams);

      if (kDebugMode) {
        print("Kirim lokasi respons: ${response.code} - ${response.message}");
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error handling location request: $e");
      }
    }
  }
}

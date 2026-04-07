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

class FirebaseMessagingService {
  static Future<void> init() async {
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
      await _handleMessage(message);
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

      final apiParams = ApiParams(
        path: AppConstants.saveFcmTokenEndpoint,
        body: {
          "user_id": userId,
          "fcm_token": fcmToken,
        },
      );

      final response = await apiClient.post(apiParams);

      if (kDebugMode) {
        print("Save FCM Token respons: ${response.code} - ${response.message}");
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error saving FCM token: $e");
      }
    }
  }

  /// Handler untuk background message
  @pragma('vm:entry-point')
  static Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    await Firebase.initializeApp();
    await GetStorage.init();
    await _handleMessage(message);
  }

  /// Logika utama untuk menangani pesan FCM
  static Future<void> _handleMessage(RemoteMessage message) async {
    if (kDebugMode) {
      print("Handling FCM message: ${message.messageId}");
    }

    if (message.data['type'] == 'REQUEST_LOCATION') {
      await _handleLocationRequest();
    }
  }

  /// Menangani request lokasi: ambil GPS, lalu kirim via Dio
  static Future<void> _handleLocationRequest() async {
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
        body: {"user_id": userId, "latitude": position.latitude.toString(), "longitude": position.longitude.toString()},
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

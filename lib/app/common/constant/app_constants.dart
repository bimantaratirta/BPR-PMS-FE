class AppConstants {
  // API Constants
  static const String baseApiUrl = "http://10.0.2.2:3001/api/v2";

  // Endpoints
  static const String loginEndpoint = "/auth/login";
  static const String meEndpoint = "/auth/me";
  static const String refreshTokenEndpoint = "/auth/refresh-token";

  // Storage Keys
  static const String userKey = "user_data";

  // Other Constants
  static const int timeoutDuration = 30000; // milliseconds
}

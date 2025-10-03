import 'dart:convert';

class Helper {
  Map<String, dynamic>? decodeJwt(String token) {
    if (token.isEmpty) return null;

    final parts = token.split('.');
    if (parts.length != 3) return null;

    String payload = parts[1];

    String normalizedPayload = payload.padRight(payload.length + (4 - payload.length % 4) % 4, '=');

    try {
      final payloadBytes = base64Url.decode(normalizedPayload);
      final payloadJson = utf8.decode(payloadBytes);
      return json.decode(payloadJson) as Map<String, dynamic>;
    } catch (e) {
      return null;
    }
  }
}

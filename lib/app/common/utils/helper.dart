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

  List<T> listParser<T>(dynamic response, T Function(Map<String, dynamic>) fromJson) {
    if (response is List) {
      try {
        return response.map((e) => fromJson(e as Map<String, dynamic>)).toList();
      } catch (e) {
        print('Error mapping list element (List case): $e');
        throw Exception('Failed to parse list elements: $e');
      }
    }

    if (response is Map<String, dynamic> && response['data'] is List) {
      try {
        final rawList = response['data'] as List;
        return rawList.map((e) => fromJson(e as Map<String, dynamic>)).toList();
      } catch (e) {
        print('Error mapping list element (Map case): $e');
        throw Exception('Failed to parse list elements: $e');
      }
    }

    throw Exception('Expected List but got ${response.runtimeType}');
  }
}

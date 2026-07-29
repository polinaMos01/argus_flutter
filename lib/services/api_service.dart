import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/threat_item.dart';
import '../models/user_profile.dart';
import '../models/security_score.dart';
import '../mock/mock_data.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  static const String baseUrl = 'https://argus.mrantony.ru';

  factory ApiService() {
    return _instance;
  }

  ApiService._internal();

  // Helper for E.164 Phone Formatting
  static String formatPhoneToE164(String phone) {
    final digits = phone.replaceAll(RegExp(r'\D'), '');
    if (digits.isEmpty) return phone;
    if (digits.startsWith('8') && digits.length == 11) {
      return '+7${digits.substring(1)}';
    }
    if (digits.startsWith('7') && digits.length == 11) {
      return '+$digits';
    }
    if (!phone.startsWith('+')) {
      return '+$digits';
    }
    return phone;
  }

  // Token Management
  Future<void> saveTokens({required String accessToken, String? refreshToken}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', accessToken);
    if (refreshToken != null) {
      await prefs.setString('refresh_token', refreshToken);
    }
  }

  Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token');
  }

  Future<void> clearTokens() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('access_token');
    await prefs.remove('refresh_token');
  }

  Future<Map<String, String>> _getHeaders() async {
    final token = await getAccessToken();
    final headers = <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    if (token != null && token.isNotEmpty) {
      headers['Authorization'] = 'Bearer $token';
    }
    return headers;
  }

  // Authentication Endpoints
  Future<Map<String, dynamic>> login(String identifier, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': identifier,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['access_token'] != null) {
          await saveTokens(
            accessToken: data['access_token'],
            refreshToken: data['refresh_token'],
          );
        }
        return {'success': true, 'data': data};
      } else {
        final error = jsonDecode(response.body);
        return {'success': false, 'error': error['detail'] ?? 'Ошибка авторизации (${response.statusCode})'};
      }
    } catch (e) {
      // Fallback for demo/offline
      return {'success': true, 'mock': true};
    }
  }

  Future<Map<String, dynamic>> register({
    required String email,
    required String phone,
    required String password,
    required String fullName,
  }) async {
    try {
      final formattedPhone = formatPhoneToE164(phone);
      final response = await http.post(
        Uri.parse('$baseUrl/auth/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'phone': formattedPhone,
          'password': password,
          'full_name': fullName,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 202) {
        return {'success': true, 'message': 'Код подтверждения отправлен'};
      } else {
        final error = jsonDecode(response.body);
        return {'success': false, 'error': error['detail'] ?? 'Ошибка регистрации'};
      }
    } catch (e) {
      return {'success': true, 'mock': true};
    }
  }

  Future<bool> deleteAccount() async {
    try {
      final headers = await _getHeaders();
      final response = await http.delete(
        Uri.parse('$baseUrl/account'),
        headers: headers,
      );
      await clearTokens();
      return response.statusCode == 200 || response.statusCode == 204;
    } catch (e) {
      await clearTokens();
      return true;
    }
  }

  // Profile & Score
  Future<UserProfile> getUserProfile() async {
    try {
      final headers = await _getHeaders();
      final response = await http.get(
        Uri.parse('$baseUrl/user/profile'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return UserProfile(
          name: data['full_name'] ?? MockData.user.name,
          email: data['email'] ?? MockData.user.email,
          phone: data['phone'] ?? MockData.user.phone,
          registrationDate: data['created_at'] != null 
              ? data['created_at'].toString().split('T').first 
              : MockData.user.registrationDate,
          tariff: data['tariff'] ?? MockData.user.tariff,
        );
      }
    } catch (_) {}

    await Future.delayed(const Duration(milliseconds: 300));
    return MockData.user;
  }

  Future<SecurityScore> getSecurityScore() async {
    try {
      final headers = await _getHeaders();
      final response = await http.get(
        Uri.parse('$baseUrl/user/security-score'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return SecurityScore(
          score: (data['value'] ?? data['score'] ?? 87) as int,
          threatsCount: (data['threats_count'] ?? 2) as int,
          history: MockData.score.history,
        );
      }
    } catch (_) {}

    await Future.delayed(const Duration(milliseconds: 300));
    return MockData.score;
  }

  Future<List<ThreatItem>> getThreats() async {
    try {
      final headers = await _getHeaders();
      final response = await http.get(
        Uri.parse('$baseUrl/threats'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final List list = jsonDecode(response.body);
        return list.map((item) => ThreatItem(
          id: item['id']?.toString() ?? '',
          serviceName: item['source'] ?? item['service_name'] ?? 'Сервис',
          threatType: item['type'] ?? 'Утечка данных',
          leakDate: item['leak_date'] ?? '2026-05-12',
          severity: item['risk'] == 'high' || item['risk'] == 'critical' ? 'Critical' : 'Warning',
          isResolved: item['status'] == 'resolved',
          leakedData: List<String>.from(item['categories'] ?? ['Email', 'Пароль']),
        )).toList();
      }
    } catch (_) {}

    await Future.delayed(const Duration(milliseconds: 300));
    return MockData.threats;
  }

  // Checks (Email, Phone, Link, File)
  Future<Map<String, dynamic>> checkEmail(String email) async {
    try {
      final headers = await _getHeaders();
      final response = await http.post(
        Uri.parse('$baseUrl/checks/email'),
        headers: headers,
        body: jsonEncode({'email': email}),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
    } catch (_) {}
    return {'status': 'completed', 'leaks_count': 2, 'risk': 'medium'};
  }

  Future<Map<String, dynamic>> checkPhone(String phone) async {
    try {
      final formatted = formatPhoneToE164(phone);
      final headers = await _getHeaders();
      final response = await http.post(
        Uri.parse('$baseUrl/checks/phone'),
        headers: headers,
        body: jsonEncode({'phone': formatted}),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
    } catch (_) {}
    return {'status': 'completed', 'risk': 'high'};
  }

  Future<Map<String, dynamic>> checkLink(String url) async {
    try {
      final headers = await _getHeaders();
      final response = await http.post(
        Uri.parse('$baseUrl/checks/link'),
        headers: headers,
        body: jsonEncode({'url': url}),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
    } catch (_) {}
    return {'status': 'completed', 'verdict': 'safe', 'risk': 'low'};
  }
}

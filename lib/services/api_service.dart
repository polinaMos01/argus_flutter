import '../models/threat_item.dart';
import '../models/user_profile.dart';
import '../models/security_score.dart';
import '../mock/mock_data.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();

  factory ApiService() {
    return _instance;
  }

  ApiService._internal();

  Future<UserProfile> getUserProfile() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    return MockData.user;
  }

  Future<SecurityScore> getSecurityScore() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    return MockData.score;
  }

  Future<List<ThreatItem>> getThreats() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    return MockData.threats;
  }
}

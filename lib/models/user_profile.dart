class UserProfile {
  final String username;
  final String email;
  final String phone;
  final String plan;
  final String planExpiry;

  UserProfile({
    required this.username,
    required this.email,
    required this.phone,
    required this.plan,
    required this.planExpiry,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      username: json['username'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      plan: json['plan'] as String,
      planExpiry: json['planExpiry'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'phone': phone,
      'plan': plan,
      'planExpiry': planExpiry,
    };
  }
}

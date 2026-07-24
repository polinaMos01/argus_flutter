class ThreatItem {
  final String id;
  final String serviceName;
  final String leakDate;
  final String severity; // 'Critical', 'Warning'
  bool isResolved;
  final List<String> leakedData;
  final Map<String, String> details;
  final List<String> recommendations;
  final String websiteUrl;

  ThreatItem({
    required this.id,
    required this.serviceName,
    required this.leakDate,
    required this.severity,
    this.isResolved = false,
    required this.leakedData,
    required this.details,
    required this.recommendations,
    required this.websiteUrl,
  });

  factory ThreatItem.fromJson(Map<String, dynamic> json) {
    return ThreatItem(
      id: json['id'] as String,
      serviceName: json['serviceName'] as String,
      leakDate: json['leakDate'] as String,
      severity: json['severity'] as String,
      isResolved: json['isResolved'] as bool? ?? false,
      leakedData: List<String>.from(json['leakedData'] as List),
      details: Map<String, String>.from(json['details'] as Map),
      recommendations: List<String>.from(json['recommendations'] as List),
      websiteUrl: json['websiteUrl'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'serviceName': serviceName,
      'leakDate': leakDate,
      'severity': severity,
      'isResolved': isResolved,
      'leakedData': leakedData,
      'details': details,
      'recommendations': recommendations,
      'websiteUrl': websiteUrl,
    };
  }
}

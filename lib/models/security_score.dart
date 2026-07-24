class SecurityScore {
  final int score;
  final int maxScore;
  final String level;
  final int leaksPercent;
  final int leaksCount;

  SecurityScore({
    required this.score,
    required this.maxScore,
    required this.level,
    required this.leaksPercent,
    required this.leaksCount,
  });

  factory SecurityScore.fromJson(Map<String, dynamic> json) {
    return SecurityScore(
      score: json['score'] as int,
      maxScore: json['maxScore'] as int,
      level: json['level'] as String,
      leaksPercent: json['leaksPercent'] as int,
      leaksCount: json['leaksCount'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'score': score,
      'maxScore': maxScore,
      'level': level,
      'leaksPercent': leaksPercent,
      'leaksCount': leaksCount,
    };
  }
}

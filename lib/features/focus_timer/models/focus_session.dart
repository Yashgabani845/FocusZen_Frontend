class FocusSession {
  final String id;
  final String userId;
  final DateTime startTime;
  final DateTime? endTime;
  final int duration;
  final int interruptions;
  final DateTime createdAt;

  FocusSession({
    required this.id,
    required this.userId,
    required this.startTime,
    this.endTime,
    required this.duration,
    required this.interruptions,
    required this.createdAt,
  });

  factory FocusSession.fromMap(Map<String, dynamic> map) {
    return FocusSession(
      id: map['id'],
      userId: map['user_id'],
      startTime: DateTime.parse(map['start_time']),
      endTime: map['end_time'] != null ? DateTime.parse(map['end_time']) : null,
      duration: map['duration'] ?? 0,
      interruptions: map['interruptions'] ?? 0,
      createdAt: DateTime.parse(map['created_at']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'start_time': startTime.toIso8601String(),
      'end_time': endTime?.toIso8601String(),
      'duration': duration,
      'interruptions': interruptions,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
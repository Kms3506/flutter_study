class HealthMemo {
  final int id; // id 필드를 non-nullable로 변경
  final String health;
  final String memo;

  HealthMemo({required this.id, required this.health, required this.memo});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'health': health,
      'memo': memo,
    };
  }

  factory HealthMemo.fromMap(Map<String, dynamic> map) {
    return HealthMemo(
      id: map['id'],
      health: map['health'],
      memo: map['memo'],
    );
  }
}

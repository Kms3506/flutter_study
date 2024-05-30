class CalendarMemo {
  final int? id;
  final DateTime date; // 변경된 부분: DateTime 타입으로 변경
  final String memo;

  CalendarMemo({this.id, required this.date, required this.memo});

  // Map으로 변환
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date.millisecondsSinceEpoch, // DateTime을 밀리초로 변환하여 저장
      'memo': memo,
    };
  }

  // Map에서 객체로 변환
  factory CalendarMemo.fromMap(Map<String, dynamic> map) {
    return CalendarMemo(
      id: map['id'],
      date: DateTime.fromMillisecondsSinceEpoch(map['date']), // 밀리초를 DateTime으로 변환하여 저장
      memo: map['memo'],
    );
  }
}

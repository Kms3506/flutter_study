class CalendarMemo {
  final int? id;
  final DateTime date; // 변경된 부분: DateTime 타입으로 변경
  final String memo;

  CalendarMemo({this.id, required this.date, required this.memo});

}

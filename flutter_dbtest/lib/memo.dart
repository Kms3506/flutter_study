class Memo {
  final int? id;
  final String date;
  final String memo;

  Memo({this.id, required this.date, required this.memo});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date,
      'memo': memo,
    };
  }

  @override
  String toString() {
    return 'Memo{id: $id, date: $date, memo: $memo}';
  }
}

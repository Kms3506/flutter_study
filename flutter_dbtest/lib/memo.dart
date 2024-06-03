class Todo {
  int? id;
  String content;

  Todo({this.id, required this.content});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'content': content,
    };
  }
}

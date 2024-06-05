class ListItem1 {
  int? id;
  String content;

  ListItem1({this.id, required this.content});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'content': content,
    };
  }
}
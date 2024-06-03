class TestClass {
  int? id;
  String content;
  String testmemo;

  TestClass({this.id, required this.content, required this.testmemo});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'content': content,
      'memo' : testmemo
    };
  }
}
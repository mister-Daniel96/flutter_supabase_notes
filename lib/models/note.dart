class Note {
  int? id;
  String content;
  String userId; // ahora nullable para evitar errores al crearlo

  Note({this.id, required this.content, required this.userId});

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'] as int,
      content: map['content'] as String,
      userId: map['user_id'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {'content': content, 'user_id': userId};
  }
}

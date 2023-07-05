class MessageModel {
  final String id;
  final String date;
  final String content;
  final String authorId;
  final String username;

  MessageModel({
    required this.id,
    required this.date,
    required this.content,
    required this.authorId,
    required this.username,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
        id: json['id'],
        date: json['date'],
        content: json['content'],
        authorId: json['authorId'],
        username: json['username']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'content': content,
      'authorId': authorId,
      'username': username,
    };
  }
}

class Frame {
  int id;
  String name;
  String content;
  Frame({required this.id, required this.name, required this.content});

  factory Frame.fromJson(Map<String, dynamic> json) {
    return Frame(
      id: json['id'],
      name: json['name'],
      content: json['content'],
    );
  }
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'content': content,
      };
}

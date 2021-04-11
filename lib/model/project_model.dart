class Project {
  int id;
  String name;
  String content;
  Project({required this.id, required this.name, required this.content});

  factory Project.fromJson(Map<String, dynamic> json) => Project(
        id: json['id'],
        name: json['name'],
        content: json['content'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'content': content,
      };
}

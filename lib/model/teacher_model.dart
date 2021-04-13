class Teacher {
  int id;
  String name;
  String image;
  String projects;
  List<dynamic> links;

  Teacher({
    required this.id,
    required this.name,
    required this.image,
    required this.projects,
    required this.links,
  });

  factory Teacher.fromJson(Map<String, dynamic> json) {
    String tempProject = "";
    List<dynamic> listProjs = json['projects'] as List<dynamic>;
    for (int i = 0; i < listProjs.length; i++) {
      if (listProjs[i] == listProjs.last) {
        tempProject += listProjs[i] + ".";
      } else {
        tempProject += listProjs[i] + ", ";
      }
    }
    return Teacher(
        id: json['id'],
        name: json['name'],
        image: json['image'],
        projects: tempProject,
        links: json['links']);
  }
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'image': image,
        'projects': projects,
        'links': links,
      };
}

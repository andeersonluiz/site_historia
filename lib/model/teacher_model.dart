class Teacher {
  int id;
  String name;
  String image;
  String projects;
  List<dynamic> links;
  bool checked;

  Teacher({
    required this.id,
    required this.name,
    required this.image,
    required this.projects,
    required this.links,
    required this.checked,
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
        links: json['links'],
        checked: false);
  }
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'image': image,
        'projects': projects
            .split(",")
            .map((e) => e.replaceAll(",", "").replaceAll(".", "").trim()),
        'links': links,
      };
}

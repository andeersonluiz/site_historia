class Participant {
  String name;
  String status;

  Participant({required this.name, required this.status});

  factory Participant.fromJson(Map<String, dynamic> json) {
    return Participant(
      name: json['name'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'status': status,
      };
}

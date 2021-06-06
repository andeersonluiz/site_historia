/// Modelo da classe Participante.
///
/// {@category Model}
// ignore: library_names
library Participant;
class Participant {
  /// Nome do participante.
  String name;
  /// Status do participante (Se é aluno ou professor).
  String status;

  /// Construtor da classe `Participant`.
  Participant({required this.name, required this.status});

  /// Converter as informações recebidas em `json` do banco de dados para a classe `Participant`.
  factory Participant.fromJson(Map<String, dynamic> json) {
    return Participant(
      name: json['name'],
      status: json['status'],
    );
  }
  /// Converter a classe `Participant` em `json`.
  Map<String, dynamic> toJson() => {
        'name': name,
        'status': status,
      };
}

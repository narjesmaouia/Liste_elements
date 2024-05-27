class ListeElement {
  int? id;
  String nom;
  String description;
  ListeElement({this.id, required this.nom, required this.description});
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "nom": nom,
      "description": description,
    };
  }

  factory ListeElement.fromMap(Map<String, dynamic> map) {
    return ListeElement(
      id: map['id'],
      nom: map['nom'],
      description: map['description'],
      );
  }
}

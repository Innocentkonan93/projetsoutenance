class Villes {
  String id;
  String nom;
  String lati;
  String longi;
  String image;

  Villes({
    this.id,
    this.nom,
    this.lati,
    this.longi,
    this.image,
  });

  Villes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nom = json['nom'];
    lati = json['lati'];
    longi = json['longi'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nom'] = this.nom;
    data['lati'] = this.lati;
    data['longi'] = this.longi;
    data['image'] = this.image;
    return data;
  }
}

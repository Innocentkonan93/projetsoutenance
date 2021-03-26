class Pharms {
  
  String id;
  String nom;
  String responsable;
  String tel;
  String jourGarde;
  String statut;
  String image;
  String lati;
  String longi;
  String idVille;

  Pharms(
      { 
      this.id,
      this.nom,
      this.responsable,
      this.tel,
      this.jourGarde,
      this.statut,
      this.image,
      this.lati,
      this.longi,
      this.idVille});

  Pharms.fromJson(Map<String, dynamic> json) {
   
    id = json['id'];
    nom = json['nom'];
    responsable = json['responsable'];
    tel = json['tel'];
    jourGarde = json['jourGarde'];
    statut = json['statut'];
    image = json['image'];
    lati = json['lati'];
    longi = json['longi'];
    idVille = json['idVille'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    
    data['id'] = this.id;
    data['nom'] = this.nom;
    data['responsable'] = this.responsable;
    data['tel'] = this.tel;
    data['jourGarde'] = this.jourGarde;
    data['statut'] = this.statut;
    data['image'] = this.image;
    data['lati'] = this.lati;
    data['longi'] = this.longi;
    data['idVille'] = this.idVille;
    return data;
  }
}


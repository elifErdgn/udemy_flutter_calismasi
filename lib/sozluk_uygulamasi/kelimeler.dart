/// sqllite
// class Kelimeler {
//   int kelime_id;
//   String ingilizce;
//   String turkce;
//
//   Kelimeler(this.kelime_id, this.turkce, this.ingilizce);
// }

/// http
class Kelimeler {
  String kelime_id;
  String ingilizce;
  String turkce;

  Kelimeler(this.kelime_id, this.turkce, this.ingilizce);

  factory Kelimeler.fromJson(Map<String, dynamic> json) {
    return Kelimeler(
      json["kelime_id"],
      json["ingilizce"],
      json["turkce"],
    );
  }
}

class KelimelerCevap {
  int success;
  List<Kelimeler> kelimelerListesi;

  KelimelerCevap(this.success, this.kelimelerListesi);

  factory KelimelerCevap.fromJson(Map<String, dynamic> json) {
    var jsonArray = json["kelimeler"] as List;
    List<Kelimeler> kelimelerListesi = jsonArray
        .map((jsonArrayNesnesi) => Kelimeler.fromJson(jsonArrayNesnesi))
        .toList();
    return KelimelerCevap(json["success"] as int, kelimelerListesi);
  }
}

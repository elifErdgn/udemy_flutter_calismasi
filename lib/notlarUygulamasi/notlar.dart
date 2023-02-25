///  sqllite
// class Notlar {
//   int not_id;
//   String ders_adi;
//   int not1;
//   int not2;
//
//   Notlar(
//     this.not_id,
//     this.ders_adi,
//     this.not1,
//     this.not2,
//   );
// }

/// http örneği
class Notlar {
  String not_id;
  String ders_adi;
  String not1;
  String not2;

  Notlar(
    this.not_id,
    this.ders_adi,
    this.not1,
    this.not2,
  );

  factory Notlar.fromJson(Map<String, dynamic> json) {
    return Notlar(
      json["json_id"],
      json["ders_adi"],
      json["not1"],
      json["not2"],
    );
  }
}

class NotlarCevap {
  int success;
  List<Notlar> notlarListesi;

  NotlarCevap(this.success, this.notlarListesi);

  factory NotlarCevap.fromJson(Map<String, dynamic> json) {
    var jsonArray = json["notlar"] as List;

    List<Notlar> notlarListesi = jsonArray
        .map((jsonArrayNesnesi) => Notlar.fromJson(jsonArrayNesnesi))
        .toList();
    return NotlarCevap(json["success"] as int,notlarListesi );
  }
}

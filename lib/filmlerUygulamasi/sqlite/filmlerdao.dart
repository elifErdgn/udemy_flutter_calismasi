import 'package:udemy_proje_ornekleri/filmlerUygulamasi/Filmler.dart';
import 'package:udemy_proje_ornekleri/filmlerUygulamasi/Kategoriler.dart';
import 'package:udemy_proje_ornekleri/filmlerUygulamasi/sqlite/veritabaniYardimcisi.dart';

import '../Yonetmenler.dart';

class FilmlerDao {
  Future<List<Filmler>> tumFilmlerByKategoriId(int kategori_id) async {
    var db = await VeritabaniYardimcisi.veritabaniErisim();

    List<Map<String, dynamic>> maps = await db.rawQuery(
        "SELECT * FROM filmler, kategoriler, yonetmenler,WHERE filmler.kategori_id = kategoriler.kategori_id and filmler.yonetmen_id = yonetmenler.yonetmen_id and filmler.kategori.id ");

    return List.generate(maps.length, (i) {
      var satir = maps[i];

      var k = Kategoriler(satir["kategori_id"], satir["kategori_ad"]);
      var y = Yonetmenler(satir["yonetmen_id"], satir["yonetmen_ad"]);
      var f = Filmler(satir["film_id"], satir["film_ad"], satir["film_yil"],
          satir["film_resim"], k, y);
      return f;
    });
  }
}

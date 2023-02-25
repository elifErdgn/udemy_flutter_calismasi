import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:udemy_proje_ornekleri/filmlerUygulamasi/Filmler.dart';
import 'package:udemy_proje_ornekleri/filmlerUygulamasi/FilmlerCevap.dart';

import 'DetaySayfa.dart';
import 'package:http/http.dart' as http;

import 'Kategoriler.dart';

class FilmlerSayfa extends StatefulWidget {
  Kategoriler kategori;

  FilmlerSayfa({required this.kategori});

  @override
  _FilmlerSayfaState createState() => _FilmlerSayfaState();
}

class _FilmlerSayfaState extends State<FilmlerSayfa> {
  /*
  Future<List<Filmler>> filmleriGoster(int kategori_id) async {
    var filmlerListesi = await FilmlerDao().tumFilmlerByKategoriId(kategori_id);

    return filmlerListesi;
  }
  */

  List<Filmler> parseFilmlerCevap(String cevap) {
    return FilmlerCevap.fromJson(json.decode(cevap)).filmlerListesi;
  }


  Future<List<Filmler>> filmleriGoster(int kategori_id) async {
    var url = Uri.parse("uri");
    var veri = {"kategori_id":kategori_id.toString()};
    var cevap = await http.post(url,body: veri);
    return parseFilmlerCevap(cevap.body);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Filmler : ${widget.kategori.kategori_ad}"),
      ),
      body: FutureBuilder(
        future: filmleriGoster(3),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var filmlerListesi = snapshot.data;
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2 / 3.5,
              ),
              itemCount: filmlerListesi!.length,
              itemBuilder: (context, indeks) {
                var film = filmlerListesi[indeks];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetaySayfa(
                                  film: film,
                                )));
                  },
                  child: Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.network(
                              "http://kasimadalan.pe.hu/filmler/resimler/${film.film_resim}"),
                        ),
                        Text(
                          film.film_ad,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return Center();
          }
        },
      ),
    );
  }
}

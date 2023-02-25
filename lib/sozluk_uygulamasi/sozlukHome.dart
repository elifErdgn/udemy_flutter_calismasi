import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:udemy_proje_ornekleri/sozluk_uygulamasi/sozlukDetay.dart';
import 'package:http/http.dart' as http;

import 'kelimeler.dart';

class SozlukUygulamasiHome extends StatefulWidget {
  const SozlukUygulamasiHome({Key? key}) : super(key: key);

  @override
  State<SozlukUygulamasiHome> createState() => _SozlukUygulamasiHomeState();
}

class _SozlukUygulamasiHomeState extends State<SozlukUygulamasiHome> {
  bool aramaYapiliyorMu = false;
  String aramaKelimesi = "";

  List<Kelimeler> parseKelimelerCevap(String cevap) {
    return KelimelerCevap.fromJson(json.decode(cevap)).kelimelerListesi;
  }

  /// yol 1
  /*
  Future<List<Kelimeler>> tumKelimelerGoster() async {
    var kelimelerListesi = <Kelimeler>[];

    var k1 = Kelimeler(1, "köpek", "dog");
    var k2 = Kelimeler(2, "balık", "fish");
    var k3 = Kelimeler(3, "kedi", "cat");
    kelimelerListesi.add(k1);
    kelimelerListesi.add(k2);
    kelimelerListesi.add(k3);

    return kelimelerListesi;
  }
*/

  /*
  /// sql lite
  Future<List<Kelimeler>> tumKelimelerGoster() async {
    var kelimelerListesi = await Kelimelerdao().tumKelimeler();
    return kelimelerListesi;
  }
  Future<List<Kelimeler>> aramaYap(String aramaKelimesi) async {
    var kelimelerListesi = await Kelimelerdao().kelimeAra(aramaKelimesi);
    return kelimelerListesi;
  }*/
  Future<List<Kelimeler>> tumKelimelerGoster() async {
    var url = Uri.parse("api");
    var cevap = await http.get(url);
    return parseKelimelerCevap(cevap.body);
  }

 
  Future<List<Kelimeler>> aramaYap(String aramaKelimesi) async {
    var url = Uri.parse("arama_api");
    var veri = {"ingilizce":aramaKelimesi};
    var cevap = await http.post(url,body: veri);
    return parseKelimelerCevap(cevap.body);
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: aramaYapiliyorMu
            ? Container(
                child: TextField(
                  decoration:
                      InputDecoration(hintText: "Arama için birşey yazın"),
                  onChanged: (aramaSonucu) {
                    print("Arama Sonucu : $aramaSonucu ");
                  },
                ),
              )
            : Text("Sözlük Uygulaması"),
        actions: [
          aramaYapiliyorMu
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      aramaYapiliyorMu = false;
                      aramaKelimesi = "";
                    });
                  },
                  icon: Icon(Icons.cancel),
                )
              : IconButton(
                  onPressed: () {
                    setState(() {
                      aramaYapiliyorMu = true;
                    });
                  },
                  icon: Icon(Icons.search),
                ),
        ],
      ),
      body: FutureBuilder<List<Kelimeler>>(
        future:
            aramaYapiliyorMu ? aramaYap(aramaKelimesi) : tumKelimelerGoster(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var kelimeListesi = snapshot.data;
            return ListView.builder(
              itemBuilder: (context, index) {
                var kelime = kelimeListesi[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SozlukDetayPage(
                                  kelime: kelime,
                                )));
                  },
                  child: SizedBox(
                    height: 50,
                    child: Card(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            kelime.ingilizce,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            kelime.turkce,
                            style: TextStyle(fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              itemCount: kelimeListesi!.length,
            );
          } else {
            return Center();
          }
        },
      ),
    );
  }
}

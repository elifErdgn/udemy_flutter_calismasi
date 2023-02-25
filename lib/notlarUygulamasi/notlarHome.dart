import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:udemy_proje_ornekleri/notlarUygulamasi/notKayitSayfa.dart';
import 'package:udemy_proje_ornekleri/notlarUygulamasi/sqlite/notlardao.dart';

import 'notDetayPage.dart';
import 'notlar.dart';

class NotlarHome extends StatefulWidget {
  const NotlarHome({Key? key}) : super(key: key);

  @override
  State<NotlarHome> createState() => _NotlarHomeState();
}

class _NotlarHomeState extends State<NotlarHome> {
  /// YONTEM 1
  /*
  Future<List<Notlar>> tumNotlarGoster() async {
    var notlarListesi = <Notlar>[];

    var n1 = Notlar(1, "tarih", 60, 40);
    var n2 = Notlar(2, "kimya", 60, 40);
    var n3 = Notlar(3, "fizik", 60, 40);
    var n4 = Notlar(4, "ingilizce", 60, 40);
    notlarListesi.add(n1);
    notlarListesi.add(n2);
    notlarListesi.add(n3);
    notlarListesi.add(n4);

    return notlarListesi;
  }

   */
  /*
  Future<List<Notlar>> tumNotlarGoster() async {

    var notlarListesi = await NotlarDao().tumNotlar();
    return notlarListesi;

  }

  Future<List<Notlar>> uygulamayiKapat() async {
    await exit(0);
  }
*/

  /*
  Future<List<Notlar>> tumNotlarGoster() async {

    var notlarListesi = await NotlarDao().tumNotlar();
    return notlarListesi;

  }

  Future<List<Notlar>> uygulamayiKapat() async {
    await exit(0);
  }
*/

  List<Notlar> parseNotlarCevap(String cevap) {
    return NotlarCevap.fromJson(json.decode(cevap)).notlarListesi;
  }

  /// http
  Future<List<Notlar>> tumNotlarGoster() async {
    var url = Uri.parse("api");

    var cevap = await http.get(url);
    return parseNotlarCevap(cevap.body);
  }

  Future<bool> uygulamayiKapat() async {
    await exit(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            uygulamayiKapat();
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Column(
          children: [
            FutureBuilder(
              future: tumNotlarGoster(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var notlarListesi = snapshot.data;
                  double ortalama = 0.0;

                  if (notlarListesi != null) {
                    double toplam = 0.0;

                    for (var n in notlarListesi) {
                      toplam =
                          toplam + (int.parse(n.not1) + int.parse(n.not2)) / 2;
                    }

                    ortalama = toplam / notlarListesi.length;
                  }
                  return Text("Ortalama : ${ortalama.toInt()} ");
                } else {
                  return Text("Ortalama : 0");
                }
              },
            ),
          ],
        ),
      ),
      body: WillPopScope(
        onWillPop: uygulamayiKapat,
        child: FutureBuilder<List<Notlar>>(
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var notlarListesi = snapshot.data;
              return ListView.builder(
                  itemCount: notlarListesi!.length,
                  itemBuilder: (context, index) {
                    var not = notlarListesi[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NotDetaySayfa(not: not)));
                      },
                      child: Card(
                        child: SizedBox(
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(not.ders_adi),
                              Text(not.not1.toString()),
                              Text(not.not2.toString()),
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            } else {
              return Center();
            }
          },
          future: tumNotlarGoster(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NotKayitSayfa(),
              ));
        },
        tooltip: 'Not Ekle',
        child: Icon(Icons.add),
      ),
    );
  }
}

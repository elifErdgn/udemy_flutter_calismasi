import 'package:flutter/material.dart';
import 'package:udemy_proje_ornekleri/notlarUygulamasi/notlarHome.dart';
import 'package:http/http.dart' as http;

import 'notlar.dart';
import 'sqlite/notlardao.dart';

class NotKayitSayfa extends StatefulWidget {
  @override
  _NotKayitSayfaState createState() => _NotKayitSayfaState();
}

class _NotKayitSayfaState extends State<NotKayitSayfa> {
  var tfDersAdi = TextEditingController();
  var tfnot1 = TextEditingController();
  var tfnot2 = TextEditingController();

  /*
  Future<void> notKayit(String ders_adi, int not1, int not2) async {
    await NotlarDao().notEkle(ders_adi, not1, not2);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => NotlarHome()));
  }

   */

  Future<void> notKayit(String ders_adi, int not1, int not2) async {
    var url = Uri.parse("url");
    var veri = {
      "ders_adi": ders_adi,
      "not1": not1,
      "not2": not2,
    };
    var cevap = await http.post(url, body: veri);
    print("Not ekle cevap: ${cevap.body}");
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => NotlarHome()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Not Kayıt"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 50.0, right: 50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              TextField(
                controller: tfDersAdi,
                decoration: InputDecoration(hintText: "Ders Adı"),
              ),
              TextField(
                controller: tfnot1,
                decoration: InputDecoration(hintText: "1. Not"),
              ),
              TextField(
                controller: tfnot2,
                decoration: InputDecoration(hintText: "2. Not"),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          notKayit(
            tfDersAdi.text,
            int.parse(tfnot1.text),
            int.parse(tfnot2.text),
          );
        },
        tooltip: 'Not Kayıt',
        icon: Icon(Icons.save),
        label: Text("Kaydet"),
      ),
    );
  }
}

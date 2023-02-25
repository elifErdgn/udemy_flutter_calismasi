import 'package:flutter/material.dart';
import 'package:udemy_proje_ornekleri/notlarUygulamasi/sqlite/notlardao.dart';
import 'package:http/http.dart' as http;

import 'notlar.dart';
import 'notlarHome.dart';

class NotDetaySayfa extends StatefulWidget {
  Notlar not;

  NotDetaySayfa({required this.not});

  @override
  _NotDetaySayfaState createState() => _NotDetaySayfaState();
}

class _NotDetaySayfaState extends State<NotDetaySayfa> {
  var tfDersAdi = TextEditingController();
  var tfnot1 = TextEditingController();
  var tfnot2 = TextEditingController();

  @override
  void initState() {
    super.initState();
    var not = widget.not;
    tfDersAdi.text = not.ders_adi;
    tfnot1.text = not.not1.toString();
    tfnot2.text = not.not2.toString();
  }

  /// sqlite
  /*
  Future<void> sil(int not_id) async {
    await NotlarDao().notSil(not_id);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => NotlarHome()));
  }

  Future<void> guncelle(int not_id, String not_adi, int not1, int not2) async {
    await NotlarDao().notGuncelle(not1, not_adi, not2, not_id);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => NotlarHome()));
  }
   */

  /// http
  Future<void> sil(int not_id) async {
    var url = Uri.parse("url");
    var veri = {
      "not_id": not_id.toString(),
    };
    var cevap = await http.post(url, body: veri);
    print("Not sil cevap: ${cevap.body}");
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => NotlarHome()));
  }

  Future<void> guncelle(int not_id, String not_adi, int not1, int not2) async {
    var url = Uri.parse("url");
    var veri = {
      "not_id": not_id.toString(),
      "not_adi": not_id,
      "not1": not1.toString(),
      "not2": not2.toString(),
    };
    var cevap = await http.post(url, body: veri);
    print("Not guncelle cevap: ${cevap.body}");
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => NotlarHome()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Not Detay"),
        actions: [
          TextButton(
            child: Text(
              "Sil",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              sil(int.parse(widget.not.not_id));
            },
          ),
          TextButton(
            child: Text(
              "Güncelle",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              guncelle(int.parse(widget.not.not1), tfDersAdi.text,
                  int.parse(tfnot1.text), int.parse(tfnot2.text));
            },
          ),
        ],
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
    );
  }
}

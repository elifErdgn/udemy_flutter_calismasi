import 'package:flutter/material.dart';
import 'Kisiler.dart';
import 'kisiler_home.dart';
import 'sqlite/kisilerdao.dart';

class KisiDetaySayfa extends StatefulWidget {
  Kisiler kisi;

  KisiDetaySayfa({required this.kisi});

  @override
  _KisiDetaySayfaState createState() => _KisiDetaySayfaState();
}

class _KisiDetaySayfaState extends State<KisiDetaySayfa> {
  var tfKisiAdi = TextEditingController();
  var tfKisiTel = TextEditingController();

  @override
  void initState() {
    super.initState();
    var kisi = widget.kisi;
    tfKisiAdi.text = kisi.kisi_ad;
    tfKisiTel.text = kisi.kisi_tel;
  }


  Future<void> guncelle(int kisi_id,String kisi_ad, String kisi_tel) async {
    await KisilerDao().kisiGuncelle(kisi_id, kisi_ad,kisi_tel);
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Anasayfa(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kişi Detay"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 50, right: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              TextField(
                controller: tfKisiAdi,
                decoration: InputDecoration(hintText: "Kişi Ad"),
              ),
              TextField(
                controller: tfKisiTel,
                decoration: InputDecoration(hintText: "Kişi Tel"),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        tooltip: 'Kişi Güncelle',
        icon: Icon(Icons.update),
        label: Text("Güncelle"),
      ),
    );
  }
}

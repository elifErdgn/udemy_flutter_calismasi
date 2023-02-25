import 'dart:io';

import 'package:flutter/material.dart';
import 'package:udemy_proje_ornekleri/kisilerUygulamasi/sqlite/kisilerdao.dart';

import 'KisiDetaySayfa.dart';
import 'KisiKayitSayfa.dart';
import 'Kisiler.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Anasayfa(),
    );
  }
}

class Anasayfa extends StatefulWidget {
  @override
  _AnasayfaState createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  bool aramaYapiliyorMu = false;
  String aramaKelimesi = "";

  Future<List<Kisiler>> tumKisileriGoster() async {
    var kisilerListesi = await KisilerDao().tumKisiler();

    return kisilerListesi;
  }

  Future<List<Kisiler>> aramaYap(String aramaKelimesi) async {
    var kisilerListesi = await KisilerDao().kisiAra(aramaKelimesi);
    return kisilerListesi;
  }

  Future<void> sil(int kisi_id) async {
    await KisilerDao().kisiSil(kisi_id);
    setState(() {});
  }

  Future<bool> uygulamayiKapat() async {
    await exit(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            uygulamayiKapat();
          },
        ),
        title: aramaYapiliyorMu
            ? TextField(
                decoration:
                    InputDecoration(hintText: "Arama için birşey yazın"),
                onChanged: (aramaSonucu) {
                  print("Arama sonucu : $aramaSonucu");
                  setState(() {
                    aramaKelimesi = aramaSonucu;
                  });
                },
              )
            : Text("Kişiler Uygulaması"),
        actions: [
          aramaYapiliyorMu
              ? IconButton(
                  icon: Icon(Icons.cancel),
                  onPressed: () {
                    setState(() {
                      aramaYapiliyorMu = false;
                      aramaKelimesi = "";
                    });
                  },
                )
              : IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    setState(() {
                      aramaYapiliyorMu = true;
                    });
                  },
                ),
        ],
      ),
      body: WillPopScope(
        onWillPop: uygulamayiKapat,
        child: FutureBuilder<List<Kisiler>>(
          future:
              aramaYapiliyorMu ? aramaYap(aramaKelimesi) : tumKisileriGoster(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var kisilerListesi = snapshot.data;
              return ListView.builder(
                itemCount: kisilerListesi!.length,
                itemBuilder: (context, indeks) {
                  var kisi = kisilerListesi[indeks];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => KisiDetaySayfa(
                                    kisi: kisi,
                                  )));
                    },
                    child: Card(
                      child: SizedBox(
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              kisi.kisi_ad,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(kisi.kisi_tel),
                            IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: Colors.black54,
                              ),
                              onPressed: () {
                                sil(int.parse(kisi.kisi_id));
                              },
                            ),
                          ],
                        ),
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => KisiKayitSayfa()));
        },
        tooltip: 'Kişi Ekle',
        child: Icon(Icons.add),
      ),
    );
  }
}

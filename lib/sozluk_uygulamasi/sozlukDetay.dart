import 'package:flutter/material.dart';
import 'package:udemy_proje_ornekleri/sozluk_uygulamasi/kelimeler.dart';

class SozlukDetayPage extends StatefulWidget {
  Kelimeler kelime;

  SozlukDetayPage({required this.kelime});

  @override
  State<SozlukDetayPage> createState() => _SozlukDetayPageState();
}

class _SozlukDetayPageState extends State<SozlukDetayPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detay Sayfası"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            widget.kelime.ingilizce,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            widget.kelime.turkce, 
            style: TextStyle(fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}

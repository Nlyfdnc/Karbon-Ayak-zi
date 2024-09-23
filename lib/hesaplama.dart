import 'dart:ffi';

import 'package:carbonayak/auth_service.dart';
import 'package:carbonayak/bilgi.dart';
import 'package:carbonayak/grafik.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class HesapPage extends StatefulWidget {
  const HesapPage({super.key});

  @override
  State<HesapPage> createState() => _HesapPageState();
}

class _HesapPageState extends State<HesapPage> {
  int _index = 0;
  List pages = [anaPage(), Grafik(), bilgi()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_index],
      bottomNavigationBar: CurvedNavigationBar(
        items: [Icon(Icons.home), Icon(Icons.area_chart), Icon(Icons.info)],
        index: _index,
        onTap: (int i) {
          setState(() {
            _index = i;
          });
        },
        color: Color(0xff6A9C89),
        backgroundColor: Color(0xff16423C),
        buttonBackgroundColor: Color(0xff6A9C89),
      ),
      backgroundColor: Color(0xffE9EFEC),
      appBar: AppBar(
        title: Text(
          "Hoş Geldin!",
          style: TextStyle(color: Color(0xff16423C)),
        ),
        backgroundColor: Color(0xff6A9C89),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xff6A9C89),
              ),
              child: Text(
                'Menü',
                style: TextStyle(
                  color: Color(0xff16423C),
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.home,
                color: Color(0xff16423C),
                size: 33,
              ),
              title: Text(
                'Ana Sayfa',
                style: TextStyle(color: Color(0xff16423C), fontSize: 17),
              ),
              onTap: () {
                // Ana sayfaya yönlendir
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.account_circle,
                color: Color(0xff16423C),
                size: 33,
              ),
              title: Text(
                'Profil',
                style: TextStyle(color: Color(0xff16423C), fontSize: 17),
              ),
              onTap: () {
                // Ana sayfaya yönlendir
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.settings,
                color: Color(0xff16423C),
                size: 33,
              ),
              title: Text(
                'Ayarlar',
                style: TextStyle(color: Color(0xff16423C), fontSize: 17),
              ),
              onTap: () {
                // Ayarlar sayfasına yönlendir
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.info,
                color: Color(0xff16423C),
                size: 33,
              ),
              title: Text(
                'Hakkında',
                style: TextStyle(color: Color(0xff16423C), fontSize: 17),
              ),
              onTap: () {
                // Hakkında sayfasına yönlendir
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class anaPage extends StatefulWidget {
  const anaPage({super.key});

  @override
  State<anaPage> createState() => _anaPageState();
}

class _anaPageState extends State<anaPage> {
  TextEditingController _aractip = TextEditingController();
  String aracTip = '';
  TextEditingController _yakitTuketimi = TextEditingController();
  double yakitTuketimi = 0.0;
  TextEditingController _mesafe = TextEditingController();
  double mesafe = 0.0;
  TextEditingController _elektrik = TextEditingController();
  double elektrik = 0.0;
  TextEditingController _dogalGaz = TextEditingController();
  double dogalGaz = 0.0;
  TextEditingController _beslenmeTarzi = TextEditingController();
  String beslenmeTarzi = '';
  TextEditingController _gidaKaynagi = TextEditingController();
  String gidaKaynagi = '';
  TextEditingController _atikMik = TextEditingController();
  double atikMik = 0.0;
  TextEditingController _geriDonusum = TextEditingController();
  double geriDonusum = 0.0;
  TextEditingController _suKullanimi = TextEditingController();
  double suKullanimi = 0.0;
  double toplamKarbonAyakIzi=0.0;

  double hesaplaKarbonAyakIzi() {
  // Araç
  double aracEmisyon = 0.0;
  if (aracTip.isNotEmpty && yakitTuketimi > 0) {
  aracEmisyon = (yakitTuketimi / 100) * 2.31 * mesafe; // Basit bir hesap
  }

  // Elektrik
  double elektrikEmisyon = elektrik * 0.92; // Elektrik tüketimi için ortalama emisyon

  // Doğalgaz
  double dogalGazEmisyon = dogalGaz * 2.75; // Doğalgaz tüketimi için ortalama emisyon

  // Beslenme
  double beslenmeEmisyon = beslenmeTarzi == 'vegan' ? 0.5 : 1.5; // Basit bir tahmin

  // Atık
  double atikEmisyon = atikMik * 0.5; // Atık miktarı için basit bir hesap

  // Geri dönüşüm
  double geriDonusumEmisyon = geriDonusum * -0.2; // Geri dönüşüm katkısı

  // Su kullanımı
  double suEmisyon = suKullanimi * 0.02; // Su kullanımı için ortalama emisyon

  // Toplam Karbon Ayak İzi
  double toplamKarbonAyakIzi = aracEmisyon + elektrikEmisyon + dogalGazEmisyon +
  beslenmeEmisyon + atikEmisyon +
  geriDonusumEmisyon + suEmisyon;

  return toplamKarbonAyakIzi;
}

  void _verileriKaydet() async {
    // Kullanıcının girdiği bilgileri al
    String aracTip = _aractip.text;
    double yakitTuketimi = double.tryParse(_yakitTuketimi.text) ?? 0.0;
    double mesafe = double.tryParse(_mesafe.text) ?? 0.0;
    double elektrik = double.tryParse(_elektrik.text) ?? 0.0;
    double dogalGaz = double.tryParse(_dogalGaz.text) ?? 0.0;
    String beslenmeTarzi = _beslenmeTarzi.text;
    double atikMik = double.tryParse(_atikMik.text) ?? 0.0;
    double geriDonusum = double.tryParse(_geriDonusum.text) ?? 0.0;
    double suKullanimi = double.tryParse(_suKullanimi.text) ?? 0.0;

    // Karbon ayak izini hesapla
    setState(() {
      toplamKarbonAyakIzi = hesaplaKarbonAyakIzi(); // Burada state değişkenine atıyoruz
    });

    // Firebase'e kaydet
    await FirebaseFirestore.instance.collection('karbonAyakIzleri').add({
      'aracTip': aracTip,
      'yakitTuketimi': yakitTuketimi,
      'mesafe': mesafe,
      'elektrik': elektrik,
      'dogalGaz': dogalGaz,
      'beslenmeTarzi': beslenmeTarzi,
      'atikMik': atikMik,
      'geriDonusum': geriDonusum,
      'suKullanimi': suKullanimi,
      'toplamKarbonAyakIzi': toplamKarbonAyakIzi,
    });

    // Hesaplanan değeri kullanıcıya göster
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Toplam Karbon Ayak İzin: ${toplamKarbonAyakIzi.toStringAsFixed(2)} kg CO2 ve bilgiler kaydedildi!"),
    ));
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Bilgilerini girerek şimdi karbon ayak izini hesapla!",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xff16423C),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(16.0), // Dış kenarlıklar için padding
            decoration: BoxDecoration(
              color: Color(0xff6A9C89)
                  .withOpacity(0.5), // Container arka plan rengi
              borderRadius: BorderRadius.circular(8.0), // Köşe yuvarlatma
              border:
                  Border.all(color: Color(0xff16423C), width: 3), // Kenarlık
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2), // Gölge rengi
                  spreadRadius: 4, // Gölgenin yayılma oranı
                  blurRadius: 5, // Gölgenin bulanıklık oranı
                  offset: Offset(0, 3), // Gölge konumu
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Align(
                    alignment: Alignment.centerLeft, // Sola yaslar
                    child: Text(
                      "Ulaşım alışkanlıkları:",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff16423C),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Araç Tipi: ",
                          style: TextStyle(
                            color: Color(0xff16423C),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: TextField(
                          controller: _aractip,
                          onChanged: (aracTip) {
                            setState(() {
                              this.aracTip = aracTip; // aracTip değişkenini güncelle
                            });
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color(0xffC4DAD2).withOpacity(0.7),
                            hintText: 'Araç tipiniz ',
                            labelText: 'Araba, Otobüs,Tren...',
                            labelStyle: TextStyle(color: Color(0xff16423C)),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xff16423C), width: 3),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xff16423C), width: 2),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Yakıt Tüketimi: ",
                          style: TextStyle(
                            color: Color(0xff16423C),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: TextField(
                          controller: _yakitTuketimi,
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            setState(() {
                              yakitTuketimi = double.tryParse(value) ?? 0.0; // Dönüştürme yap ve 0.0 ata
                            });
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color(0xffC4DAD2).withOpacity(0.7),
                            hintText: 'Litre Cinsinden',
                            labelText: 'Araba Kullanıyorsanız',
                            labelStyle: TextStyle(color: Color(0xff16423C)),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xff16423C), width: 3),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xff16423C), width: 2),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Mesafe:  ",
                          style: TextStyle(
                            color: Color(0xff16423C),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: TextField(
                          controller: _mesafe,
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            setState(() {
                              mesafe = double.tryParse(value) ?? 0.0; // Dönüştürme yap ve 0.0 ata
                            });
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color(0xffC4DAD2).withOpacity(0.7),
                            hintText: 'Mesafeniz',
                            labelText: 'Km cinsinden',
                            labelStyle: TextStyle(color: Color(0xff16423C)),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xff16423C), width: 3),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xff16423C), width: 2),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.all(16.0), // Dış kenarlıklar için padding
            decoration: BoxDecoration(
              color: Color(0xff6A9C89)
                  .withOpacity(0.5), // Container arka plan rengi
              borderRadius: BorderRadius.circular(8.0), // Köşe yuvarlatma
              border:
                  Border.all(color: Color(0xff16423C), width: 3), // Kenarlık
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2), // Gölge rengi
                  spreadRadius: 4, // Gölgenin yayılma oranı
                  blurRadius: 5, // Gölgenin bulanıklık oranı
                  offset: Offset(0, 3), // Gölge konumu
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Align(
                    alignment: Alignment.centerLeft, // Sola yaslar
                    child: Text(
                      "Enerji Tüketimi: ",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff16423C),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Elektrik Tüketimi: ",
                          style: TextStyle(
                            color: Color(0xff16423C),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: TextField(
                          controller: _elektrik,
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            setState(() {
                              elektrik = double.tryParse(value) ?? 0.0; // Dönüştürme yap ve 0.0 ata
                            });
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color(0xffC4DAD2).withOpacity(0.7),
                            hintText: 'Tükettiğiniz elektrik (kWh)',
                            labelText: 'Aylık faturadaki elektrik tüketimi',
                            labelStyle: TextStyle(color: Color(0xff16423C)),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xff16423C), width: 3),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xff16423C), width: 2),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Doğal gaz veya ısınma: ",
                          style: TextStyle(
                            color: Color(0xff16423C),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: TextField(
                          controller: _dogalGaz,
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            setState(() {
                              dogalGaz = double.tryParse(value) ?? 0.0; // Dönüştürme yap ve 0.0 ata
                            });
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color(0xffC4DAD2).withOpacity(0.7),
                            hintText: 'Doğalgaz Tüketiminiz (m\u00B3)',
                            labelText: 'Aylık kullandığınız doğal gaz',
                            labelStyle: TextStyle(color: Color(0xff16423C)),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xff16423C), width: 3),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xff16423C), width: 2),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.all(16.0), // Dış kenarlıklar için padding
            decoration: BoxDecoration(
              color: Color(0xff6A9C89)
                  .withOpacity(0.5), // Container arka plan rengi
              borderRadius: BorderRadius.circular(8.0), // Köşe yuvarlatma
              border:
                  Border.all(color: Color(0xff16423C), width: 3), // Kenarlık
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2), // Gölge rengi
                  spreadRadius: 4, // Gölgenin yayılma oranı
                  blurRadius: 5, // Gölgenin bulanıklık oranı
                  offset: Offset(0, 3), // Gölge konumu
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Align(
                    alignment: Alignment.centerLeft, // Sola yaslar
                    child: Text(
                      "Yeme Alışkanlıkları:  ",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff16423C),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Beslenme Tarzı: ",
                          style: TextStyle(
                            color: Color(0xff16423C),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: TextField(
                          controller: _beslenmeTarzi,
                          onChanged: (beslenmeTarzi) {
                            setState(() {
                              this.beslenmeTarzi = beslenmeTarzi; // aracTip değişkenini güncelle
                            });
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color(0xffC4DAD2).withOpacity(0.7),
                            hintText: 'Beslenme Tarzınız',
                            labelText: 'Et ağırlıklı, vejetaryen veya vegan',
                            labelStyle: TextStyle(color: Color(0xff16423C)),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xff16423C), width: 3),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xff16423C), width: 2),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Gıda Kaynağı: ",
                          style: TextStyle(
                            color: Color(0xff16423C),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: TextField(
                          controller: _gidaKaynagi,
                          onChanged: (gidaKaynagi) {
                            setState(() {
                              this.gidaKaynagi = gidaKaynagi; // aracTip değişkenini güncelle
                            });
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color(0xffC4DAD2).withOpacity(0.7),
                            hintText: 'Gıda Kaynağınız',
                            labelText: 'Yerel veya İthal',
                            labelStyle: TextStyle(color: Color(0xff16423C)),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xff16423C), width: 3),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xff16423C), width: 2),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.all(16.0), // Dış kenarlıklar için padding
            decoration: BoxDecoration(
              color: Color(0xff6A9C89)
                  .withOpacity(0.5), // Container arka plan rengi
              borderRadius: BorderRadius.circular(8.0), // Köşe yuvarlatma
              border:
                  Border.all(color: Color(0xff16423C), width: 3), // Kenarlık
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2), // Gölge rengi
                  spreadRadius: 4, // Gölgenin yayılma oranı
                  blurRadius: 5, // Gölgenin bulanıklık oranı
                  offset: Offset(0, 3), // Gölge konumu
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Align(
                    alignment: Alignment.centerLeft, // Sola yaslar
                    child: Text(
                      "Atık Yönetimi:",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff16423C),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Atık miktarı:",
                          style: TextStyle(
                            color: Color(0xff16423C),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: TextField(
                          controller: _atikMik,
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            setState(() {
                              atikMik = double.tryParse(value) ?? 0.0; // Dönüştürme yap ve 0.0 ata
                            });
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color(0xffC4DAD2).withOpacity(0.7),
                            hintText: 'Kg cinsinden',
                            labelText: 'Ayda ne kadar çöp üretiyorsunuz',
                            labelStyle: TextStyle(color: Color(0xff16423C)),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xff16423C), width: 3),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xff16423C), width: 2),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Geri Dönüşüm: ",
                          style: TextStyle(
                            color: Color(0xff16423C),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: TextField(
                          controller: _geriDonusum,
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            setState(() {
                              geriDonusum = double.tryParse(value) ?? 0.0; // Dönüştürme yap ve 0.0 ata
                            });
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color(0xffC4DAD2).withOpacity(0.7),
                            hintText: 'Plastik, Kağıt , Cam',
                            labelText: 'Geri dönüştürdüğünüz atıkların miktarı',
                            labelStyle: TextStyle(color: Color(0xff16423C)),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xff16423C), width: 3),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xff16423C), width: 2),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.all(16.0), // Dış kenarlıklar için padding
            decoration: BoxDecoration(
              color: Color(0xff6A9C89)
                  .withOpacity(0.5), // Container arka plan rengi
              borderRadius: BorderRadius.circular(8.0), // Köşe yuvarlatma
              border:
                  Border.all(color: Color(0xff16423C), width: 3), // Kenarlık
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2), // Gölge rengi
                  spreadRadius: 4, // Gölgenin yayılma oranı
                  blurRadius: 5, // Gölgenin bulanıklık oranı
                  offset: Offset(0, 3), // Gölge konumu
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Align(
                    alignment: Alignment.centerLeft, // Sola yaslar
                    child: Text(
                      "Su Tüketimi:",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff16423C),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Kişisel su kullanımı:",
                          style: TextStyle(
                            color: Color(0xff16423C),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: TextField(
                          controller: _suKullanimi,
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            setState(() {
                              suKullanimi = double.tryParse(value) ?? 0.0; // Dönüştürme yap ve 0.0 ata
                            });
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color(0xffC4DAD2).withOpacity(0.7),
                            hintText: 'Litre cinsinden',
                            labelText: 'Duş, temizlik, bahçe sulama...',
                            labelStyle: TextStyle(color: Color(0xff16423C)),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xff16423C), width: 3),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xff16423C), width: 2),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor:Color(0xff6A9C89),
                  foregroundColor: Color(0xff16423C),
                ),
                onPressed: () {
                  _verileriKaydet();

                },
                child: Text("Karbon Ayak İzi Hesapla"),
              ),
            ],
          ),
          SizedBox(height: 10),
          // İstatistikler Kartı
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text("Son Durum"),
                  Text("Karbon Ayak İzin: ${toplamKarbonAyakIzi.toStringAsFixed(2)} kg CO2"), // Hesaplanan değeri göster
                  // Grafik veya başka istatistikler eklenebilir
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

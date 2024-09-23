
import 'package:carbonayak/hesaplama.dart';
import 'package:flutter/material.dart';
import 'package:carbonayak/user_service.dart';

class KayitSayfasi extends StatefulWidget {
  const KayitSayfasi({super.key});

  @override
  State<KayitSayfasi> createState() => _KayitSayfasiState();
}

class _KayitSayfasiState extends State<KayitSayfasi> {
  String? secilenCinsiyet; // Seçilen cinsiyet bilgisi
  TextEditingController _ad = TextEditingController();
  String ad ='';
  TextEditingController _soyad = TextEditingController();
  String soyAd ='';
  TextEditingController _Dtarih = TextEditingController();
  String tarih ='';
  TextEditingController _cinsiyet = TextEditingController();
  String cinsiyet ='';
  TextEditingController _eposta = TextEditingController();
  String ePosta='';
  TextEditingController _sifre = TextEditingController();
  String sifre='';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE9EFEC),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xff6A9C89),
        title: Text("Kayıt Olun"),
        foregroundColor: Color(0xff16423C),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                "Bilgilerinizi Doldurun",
                style: TextStyle(
                  color: Color(0xff16423C),
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 30), // Boşluk
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xff6A9C89), // Container arka plan rengi
                  border: Border.all(color: Color(0xff16423C), width: 3), // Kenarlık
                  borderRadius: BorderRadius.circular(8.0), // Kenar yuvarlama
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2), // Gölgenin rengi
                      spreadRadius: 4, // Gölgenin yayılma oranı
                      blurRadius: 5, // Gölgenin bulanıklık oranı
                      offset: Offset(0, 3), // Gölgenin konumu
                    ),
                  ],
                ),
                padding: EdgeInsets.all(16.0), // İçerik için padding
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Adınız: ",
                              style: TextStyle(
                                color: Color(0xff16423C),
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2, // Bu kısım daha fazla yer kaplar
                            child: TextField(
                              controller: _ad,
                              onChanged: (ad) {
                                setState(() {});
                              },
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Color(0xffC4DAD2).withOpacity(0.7),
                                hintText: 'Kullanıcı Adınız',
                                labelText: 'Kullanıcı adı',
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xff16423C), width: 3),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xff16423C), width: 2),
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
                              "Soy Adınız: ",
                              style: TextStyle(
                                color: Color(0xff16423C),
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2, // Bu kısım daha fazla yer kaplar
                            child: TextField(
                              controller: _soyad,
                              onChanged: (soyAd) {
                                setState(() {});
                              },
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Color(0xffC4DAD2).withOpacity(0.7),
                                hintText: 'Soy Adınız',
                                labelText: 'Soy Ad',
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xff16423C), width: 3),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xff16423C), width: 2),
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
                              "Cinsiyetiniz:  ",
                              style: TextStyle(
                                color: Color(0xff16423C),
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2, // Bu kısım daha fazla yer kaplar
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                color: Color(0xffC4DAD2).withOpacity(0.7), // Buton arka plan rengi
                                borderRadius: BorderRadius.circular(5), // Köşe yuvarlama
                                border: Border.all(color:  Color(0xff16423C), width: 3), // Kenar çizgisi
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: DropdownButton<String>(
                                      value: secilenCinsiyet,
                                      hint: Text("Cinsiyet Seçin"),
                                      items: <String>['Kadın', 'Erkek'].map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          secilenCinsiyet = newValue;
                                        });
                                      },
                                      style: TextStyle(
                                        color: Colors.black, // Seçilen öğe metin rengi
                                        fontSize: 18, // Metin boyutu
                                      ),
                                      dropdownColor: Color(0xffC4DAD2).withOpacity(0.7), // Dropdown açılır menü arka plan rengi
                                      underline: SizedBox(),
                                      icon: SizedBox.shrink(),// Alt çizgiyi kaldırmak için boş widget
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_drop_down_circle,
                                    color: Color(0xff16423C),
                                  ),
                                ],
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
                              "Doğum Tarihi: ",
                              style: TextStyle(
                                color: Color(0xff16423C),
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2, // Bu kısım daha fazla yer kaplar
                            child: TextField(
                              controller: _Dtarih,
                              onChanged: (tarih) {
                                setState(() {});
                              },
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Color(0xffC4DAD2).withOpacity(0.7),
                                hintText: 'Doğum tarihiniz',
                                labelText: 'GG/AA/YY',
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xff16423C), width: 3),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xff16423C), width: 2),
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
                              "E-postanız: ",
                              style: TextStyle(
                                color: Color(0xff16423C),
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2, // Bu kısım daha fazla yer kaplar
                            child: TextField(
                              controller: _eposta,
                              onChanged: (ePosta) {
                                setState(() {});
                              },
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Color(0xffC4DAD2).withOpacity(0.7),
                                hintText: 'E-posta Adresiniz: ',
                                labelText: 'karbonayakizi@karbon.com',
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xff16423C), width: 3),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xff16423C), width: 2),
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
                              "Şifreniz: ",
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
                              controller: _sifre,
                              obscureText: true,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Color(0xffC4DAD2).withOpacity(0.7),
                                hintText: 'Şifreniz',
                                labelText: 'Şifre',
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xff16423C), width: 3),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xff16423C), width: 2),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.all(10),
                        shape: ContinuousRectangleBorder(),
                        foregroundColor: Color(0xff16423C),
                      ),
                      onPressed: () async {
                        String firstName = _ad.text;
                        String lastName = _soyad.text;
                        String dateOfBirth = _Dtarih.text; // GG-AA-YY formatında olduğundan emin olun
                        String gender = secilenCinsiyet ?? '';
                        String email = _eposta.text;
                        String password = _sifre.text;

                        // Kayıt işlemi ve Firestore'a veri ekleme
                        await registerUser(firstName, lastName, dateOfBirth, gender, password, email);

                        // Kayıt tamamlanınca yönlendirme
                        Route uygPage = MaterialPageRoute(builder: (context) {
                          return HesapPage();
                        });
                        Navigator.pushReplacement(context, uygPage);
                      },
                      child: Text("ÜYE OL"),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

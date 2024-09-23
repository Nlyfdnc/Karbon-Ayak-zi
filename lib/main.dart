import 'package:carbonayak/hesaplama.dart';
import 'package:carbonayak/kayit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _eposta = TextEditingController();
  TextEditingController _sifre = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;
  String? currentUserId; // Kullanıcı kimliğini saklamak için değişken

  void _girisYap() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _eposta.text.trim(),
        password: _sifre.text.trim(),
      );

      // Giriş başarılıysa, kullanıcı kimliğini al
      String userId = userCredential.user?.uid ?? '';

      // Kullanıcı kimliğini sakla
      currentUserId = userId;

      // Ana sayfaya yönlendir
      Route uygPage = MaterialPageRoute(builder: (context) {
        return HesapPage(); // Gidilecek sayfa
      });
      Navigator.pushReplacement(context, uygPage);
    } catch (e) {
      // Hata mesajını göster
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Giriş başarısız: ${e.toString()}"),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE9EFEC),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xff6A9C89),
        title: Text("Karbon Ayak İzi Hesaplama"),
        foregroundColor: Color(0xff16423C),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Text(
                "Giriş Sayfası",
                style: TextStyle(
                  color: Color(0xff16423C),
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "Geleceği Korumak İçin Bugün Adım Atın!",
                style: TextStyle(
                  color: Color(0xff16423C),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xff6A9C89),
                  border: Border.all(color: Color(0xff16423C), width: 3),
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 4,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: TextField(
                        controller: _eposta,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xffC4DAD2).withOpacity(0.7),
                          hintText: 'E-posta',
                          labelText: 'Kullanıcı adı',
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
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: TextField(
                        controller: _sifre,
                        obscureText: true,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xffC4DAD2).withOpacity(0.7),
                          hintText: 'Şifrenizi Girin',
                          labelText: 'Şifre',
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
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.all(10),
                        shape: ContinuousRectangleBorder(),
                        foregroundColor: Color(0xff16423C),
                        backgroundColor: Color(0xffC4DAD2),
                        side: BorderSide(
                          color: Color(0xff16423C),
                          width: 3,
                        ),
                      ),
                      onPressed: _girisYap,
                      child: Text("GİRİŞ"),
                    ),
                    TextButton(
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.all(10),
                        shape: ContinuousRectangleBorder(),
                        foregroundColor: Color(0xffC4DAD2),
                      ),
                      onPressed: () {
                        Route kayit_Sayfasi = MaterialPageRoute(builder: (context) {
                          return KayitSayfasi();
                        });
                        Navigator.push(context, kayit_Sayfasi);
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

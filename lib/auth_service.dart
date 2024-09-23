import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> kaydetKarbonAyakIzi(
    String aracTip,
    double yakitTuketimi,
    double mesafe,
    double elektrik,
    double dogalGaz,
    String beslenmeTarzi,
    double atikMik,
    double geriDonusum,
    double suKullanimi) async {
  try {
    // Firestore'a karbon ayak izi verilerini kaydet
    await FirebaseFirestore.instance.collection('karbonAyakIzleri').add({
      'aracTip': aracTip,
      'yakıtTüketimi': yakitTuketimi,
      'mesafe': mesafe,
      'elektrik': elektrik,
      'doğalgaz': dogalGaz,
      'beslenmeTarzi': beslenmeTarzi,
      'atikMik': atikMik,
      'geriDonusum': geriDonusum,
      'suKullanimi': suKullanimi,
      'createdAt': FieldValue.serverTimestamp(), // Zaman damgası
    });

    print("Karbon ayak izi başarıyla kaydedildi.");
  } catch (e) {
    print("Kayıt hatası: $e");
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> registerUser(
    String firstName,
    String lastName,
    String dateOfBirth,
    String gender,
    String password,
    String email
    ) async {
  try {
    // Firebase Authentication ile kullanıcı kaydı
    UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    // Kullanıcı başarıyla oluşturulursa UID al
    User? newUser = userCredential.user;

    if (newUser != null) {
      String userId = newUser.uid;

      // Firestore'a kullanıcı verilerini kaydet
      await FirebaseFirestore.instance.collection('users').doc(userId).set({
        'firstName': firstName,
        'lastName': lastName,
        'dateOfBirth': dateOfBirth,
        'gender': gender,
        'email': email,
        'createdAt': FieldValue.serverTimestamp(),
      });

      print("Kullanıcı başarıyla kaydedildi.");
    }
  }
  catch (e) {
    print("Kayıt hatası: $e");
  }
}

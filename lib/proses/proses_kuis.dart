import 'package:cloud_firestore/cloud_firestore.dart';

Future buatKuis(String namaKuis) async {
  if (namaKuis.isNotEmpty) {
    try {
      // Menyimpan data ke Firestore
      DocumentReference docRef =
          await FirebaseFirestore.instance.collection('kuis').add({
        'nama_kuis': namaKuis,
        'created_at': FieldValue.serverTimestamp(),
      });

      print('Data successfully added!');
      return await docRef.id;
    } catch (e) {
      print('Error: $e');
    }
  } else {
    print('Please fill all fields.');
  }
}

Future<void> hapusKuis(String idKuis) async {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  DocumentReference docRef = await _db.collection('kuis').doc(idKuis);
  print(docRef);

  await docRef.delete();
}

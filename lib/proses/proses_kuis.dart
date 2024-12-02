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

// Olah pertanyaan

Future<void> tambahPertanyaan(String idKuis, Map<String, dynamic> data) async {
  final DocumentReference document =
      FirebaseFirestore.instance.collection('kuis').doc(idKuis);

  try {
    // Ambil dokumen untuk mendapatkan daftar pertanyaan yang ada
    DocumentSnapshot snapshot = await document.get();

    if (snapshot.exists) {
      // Ambil data 'daftar_pertanyaan'
      List daftarPertanyaan = snapshot['daftar_pertanyaan'] ?? {};

      // Hitung jumlah pertanyaan yang ada
      int jumlahPertanyaan = daftarPertanyaan.length;

      // Tentukan key pertanyaan baru berdasarkan jumlah pertanyaan yang ada
      String keyPertanyaanBaru = 'pertanyaan_${jumlahPertanyaan + 1}';

      // Buat data pertanyaan baru
      Map<String, dynamic> pertanyaanBaru = {keyPertanyaanBaru: data};

      // Menambahkan pertanyaan baru ke daftar pertanyaan
      await document.update({
        'daftar_pertanyaan': FieldValue.arrayUnion([pertanyaanBaru]),
      });

      print('Pertanyaan baru berhasil ditambahkan!');
    } else {
      print('Dokumen tidak ditemukan');
    }
  } catch (e) {
    print('Gagal menambahkan pertanyaan: $e');
  }
}

import 'package:flutter/material.dart';
import 'package:quiz_app/halaman/mahasiswa/halaman_kuis_mhs/halaman_bermain_kuis.dart';
import 'package:quiz_app/halaman/mahasiswa/navbar_mhs.dart';
import 'package:quiz_app/proses/proses_kuis.dart';

class HalamanKuisMhs extends StatefulWidget {
  final String idKuis;

  const HalamanKuisMhs({Key? key, required this.idKuis}) : super(key: key);

  @override
  State<HalamanKuisMhs> createState() => _HalamanKuisMhsState();
}

class _HalamanKuisMhsState extends State<HalamanKuisMhs> {
  late Future<Map<String, dynamic>> kuis;

  @override
  void initState() {
    super.initState();
    kuis = getQuizById(widget.idKuis);
  }

  @override
  Widget build(BuildContext context) {
    final double tinggiLayar = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: tinggiLayar,
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 40.0,
              ),
              Row(
                children: [
                  Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                          icon: Icon(Icons.arrow_back),
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => NavbarMahasiswa()),
                                (route) => false);
                          })),
                  SizedBox(
                    width: 15.0,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Mainkan Kuis",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              FutureBuilder<Map<String, dynamic>>(
                future: kuis,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // Menampilkan indikator loading saat data sedang dimuat
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    // Menampilkan pesan error jika ada
                    return Center(
                      child: Text('Terjadi kesalahan: ${snapshot.error}'),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    // Menampilkan pesan jika data kosong
                    return Center(child: Text('Data kuis tidak ditemukan.'));
                  }

                  // Data berhasil dimuat
                  final kuisData = snapshot.data!;
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          kuisData['nama'],
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 30),
                        Text(
                            'Jumlah Pertanyaan: ${kuisData['daftar_pertanyaan'].length}'),
                        SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  blurRadius: 5,
                                  offset: Offset(0, 2), // Shadow position
                                ),
                              ],
                            ),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors
                                    .transparent, // Transparent untuk Decoration
                                shadowColor: Colors
                                    .transparent, // Hilangkan shadow default
                                padding: EdgeInsets.symmetric(vertical: 16.0),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        HalamanBermainKuis(kuis: kuisData),
                                  ),
                                );
                              },
                              child: SizedBox(
                                width: 150.0,
                                height: 30.0,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Mulai kuis",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

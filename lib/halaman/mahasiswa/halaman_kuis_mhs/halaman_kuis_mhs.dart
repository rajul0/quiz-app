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
  late Future<List<Map<String, dynamic>>?> riwayatKuis;

  @override
  void initState() {
    super.initState();
    kuis = getQuizById(widget.idKuis);
    riwayatKuis = getQuizHistory(
        int.parse(widget.idKuis), 3); // Adjust function as needed
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
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Terjadi kesalahan: ${snapshot.error}'),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('Data kuis tidak ditemukan.'));
                  }

                  final kuisData = snapshot.data!;

                  return Column(
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
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
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
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      FutureBuilder<List<Map<String, dynamic>>?>(
                        future: riwayatKuis,
                        builder: (context, historySnapshot) {
                          if (historySnapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else if (historySnapshot.hasError) {
                            return Center(
                              child: Text(
                                  'Terjadi kesalahan: ${historySnapshot.error}'),
                            );
                          } else if (!historySnapshot.hasData ||
                              historySnapshot.data!.isEmpty) {
                            return Center(
                                child:
                                    Text('Belum pernah mengikuti kuis ini.'));
                          }

                          final historyData = historySnapshot.data!;
                          print(historyData);

                          return Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Container(
                              padding: EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                width: 2.0,
                                color: Colors.black,
                              )),
                              child: Column(
                                children: historyData.map((history) {
                                  return Column(
                                    children: [
                                      ListTile(
                                        title: Text(
                                          'Nilai: ${history['nilai']}',
                                          style: TextStyle(
                                              color: Colors.deepPurple,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        subtitle: Text(
                                            'Tanggal: ${history['attempt_date']}'),
                                      ),
                                      Divider(
                                        color: Colors.black.withOpacity(0.75),
                                        thickness: 2.0,
                                      )
                                    ],
                                  );
                                }).toList(),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
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

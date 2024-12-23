import 'package:flutter/material.dart';
import 'package:quiz_app/halaman/mahasiswa/halaman_kuis_mhs/halaman_detail_riwayat_kuis_mhs.dart';
import 'package:quiz_app/halaman/mahasiswa/navbar_mhs.dart';
import 'package:quiz_app/proses/proses_kuis.dart';

class HalamanDaftarRiwayatKuisMhs extends StatefulWidget {
  @override
  _HalamanDaftarRiwayatKuisMhsState createState() =>
      _HalamanDaftarRiwayatKuisMhsState();
}

class _HalamanDaftarRiwayatKuisMhsState
    extends State<HalamanDaftarRiwayatKuisMhs> {
  late Future<List<Map<String, dynamic>>> quizzes;

  @override
  void initState() {
    super.initState();
    quizzes = getQuizHistoryByUser(3);
  }

  @override
  Widget build(BuildContext context) {
    final double tinggiLayar = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        height: tinggiLayar,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 60.0,
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NavbarMahasiswa()),
                        (route) => false);
                  },
                  icon: Icon(Icons.arrow_back),
                ),
                Text(
                  'Daftar Kuis',
                  style: TextStyle(color: Colors.black, fontSize: 18.0),
                ),
              ],
            ),
            FutureBuilder<List<Map<String, dynamic>>>(
              future: quizzes,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('Tidak ada kuis ditemukan.'));
                }

                var quizzes = snapshot.data!;
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: quizzes.length,
                  itemBuilder: (context, index) {
                    final quiz = quizzes[index];
                    return ListTile(
                      title: Text("${quiz["nama"]}"),
                      trailing: IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    HalamanDetailRiwayatKuisMhs(
                                        idKuis: quiz["id"], idUser: 3)),
                          ).then((_) => setState(() async =>
                              quizzes = await getQuizHistoryByUser(3)));
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

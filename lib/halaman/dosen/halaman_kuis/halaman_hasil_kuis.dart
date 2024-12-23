import 'package:flutter/material.dart';
import 'package:quiz_app/halaman/dosen/halaman_kuis/component/class_kuis.dart';
import 'package:quiz_app/halaman/dosen/halaman_kuis/halaman_hasil_per_kuis.dart';
import 'package:quiz_app/halaman/dosen/navbar_dosen.dart';
import 'package:quiz_app/proses/proses_kuis.dart';

class HalamanHasilKuisDosen extends StatefulWidget {
  @override
  _HalamanHasilKuisDosenState createState() => _HalamanHasilKuisDosenState();
}

class _HalamanHasilKuisDosenState extends State<HalamanHasilKuisDosen> {
  late Future<List<Quiz>> quizzes;

  @override
  void initState() {
    super.initState();
    quizzes = daftarSemuaKuis();
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
                        MaterialPageRoute(builder: (context) => NavbarDosen()),
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
            FutureBuilder<List<Quiz>>(
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
                      title: Text(quiz.nama),
                      trailing: IconButton(
                        icon: Text(
                          "Lihat Hasil >",
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.6),
                              fontSize: 12.0),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    HalamanHasilPerKuis(idKuis: quiz.id)),
                          ).then((_) => setState(
                              () async => quizzes = await daftarSemuaKuis()));
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

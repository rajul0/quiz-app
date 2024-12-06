import 'package:flutter/material.dart';
import 'package:quiz_app/halaman/dosen/halaman_kuis/component/card_pertanyaan.dart';
import 'package:quiz_app/halaman/dosen/halaman_kuis/halaman_buat_pertanyaan/halaman_buat_pertanyaan_essai.dart';
import 'package:quiz_app/halaman/dosen/halaman_kuis/halaman_buat_pertanyaan/halaman_buat_pertanyaan_ganda.dart';
import 'package:quiz_app/halaman/dosen/halaman_kuis/halaman_buat_pertanyaan/halaman_buat_pertanyaan_isian_singkat.dart';
import 'package:quiz_app/halaman/dosen/halaman_kuis/halaman_daftar_kuis.dart';
import 'package:quiz_app/halaman/dosen/navbar_dosen.dart';
import 'package:quiz_app/proses/proses_kuis.dart';

class HalamanKuis extends StatefulWidget {
  final String idKuis;
  final String namaKuis;
  const HalamanKuis({Key? key, required this.idKuis, required this.namaKuis})
      : super(key: key);

  @override
  State<HalamanKuis> createState() => _HalamanKuisState();
}

class _HalamanKuisState extends State<HalamanKuis> {
  late Future<Map> daftarPertanyaan;
  bool hasQuestions = true;

  @override
  void initState() {
    super.initState();
    daftarPertanyaan = fetchQuestions(widget.idKuis);
  }

  Future<Map> fetchQuestions(String idKuis) async {
    final response = await daftarPertanyaaKuis(idKuis);
    setState(() {
      hasQuestions = response["daftar_pertanyaan"].isNotEmpty;
    });

    return response;
  }

  void _hapusKuis() {
    hapusKuis(widget.idKuis);
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => NavbarDosen()),
      (route) => false,
    );
  }

  Future _showBackDialog() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Kuis harus memiliki minimal 1 pertanyaan, buat pertanyaan?',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.0,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              _hapusKuis();
            },
            child: Text(
              'Hapus',
              style: TextStyle(
                color: Colors.red,
                fontSize: 14.0,
              ),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "Tambah pertanyaan",
              style: TextStyle(color: Colors.black, fontSize: 14.0),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double tinggiLayar = MediaQuery.of(context).size.height;
    return FutureBuilder<Map>(
        future: daftarPertanyaan,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          var _daftarPertanyaan = snapshot.data?["daftar_pertanyaan"];
          return PopScope(
            canPop: hasQuestions,
            onPopInvoked: (didPop) async {
              if (didPop) return;

              final shouldPop = await _showBackDialog() ?? false;
              if (context.mounted && shouldPop) {
                Navigator.pop(context);
              }
            },
            child: Scaffold(
              body: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 67.0,
                    horizontal: 10.0,
                  ),
                  child: Container(
                    height: tinggiLayar,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Align(
                                alignment: Alignment.topLeft,
                                child: IconButton(
                                    icon: Icon(Icons.arrow_back),
                                    onPressed: hasQuestions
                                        ? () {
                                            Navigator.pushAndRemoveUntil(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      HalamanDaftarKuis(),
                                                ),
                                                (route) => false);
                                          }
                                        : () async {
                                            final shouldPop =
                                                await _showBackDialog() ??
                                                    false;
                                            if (context.mounted && shouldPop) {
                                              Navigator.pop(context);
                                            }
                                          })),
                            SizedBox(
                              width: 15.0,
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                widget.namaKuis,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: hasQuestions
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: ListView.builder(
                                      shrinkWrap: true, // Tambahkan ini
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: _daftarPertanyaan!.length,
                                      itemBuilder: (context, index) {
                                        final pertanyaan =
                                            _daftarPertanyaan[index];
                                        return buildCardPertanyaan(
                                          context,
                                          pertanyaan["pertanyaan"],
                                          true,
                                          () {
                                            // Aksi untuk tombol hapus
                                            print(
                                                'Pertanyaan "${pertanyaan["pertanyaan"]}" dihapus');
                                          },
                                        );
                                      },
                                    ),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: Text(
                                      "Pertanyaan Masih Kosong, Tambahkan Pertanyaan",
                                      style: TextStyle(
                                        color: Colors.black.withOpacity(0.5),
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              floatingActionButton: FloatingActionButton.extended(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled:
                        true, // Mengizinkan kontrol tinggi popup
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    builder: (BuildContext context) {
                      return DraggableScrollableSheet(
                        initialChildSize: 0.5, // Setengah layar
                        minChildSize: 0.25, // Tinggi minimal
                        maxChildSize: 0.8, // Tinggi maksimal
                        expand: false,
                        builder: (context, scrollController) {
                          return Container(
                            padding: EdgeInsets.all(16),
                            child: ListView(
                              controller:
                                  scrollController, // Scroll untuk isi popup
                              children: [
                                Text(
                                  'Pilih Jenis Pertanyaan',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 30.0),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            HalamanBuatPertanyaanGanda(
                                          idKuis: widget.idKuis,
                                          namaKuis: widget.namaKuis,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    'Pilihan ganda',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14.0,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 15),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            HalamanBuatPertanyaanIsianSingkat(
                                          idKuis: widget.idKuis,
                                          namaKuis: widget.namaKuis,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    'Isian singkat',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14.0,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 15),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            HalamanBuatPertanyaanEssai(
                                          idKuis: widget.idKuis,
                                          namaKuis: widget.namaKuis,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    'Essai',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  );
                },
                label: Text(
                  'Tambah Pertanyaan',
                  style: TextStyle(color: Colors.black.withOpacity(0.5)),
                ), // Teks tambahan
                icon: Icon(
                  Icons.add,
                  color: Colors.black.withOpacity(0.5),
                ), // Ikon di sebelah teks
                backgroundColor: Colors.white,
              ),
            ),
          );
        });
  }
}

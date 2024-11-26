import 'package:flutter/material.dart';
import 'package:quiz_app/halaman/dosen/halaman_kelas/halaman_buat_pertanyaan/halaman_buat_pertanyaan_ganda.dart';
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
  void _hapusKuis() {
    hapusKuis(widget.idKuis);
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => NavbarDosen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 67.0,
            horizontal: 37.0,
          ),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                    onPressed: () {
                      showDialog(
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
                                style: TextStyle(
                                    color: Colors.black, fontSize: 14.0),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                    iconSize: 25.0,
                    icon: Icon(
                      Icons.arrow_back,
                    )),
              ),
              SizedBox(
                height: 30.0,
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
              SizedBox(
                height: 60.0,
              ),
              Container(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Pertanyaan Masih Kosong, Tambahkan Pertanyaan",
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.5),
                      fontSize: 16,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true, // Mengizinkan kontrol tinggi popup
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
                      controller: scrollController, // Scroll untuk isi popup
                      children: [
                        Text(
                          'Pilih Jenis Pertanyaan',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 30),
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
                          onPressed: () {},
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
                          onPressed: () {},
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
    );
  }
}

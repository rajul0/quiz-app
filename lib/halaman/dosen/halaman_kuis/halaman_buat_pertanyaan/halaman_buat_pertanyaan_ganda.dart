import 'package:flutter/material.dart';
import 'package:quiz_app/halaman/dosen/halaman_kuis/halaman_buat_pertanyaan/halaman_buat_pertanyaan_essai.dart';
import 'package:quiz_app/halaman/dosen/halaman_kuis/halaman_buat_pertanyaan/halaman_buat_pertanyaan_isian_singkat.dart';
import 'package:quiz_app/halaman/dosen/halaman_kuis/halaman_kuis.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:quiz_app/proses/proses_kuis.dart';

class HalamanBuatPertanyaanGanda extends StatefulWidget {
  final String idKuis;
  final String namaKuis;
  const HalamanBuatPertanyaanGanda(
      {Key? key, required this.idKuis, required this.namaKuis})
      : super(key: key);

  @override
  State<HalamanBuatPertanyaanGanda> createState() =>
      _HalamanBuatPertanyaanGandaState();
}

class _HalamanBuatPertanyaanGandaState
    extends State<HalamanBuatPertanyaanGanda> {
  final _formKey = GlobalKey<FormState>();

  int _time = 30;
  int _point = 1;
  String _jenisPertanyaan = 'Pilihan ganda';
  String? jawaban;

  List<String> _semuaJenisPertanyaan = [
    "Pilihan ganda",
    "Isian singkat",
    "Essai"
  ];

  final TextEditingController pertanyaan = TextEditingController();
  final TextEditingController jawaban1 = TextEditingController();
  final TextEditingController jawaban2 = TextEditingController();
  final TextEditingController jawaban3 = TextEditingController();
  final TextEditingController jawaban4 = TextEditingController();

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      List<Map<String, dynamic>> dataPertanyaan = [
        {
          'jenis_pertanyaan': _jenisPertanyaan,
          'waktu_pertanyaan': _time,
          'nilai': _point,
          'pertanyaan': pertanyaan.text,
          'opsi': [
            jawaban1.text,
            jawaban2.text,
            jawaban3.text,
            jawaban4.text,
          ],
          'jawaban': jawaban,
        }
      ];

      showDialog(
        context: context,
        barrierDismissible: false, // Mencegah dialog ditutup tanpa selesai
        builder: (context) => Center(
          child: CircularProgressIndicator(),
        ),
      );

      try {
        await tambahPertanyaan(widget.idKuis, dataPertanyaan);

        // Menutup dialog loading setelah berhasil
        Navigator.pop(context);

        // Menampilkan dialog sukses
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Pertanyaan ditambah')),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                HalamanKuis(idKuis: widget.idKuis, namaKuis: widget.namaKuis),
          ),
        );
      } catch (e) {
        // Menutup dialog loading jika terjadi kesalahan
        Navigator.pop(context);

        // Menampilkan dialog error
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text('Terjadi kesalahan: $e'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Tutup',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        );
      }
    }
  }

  Future _showBackDialog() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Perubahan tidak akan disimpan, yakin ingin menghapus?',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.0,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => HalamanKuis(
                      idKuis: widget.idKuis, namaKuis: widget.namaKuis),
                ),
                (route) => false,
              );
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
              "Lanjutkan mengedit",
              style: TextStyle(color: Colors.black, fontSize: 14.0),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 65.0,
            horizontal: 15.0,
          ),
          child: Column(
            children: [
              PopScope(
                child: SizedBox(),
                canPop: false,
                onPopInvoked: (
                  bool didPop,
                ) async {
                  if (didPop) {
                    return;
                  }
                  final bool shouldPop = await _showBackDialog() ?? false;
                  if (context.mounted && shouldPop) {
                    Navigator.pop(context);
                  }
                },
              ),
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                    onPressed: () {
                      _showBackDialog();
                    },
                    iconSize: 25.0,
                    icon: Icon(
                      Icons.arrow_back,
                    )),
              ),
              SizedBox(
                height: 30.0,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Field 1
                    Container(
                      height: 150.0,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                          style: BorderStyle.solid,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: TextFormField(
                        controller: pertanyaan,
                        textAlign: TextAlign.center,
                        maxLines: null,
                        decoration: InputDecoration(
                          labelText: 'Masukkan pertanyaan anda',
                          border: InputBorder.none,
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Pertanyaan harus diisi';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 35.0),
                    // Field 2
                    TextFormField(
                      controller: jawaban1,
                      maxLength: 30,
                      decoration: InputDecoration(
                        labelText: 'Tambahkan opsi 1',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Opsi 1 harus di isi';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    // Field 3
                    TextFormField(
                      controller: jawaban2,
                      maxLength: 30,
                      decoration: InputDecoration(
                        labelText: 'Tambahkan opsi 2',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Opsi 2 harus di isi';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    // Field 4
                    TextFormField(
                      controller: jawaban3,
                      maxLength: 30,
                      decoration: InputDecoration(
                        labelText: 'Tambahkan opsi 3',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 16),
                    // Field 5
                    TextFormField(
                      controller: jawaban4,
                      maxLength: 30,
                      decoration: InputDecoration(
                        labelText: 'Tambahkan opsi 4',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 24),
                    // Submit Button
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        backgroundColor: Color(0xFFE6E6FA),
        overlayColor: Colors.black.withOpacity(0.5),
        overlayOpacity: 0.5,
        children: [
          SpeedDialChild(
            child: Icon(Icons.check_box),
            label: '$_point point',
            onTap: () async {
              int? selected = await showMenu<int>(
                context: context,
                position: RelativeRect.fromLTRB(
                  screenWidth / 2,
                  screenHeight / 1.5,
                  80,
                  0,
                ), // Atur posisi sesuai kebutuhan
                items: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10].map((int value) {
                  return PopupMenuItem<int>(
                    value: value,
                    child: Text('$value'),
                  );
                }).toList(),
              );

              if (selected != null) {
                setState(() {
                  _point = selected;
                });
              }
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.access_time),
            label: '$_time detik',
            onTap: () async {
              int? selected = await showMenu<int>(
                context: context,
                position: RelativeRect.fromLTRB(
                  screenWidth / 2,
                  screenHeight / 1.5,
                  80,
                  0,
                ), // Atur posisi sesuai kebutuhan
                items: [
                  5,
                  10,
                  15,
                  20,
                  30,
                  45,
                  60,
                ].map((int value) {
                  return PopupMenuItem<int>(
                    value: value,
                    child: Text('$value detik'),
                  );
                }).toList(),
              );

              if (selected != null) {
                setState(() {
                  _time = selected;
                });
              }
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.check_circle),
            label: '$_jenisPertanyaan',
            onTap: () async {
              int? selected = await showMenu<int>(
                context: context,
                position: RelativeRect.fromLTRB(
                  screenWidth / 2,
                  screenHeight / 1.5,
                  80,
                  0,
                ), // Atur posisi sesuai kebutuhan
                items: [0, 1, 2].map((int value) {
                  return PopupMenuItem<int>(
                    value: value,
                    child: Text(_semuaJenisPertanyaan[value]),
                  );
                }).toList(),
              );

              if (selected != null) {
                setState(() {
                  _jenisPertanyaan = _semuaJenisPertanyaan[selected];
                });
                if (_jenisPertanyaan == "Isian singkat") {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HalamanBuatPertanyaanIsianSingkat(
                            namaKuis: widget.namaKuis, idKuis: widget.idKuis)),
                    (route) => false,
                  );
                } else if (_jenisPertanyaan == "Essai") {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HalamanBuatPertanyaanEssai(
                          namaKuis: widget.namaKuis, idKuis: widget.idKuis),
                    ),
                    (route) => false,
                  );
                }
              }
            },
          ),
        ],
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            popUpTanyaJawaban(context, [
              jawaban1.text,
              jawaban2.text,
              jawaban3.text,
              jawaban4.text,
            ]);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFFE6E6FA), // Warna latar tombol
            foregroundColor: Colors.black, // Warna teks tombol
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            textStyle: TextStyle(
              fontSize: 16,
            ),
          ),
          child: Text('Simpan pertanyaan'),
        ),
      ),
    );
  }

  Future<void> popUpTanyaJawaban(
      BuildContext context, List<String> options) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Yang mana jawabannya?'),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: options.map((option) {
                  return RadioListTile<String>(
                    title: Text(option),
                    value: option,
                    groupValue: jawaban,
                    onChanged: (value) {
                      setState(() {
                        jawaban = value;
                      });
                    },
                  );
                }).toList(),
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog tanpa menyimpan
              },
              child: Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                _submitForm();
              },
              child: Text('Submit'),
            ),
          ],
        );
      },
    );
  }
}

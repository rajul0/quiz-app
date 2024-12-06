import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:quiz_app/halaman/dosen/halaman_kuis/halaman_buat_pertanyaan/halaman_buat_pertanyaan_ganda.dart';
import 'package:quiz_app/halaman/dosen/halaman_kuis/halaman_buat_pertanyaan/halaman_buat_pertanyaan_isian_singkat.dart';
import 'package:quiz_app/halaman/dosen/halaman_kuis/halaman_kuis.dart';

class HalamanBuatPertanyaanEssai extends StatefulWidget {
  final String idKuis;
  final String namaKuis;
  const HalamanBuatPertanyaanEssai(
      {Key? key, required this.idKuis, required this.namaKuis})
      : super(key: key);

  @override
  State<HalamanBuatPertanyaanEssai> createState() =>
      _HalamanBuatPertanyaanEssaiState();
}

class _HalamanBuatPertanyaanEssaiState
    extends State<HalamanBuatPertanyaanEssai> {
  int _time = 30;
  int _point = 1;
  String _jenisPertanyaan = 'Essai';

  List<String> _semuaJenisPertanyaan = [
    "Pilihan ganda",
    "Isian singkat",
    "Essai"
  ];

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
      body: Column(
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
          SizedBox(
            height: 100.0,
          ),
          GestureDetector(
            onTap: () {
              _showBackDialog();
            },
            child: Text("Kembali"),
          )
        ],
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
                } else if (_jenisPertanyaan == "Pilihan ganda") {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HalamanBuatPertanyaanGanda(
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
    );
  }
}

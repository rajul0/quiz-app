import 'package:flutter/material.dart';
import 'package:quiz_app/halaman/dosen/navbar_dosen.dart';
import 'package:quiz_app/proses/proses_kuis.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

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

  int time = 30;
  int point = 1;
  String jenisPertanyaan = 'Pilihan ganda';

  final TextEditingController pertanyaan = TextEditingController();
  final TextEditingController jawaban1 = TextEditingController();
  final TextEditingController jawaban2 = TextEditingController();
  final TextEditingController jawaban3 = TextEditingController();
  final TextEditingController jawaban4 = TextEditingController();

  void _hapusKuis() {
    hapusKuis(widget.idKuis);
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => NavbarDosen()),
      (route) => false,
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Proses data jika valid
      print('Field 1: ${pertanyaan.text}');
      print('Field 2: ${jawaban1.text}');
      print('Field 3: ${jawaban2.text}');
      print('Field 4: ${jawaban3.text}');
      print('Field 5: ${jawaban4.text}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Form Submitted!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 67.0,
            horizontal: 15.0,
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
                                // _hapusKuis();
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
                    ElevatedButton(
                      onPressed: _submitForm,
                      child: Text('Submit'),
                    ),
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
            label: '$point point',
            onTap: () => print('Point pertanyaan'),
          ),
          SpeedDialChild(
            child: Icon(Icons.access_time),
            label: '$time detik',
            onTap: () => print('Waktu pertanyaan'),
          ),
          SpeedDialChild(
            child: Icon(Icons.check_circle),
            label: '$jenisPertanyaan',
            onTap: () => print('Jenis pertanyaan'),
          ),
        ],
      ),
    );
  }
}

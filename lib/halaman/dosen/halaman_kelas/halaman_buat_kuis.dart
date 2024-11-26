import 'package:flutter/material.dart';
import 'package:quiz_app/halaman/dosen/halaman_kelas/halaman_kuis.dart';
import 'package:quiz_app/proses/proses_kuis.dart';

class HalamanBuatKuis extends StatefulWidget {
  const HalamanBuatKuis({super.key});

  @override
  State<HalamanBuatKuis> createState() => _BerandaMahasiswaState();
}

class _BerandaMahasiswaState extends State<HalamanBuatKuis> {
  final _formKey = GlobalKey<FormState>();
  final _textController = TextEditingController();

  String idKuis = '';

  @override
  void dispose() {
    _textController.dispose(); // Bersihkan controller saat widget dihancurkan
    super.dispose();
  }

  void _buatKuis() async {
    if (_formKey.currentState!.validate()) {
      // Ambil data dari TextFormField
      final namaKuis = _textController.text;
      try {
        idKuis = await buatKuis(namaKuis);
        print(idKuis);
      } catch (e) {
        print(e);
      }
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Kuis berhasil dibuat'),
          content: Text('Nama kuis : $namaKuis'),
          actions: [
            TextButton(
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          HalamanKuis(idKuis: idKuis, namaKuis: namaKuis))),
              child: Text(
                'OK',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Padding(
          padding: EdgeInsets.symmetric(vertical: 67.0, horizontal: 37.0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    iconSize: 25.0,
                    icon: Icon(
                      Icons.arrow_back,
                    )),
              ),
              SizedBox(
                height: screenHeight / 4,
              ),
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: _textController,
                      decoration: InputDecoration(
                        labelText: 'Masukkan nama kuis',
                        labelStyle: TextStyle(
                          color: Color(0xFF000000).withOpacity(0.5),
                        ),
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color(0xFF000000).withOpacity(0.5),
                              width: 2.0), // Border saat enabled
                          borderRadius:
                              BorderRadius.circular(8.0), // Sudut melengkung
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.black,
                              width: 2.0), // Border saat focused
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.red,
                              width: 2.0), // Border saat error
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Harap memasukkan nama kuis';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: _buatKuis,
                      child: Text(
                        'Mulai membuat',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}

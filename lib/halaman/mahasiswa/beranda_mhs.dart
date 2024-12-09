import 'package:flutter/material.dart';
import 'package:quiz_app/halaman/mahasiswa/daftar_quiz_mhs.dart';
import 'package:quiz_app/halaman/mahasiswa/halaman_kuis_mhs/halaman_gabung_kuis.dart';
import 'package:quiz_app/halaman/mahasiswa/hasil_quiz_mhs.dart';

class BerandaMahasiswa extends StatefulWidget {
  const BerandaMahasiswa({super.key});

  @override
  State<BerandaMahasiswa> createState() => _BerandaMahasiswaState();
}

class _BerandaMahasiswaState extends State<BerandaMahasiswa> {
  // ignore: unused_field
  String _searchKeyword = "";

  // ignore: unused_field
  String _errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 67.0, horizontal: 37.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 270.0,
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          _searchKeyword = value;
                          _errorMessage = '';
                        });
                      },
                      decoration: InputDecoration(
                        labelStyle: TextStyle(
                          color: Color(0xFF000000).withOpacity(0.5),
                        ),
                        hintText: 'Cari',
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(right: 15.0),
                          child: Image.asset(
                            "assets/icon/search-ic.png",
                            width: 20.0,
                          ),
                        ),
                        suffixIconConstraints: BoxConstraints(
                          minWidth: 0,
                          minHeight: 0,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 15.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25.0)),
                          borderSide: BorderSide(
                            color: Color(0xFF000000).withOpacity(0.5),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25.0)),
                          borderSide: BorderSide(
                            color: Color(0xFF000000).withOpacity(0.5),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25.0)),
                          borderSide: BorderSide(
                            color: Color(0xFF000000).withOpacity(0.5),
                          ),
                        ),
                      ),
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 14,
                        color: Color(0xFF000000).withOpacity(0.5),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  Image.asset(
                    "assets/icon/notif-ic.png",
                    width: 30.0,
                  ),
                ],
              ),
              SizedBox(
                height: 90.0,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HalamanGabungKuis()));
                  },
                  child: Container(
                    width: 150,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.black,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(25.0)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add_circle),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          "Gabung Kuis",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14.0,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 25.0,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HalamanDaftarQuizMHS()));
                },
                child: Container(
                  width: double.infinity,
                  height: 169.0,
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xFF000000),
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Text("Daftar Kuis",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.0,
                          fontFamily: "Inter",
                        )),
                  ),
                ),
              ),
              SizedBox(
                height: 45.0,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HalamanHasilQuizMHS()));
                },
                child: Container(
                  width: double.infinity,
                  height: 169.0,
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xFF000000),
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Text("Hasil Kuis",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.0,
                          fontFamily: "Inter",
                        )),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

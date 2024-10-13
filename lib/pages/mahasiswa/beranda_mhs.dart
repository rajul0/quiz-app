import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/pages/mahasiswa/daftar_quiz_mhs.dart';
import 'package:quiz_app/pages/mahasiswa/hasil_quiz_mhs.dart';

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
      bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Colors.white,
          color: Color(0xFFE6E6FA),
          animationDuration: Duration(milliseconds: 300),
          onTap: (index) {
            print(index);
          },
          items: [
            Image.asset("assets/icon/home-ic.png", width: 25.0),
            Image.asset("assets/icon/announcement-ic.png", width: 25.0),
            Image.asset("assets/icon/profil-ic.png", width: 25.0)
          ]),
    );
  }
}

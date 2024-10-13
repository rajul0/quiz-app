import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/pages/mahasiswa/daftar_quiz_mhs.dart';
import 'package:quiz_app/pages/mahasiswa/hasil_quiz_mhs.dart';

class BerandaAdmin extends StatefulWidget {
  const BerandaAdmin({super.key});

  @override
  State<BerandaAdmin> createState() => _BerandaMahasiswaState();
}

class _BerandaMahasiswaState extends State<BerandaAdmin> {
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
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.person_outline_rounded,
                        size: 35.0,
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Halo Mustapa",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14.0,
                                fontFamily: "Inter",
                              )),
                          Text("Admin",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14.0,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.bold,
                              )),
                        ],
                      ),
                    ],
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
                    child: Text("Manajemen Kuis",
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
                    child: Text("Laporan Aktifitas",
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

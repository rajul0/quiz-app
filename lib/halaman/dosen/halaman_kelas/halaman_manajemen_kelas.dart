import 'package:flutter/material.dart';
import 'package:quiz_app/halaman/dosen/halaman_kelas/halaman_buat_kuis.dart';

class HalamanManajemenKelasDosen extends StatefulWidget {
  const HalamanManajemenKelasDosen({super.key});

  @override
  State<HalamanManajemenKelasDosen> createState() => _BerandaMahasiswaState();
}

class _BerandaMahasiswaState extends State<HalamanManajemenKelasDosen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 67.0, horizontal: 37.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
                height: 90.0,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HalamanBuatKuis()));
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  width: 160.0,
                  height: 80.0,
                  decoration: BoxDecoration(
                    color: Color(0xFFE6E6FA),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.add,
                        size: 28.0,
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                      Text(
                        "Buat Kuis",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14.0,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 45.0,
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  width: 160.0,
                  height: 80.0,
                  decoration: BoxDecoration(
                    color: Color(0xFFE6E6FA),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.add,
                        size: 28.0,
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                      Text(
                        "Buat Kelas",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14.0,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 45.0,
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  width: 160.0,
                  height: 80.0,
                  decoration: BoxDecoration(
                    color: Color(0xFFE6E6FA),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.edit_note,
                        size: 35.0,
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                      Text(
                        "Edit Kuis",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14.0,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 45.0),
              GestureDetector(
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  width: 160.0,
                  height: 80.0,
                  decoration: BoxDecoration(
                    color: Color(0xFFE6E6FA),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.calendar_month_rounded,
                        size: 28.0,
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                      Text(
                        "Jadwal Kuis",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14.0,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 45.0),
              GestureDetector(
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  width: 160.0,
                  height: 80.0,
                  decoration: BoxDecoration(
                    color: Color(0xFFE6E6FA),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.list,
                        size: 28.0,
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                      Text(
                        "Daftar Kelas",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14.0,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

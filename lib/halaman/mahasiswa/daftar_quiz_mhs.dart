import 'package:flutter/material.dart';

class HalamanDaftarQuizMHS extends StatefulWidget {
  const HalamanDaftarQuizMHS({super.key});

  @override
  State<HalamanDaftarQuizMHS> createState() => _HalamanDaftarQuizMHSState();
}

class _HalamanDaftarQuizMHSState extends State<HalamanDaftarQuizMHS> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 67.0, horizontal: 37.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                ),
              ),
              SizedBox(
                width: 15.0,
              ),
              Text(
                "Daftar Kuis",
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: "Inter",
                  fontSize: 18.0,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 90.0,
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
          SizedBox(
            height: 65.0,
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
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
                    Icons.play_arrow_outlined,
                    size: 28.0,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    "Mulai Kuis",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.0,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }
}

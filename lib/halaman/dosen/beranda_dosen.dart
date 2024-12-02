import 'package:flutter/material.dart';
import 'package:quiz_app/halaman/dosen/halaman_kelas/halaman_manajemen_kelas.dart';

class BerandaDosen extends StatefulWidget {
  const BerandaDosen({super.key});

  @override
  State<BerandaDosen> createState() => _BerandaMahasiswaState();
}

class _BerandaMahasiswaState extends State<BerandaDosen> {
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
                          Text("Halo Nadia",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14.0,
                                fontFamily: "Inter",
                              )),
                          Text("Dosen",
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
                  Navigator.of(context).push(_createRoute());
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
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/icon/manage-quiz.png",
                        width: 170.0,
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text("Manajemen Kelas",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.0,
                              fontFamily: "Inter",
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 45.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => HalamanHasilQuizMHS()));
                    },
                    child: Container(
                      width: 140.0,
                      height: 100.0,
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0xFF000000),
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.query_stats_outlined,
                            size: 50.0,
                          ),
                          Align(
                            alignment: Alignment.topCenter,
                            child: Text("Statistik Kuis",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14.0,
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => HalamanHasilQuizMHS()));
                    },
                    child: Container(
                      width: 140.0,
                      height: 100.0,
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0xFF000000),
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.quiz_outlined,
                            size: 50.0,
                          ),
                          Align(
                            alignment: Alignment.topCenter,
                            child: Text("Hasil Kuis",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14.0,
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        HalamanManajemenKelasDosen(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0); // Start from below the screen
      const end = Offset.zero; // End at the current position
      const curve = Curves.easeInOut;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);

      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  );
}

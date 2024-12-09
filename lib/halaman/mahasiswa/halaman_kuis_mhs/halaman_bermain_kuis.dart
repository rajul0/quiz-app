import 'dart:async';
import 'package:flutter/material.dart';

class HalamanBermainKuis extends StatefulWidget {
  final Map<String, dynamic> kuis;

  const HalamanBermainKuis({Key? key, required this.kuis}) : super(key: key);

  @override
  State<HalamanBermainKuis> createState() => _HalamanBermainKuisState();
}

class _HalamanBermainKuisState extends State<HalamanBermainKuis> {
  int _currentQuestionIndex = 0;
  int _score = 0;
  int _remainingTime = 0;
  late Timer _timer;
  bool isPaused = false;
  String? idKuis;

  @override
  void initState() {
    super.initState();
    // idKuis = widget.kuis["id"];
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel(); // Pastikan timer dihentikan saat widget dihancurkan
    super.dispose();
  }

  void _startTimer() {
    final waktuPertanyaan = widget.kuis['daftar_pertanyaan']
        [_currentQuestionIndex]['waktu_pertanyaan'];
    _remainingTime = waktuPertanyaan;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!isPaused) {
        setState(() {
          if (_remainingTime > 0) {
            _remainingTime--;
          } else {
            timer.cancel();
            _nextQuestion(null); // Lanjut ke pertanyaan berikutnya
          }
        });
      }
    });
  }

  void _pauseTimer() {
    setState(() {
      isPaused = !isPaused; // Toggle antara pause dan resume
    });
  }

  void _nextQuestion(String? selectedAnswer) {
    _timer.cancel(); // Hentikan timer saat berpindah pertanyaan

    final currentQuestion =
        widget.kuis['daftar_pertanyaan'][_currentQuestionIndex];
    if (selectedAnswer != null &&
        selectedAnswer == currentQuestion['jawaban']) {
      setState(() {
        _score += int.parse(currentQuestion['nilai'].toString());
      });
    }

    if (_currentQuestionIndex < widget.kuis['daftar_pertanyaan'].length - 1) {
      setState(() {
        _currentQuestionIndex++;
      });
      _startTimer(); // Restart timer untuk pertanyaan berikutnya
    } else {
      _showScoreDialog();
    }
  }

  void _showScoreDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Kuis Selesai'),
        content: Text('Skor Anda: $_score'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: Text('Kembali ke Beranda'),
          ),
        ],
      ),
    );
  }

  Future _showBackDialog() {
    setState(() {
      isPaused = true;
    });
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Yakin ingin mengakhiri kuis?',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.0,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _showScoreDialog();
            },
            child: Text(
              'Akhiri',
              style: TextStyle(
                color: Colors.red,
                fontSize: 14.0,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                isPaused = false;
              });
            },
            child: Text(
              "Lanjutkan Kuis",
              style: TextStyle(color: Colors.black, fontSize: 14.0),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion =
        widget.kuis['daftar_pertanyaan'][_currentQuestionIndex];
    final totalWaktu = currentQuestion['waktu_pertanyaan'];

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) return;

        final shouldPop = await _showBackDialog() ?? false;
        if (context.mounted && shouldPop) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 30.0,
                ),
                Row(
                  children: [
                    Align(
                        alignment: Alignment.topLeft,
                        child: IconButton(
                            icon: Icon(Icons.arrow_back),
                            onPressed: () async {
                              final shouldPop =
                                  await _showBackDialog() ?? false;
                              if (context.mounted && shouldPop) {
                                Navigator.pop(context);
                              }
                            })),
                    SizedBox(
                      width: 15.0,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Bermain kuis",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30.0,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    'Pertanyaan ${_currentQuestionIndex + 1}/${widget.kuis['daftar_pertanyaan'].length}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 10),
                LinearProgressIndicator(
                  value: _remainingTime / totalWaktu,
                  color: Colors.blue,
                  backgroundColor: Colors.grey[300],
                  minHeight: 15.0,
                ),
                SizedBox(height: 10),
                Text('Waktu tersisa: $_remainingTime detik'),
                SizedBox(height: 20.0),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    currentQuestion['pertanyaan'],
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                SizedBox(
                  height: 40.0,
                ),
                ...currentQuestion['opsi'].map<Widget>((option) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.black,
                          width: 1.0,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            blurRadius: 5,
                            offset: Offset(0, 2), // Shadow position
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors
                              .transparent, // Transparent untuk Decoration
                          shadowColor:
                              Colors.transparent, // Hilangkan shadow default
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                        ),
                        onPressed: () => _nextQuestion(option),
                        child: SizedBox(
                          width: double.infinity,
                          height: 70.0,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              option,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

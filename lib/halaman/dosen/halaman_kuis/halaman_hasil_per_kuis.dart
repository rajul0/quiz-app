import 'package:flutter/material.dart';

import 'package:quiz_app/proses/proses_kuis.dart';

class HalamanHasilPerKuis extends StatefulWidget {
  final int idKuis;

  const HalamanHasilPerKuis({Key? key, required this.idKuis}) : super(key: key);

  @override
  _HalamanHasilPerKuisState createState() => _HalamanHasilPerKuisState();
}

class _HalamanHasilPerKuisState extends State<HalamanHasilPerKuis> {
  late Future<Map<int, Map<String, dynamic>>> _groupedQuizHistoryFuture;

  @override
  void initState() {
    super.initState();
    _groupedQuizHistoryFuture = fetchGroupedQuizHistory(widget.idKuis);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Kuis Per User'),
      ),
      body: FutureBuilder<Map<int, Map<String, dynamic>>>(
        future: _groupedQuizHistoryFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
                child: Text('Belum ada riwayat untuk kuis ini.'));
          }

          final groupedData = snapshot.data!;

          return ListView.builder(
            itemCount: groupedData.length,
            itemBuilder: (context, index) {
              final userId = groupedData.keys.elementAt(index);
              print(groupedData);
              print(userId);
              final userData = groupedData[userId]!;
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  title: Text('Kuis : ${userData['idUser']}'),
                  subtitle: Text(
                    'Total Attempt: ${userData['totalAttempt']}\n'
                    'Nilai Terakhir: ${userData['nilaiTerakhir']}\n'
                    'Tanggal Terakhir: ${userData['tanggalTerakhir']}',
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class QuizHistory {
  final int id;
  final int idKuis;
  final int idUser;
  final int nilai;
  final String attemptDate;

  QuizHistory({
    required this.id,
    required this.idKuis,
    required this.idUser,
    required this.nilai,
    required this.attemptDate,
  });

  factory QuizHistory.fromJson(Map<String, dynamic> json) {
    return QuizHistory(
      id: json['id'],
      idKuis: json['id_kuis'],
      idUser: json['id_user'],
      nilai: json['nilai'],
      attemptDate: json['attempt_date'],
    );
  }
}

class QuizAttempt {
  final int idUser;
  final int idKuis;
  final int nilai;
  final String attemptDate;

  QuizAttempt({
    required this.idUser,
    required this.idKuis,
    required this.nilai,
    required this.attemptDate,
  });

  factory QuizAttempt.fromJson(Map<String, dynamic> json) {
    return QuizAttempt(
      idKuis: json['id_kuis'],
      idUser: json['id_user'],
      nilai: json['nilai'],
      attemptDate: json['attempt_date'],
    );
  }
}

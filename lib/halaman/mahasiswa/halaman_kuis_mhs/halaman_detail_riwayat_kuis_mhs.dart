import 'package:flutter/material.dart';
import 'package:quiz_app/halaman/dosen/halaman_kuis/component/class_kuis.dart';
import 'package:quiz_app/proses/proses_kuis.dart';

class HalamanDetailRiwayatKuisMhs extends StatefulWidget {
  final int idKuis;
  final int idUser;

  const HalamanDetailRiwayatKuisMhs(
      {Key? key, required this.idKuis, required this.idUser})
      : super(key: key);

  @override
  State<HalamanDetailRiwayatKuisMhs> createState() =>
      _HalamanDetailRiwayatKuisMhsState();
}

class _HalamanDetailRiwayatKuisMhsState
    extends State<HalamanDetailRiwayatKuisMhs> {
  late Future<List<QuizHistoryByid>> quizzes;

  @override
  void initState() {
    super.initState();
    quizzes = fetchQuizHistory(widget.idKuis, widget.idUser);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Kuis'),
      ),
      body: FutureBuilder<List<QuizHistoryByid>>(
        future: quizzes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Belum ada riwayat kuis.'));
          }

          final quizHistories = snapshot.data!;

          return ListView.builder(
            itemCount: quizHistories.length,
            itemBuilder: (context, index) {
              final quizHistory = quizHistories[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  title: Text('Attempt ${quizHistories.length - index}'),
                  subtitle: Text(
                    'Nilai: ${quizHistory.nilai}\n'
                    'Tanggal: ${quizHistory.attemptDate}',
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

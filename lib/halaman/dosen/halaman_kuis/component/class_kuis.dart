class Quiz {
  final int id;
  final String nama;

  Quiz({
    required this.id,
    required this.nama,
  });

  // Factory method to create Quiz from API response
  factory Quiz.fromJson(Map<String, dynamic> json) {
    return Quiz(
      id: json['id'],
      nama: json['nama'],
    );
  }

  // Convert to JSON (optional, for PUT/POST requests)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama': nama,
    };
  }
}

class QuizHistoryByid {
  final int id;
  final int nilai;
  final String attemptDate;

  QuizHistoryByid({
    required this.id,
    required this.nilai,
    required this.attemptDate,
  });

  factory QuizHistoryByid.fromJson(Map<String, dynamic> json) {
    return QuizHistoryByid(
      id: json['id'],
      nilai: json['nilai'],
      attemptDate: json['attempt_date'],
    );
  }
}

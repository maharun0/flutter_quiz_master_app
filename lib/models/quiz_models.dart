import 'dart:convert';

class QuizCategory {
  const QuizCategory({
    required this.id,
    required this.title,
    required this.icon,
    required this.questions,
  });

  final String id;
  final String title;
  final String icon;
  final List<QuizQuestion> questions;
}

class QuizQuestion {
  const QuizQuestion({
    required this.question,
    required this.options,
    required this.correctAnswer,
  });

  final String question;
  final List<String> options;
  final String correctAnswer;
}

class ScoreSnapshot {
  const ScoreSnapshot({required this.correct, required this.total});

  final int correct;
  final int total;

  String get display => '$correct/$total';

  String toStorage() => '$correct|$total';

  bool isBetterThan(ScoreSnapshot other) {
    if (total == 0) {
      return false;
    }
    if (other.total == 0) {
      return true;
    }
    final scoreValue = correct / total;
    final otherValue = other.correct / other.total;
    if (scoreValue != otherValue) {
      return scoreValue > otherValue;
    }
    return correct > other.correct;
  }

  factory ScoreSnapshot.fromStorage(String? value) {
    if (value == null || value.isEmpty) {
      return const ScoreSnapshot(correct: 0, total: 0);
    }
    final parts = value.split('|');
    if (parts.length != 2) {
      return const ScoreSnapshot(correct: 0, total: 0);
    }
    return ScoreSnapshot(
      correct: int.tryParse(parts[0]) ?? 0,
      total: int.tryParse(parts[1]) ?? 0,
    );
  }
}

class QuizHistoryItem {
  const QuizHistoryItem({
    required this.score,
    required this.categoryTitle,
    required this.recordedAt,
  });

  final ScoreSnapshot score;
  final String categoryTitle;
  final DateTime recordedAt;

  String get formattedDate {
    final date = recordedAt.toLocal();
    final hour = date.hour.toString().padLeft(2, '0');
    final minute = date.minute.toString().padLeft(2, '0');
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')} $hour:$minute';
  }

  String encode() => jsonEncode({
    'score': score.toStorage(),
    'categoryTitle': categoryTitle,
    'recordedAt': recordedAt.toIso8601String(),
  });

  factory QuizHistoryItem.decode(String value) {
    final data = jsonDecode(value) as Map<String, dynamic>;
    return QuizHistoryItem(
      score: ScoreSnapshot.fromStorage(data['score'] as String?),
      categoryTitle: data['categoryTitle'] as String? ?? 'Quiz',
      recordedAt:
          DateTime.tryParse(data['recordedAt'] as String? ?? '') ??
          DateTime.now(),
    );
  }

  static List<QuizHistoryItem> decodeList(List<String>? values) {
    if (values == null) {
      return [];
    }
    return values.map(QuizHistoryItem.decode).toList();
  }
}

class QuizResult {
  const QuizResult({
    required this.categoryTitle,
    required this.totalQuestions,
    required this.correctAnswers,
    required this.wrongAnswers,
  });

  final String categoryTitle;
  final int totalQuestions;
  final int correctAnswers;
  final int wrongAnswers;

  String get scoreText => '$correctAnswers/$totalQuestions';

  int get percentage {
    if (totalQuestions == 0) {
      return 0;
    }
    return ((correctAnswers / totalQuestions) * 100).round();
  }
}

const List<QuizCategory> quizCategories = [
  QuizCategory(
    id: 'sports',
    title: 'Sports',
    icon: '🏀',
    questions: [
      QuizQuestion(
        question: 'How many players are on a basketball team on court?',
        options: ['5', '6', '7', '11'],
        correctAnswer: '5',
      ),
      QuizQuestion(
        question: 'Which sport uses a shuttlecock?',
        options: ['Tennis', 'Badminton', 'Cricket', 'Hockey'],
        correctAnswer: 'Badminton',
      ),
      QuizQuestion(
        question: 'How many holes are played in a standard golf round?',
        options: ['9', '12', '18', '24'],
        correctAnswer: '18',
      ),
      QuizQuestion(
        question: 'Which country hosted the 2016 Summer Olympics?',
        options: ['Brazil', 'Japan', 'Canada', 'Germany'],
        correctAnswer: 'Brazil',
      ),
      QuizQuestion(
        question: 'What is the term for a score of zero in tennis?',
        options: ['Love', 'Nil', 'Duck', 'Blank'],
        correctAnswer: 'Love',
      ),
    ],
  ),
  QuizCategory(
    id: 'science',
    title: 'Science',
    icon: '🔬',
    questions: [
      QuizQuestion(
        question: 'What planet is known as the Red Planet?',
        options: ['Mars', 'Venus', 'Jupiter', 'Saturn'],
        correctAnswer: 'Mars',
      ),
      QuizQuestion(
        question: 'What gas do plants absorb from the atmosphere?',
        options: ['Oxygen', 'Carbon Dioxide', 'Nitrogen', 'Hydrogen'],
        correctAnswer: 'Carbon Dioxide',
      ),
      QuizQuestion(
        question: 'What is H2O commonly known as?',
        options: ['Salt', 'Hydrogen', 'Water', 'Helium'],
        correctAnswer: 'Water',
      ),
      QuizQuestion(
        question: 'What part of the cell contains genetic material?',
        options: ['Nucleus', 'Ribosome', 'Membrane', 'Cytoplasm'],
        correctAnswer: 'Nucleus',
      ),
      QuizQuestion(
        question: 'What is the center of an atom called?',
        options: ['Electron', 'Proton', 'Nucleus', 'Orbit'],
        correctAnswer: 'Nucleus',
      ),
    ],
  ),
  QuizCategory(
    id: 'technology',
    title: 'Technology',
    icon: '💻',
    questions: [
      QuizQuestion(
        question: 'What does CPU stand for?',
        options: [
          'Central Processing Unit',
          'Computer Power Unit',
          'Core Program Utility',
          'Central Program Upload',
        ],
        correctAnswer: 'Central Processing Unit',
      ),
      QuizQuestion(
        question: 'Which company created Android?',
        options: ['Apple', 'Google', 'Microsoft', 'Samsung'],
        correctAnswer: 'Google',
      ),
      QuizQuestion(
        question: 'What does HTML stand for?',
        options: [
          'HyperText Markup Language',
          'High Transfer Machine Language',
          'Home Tool Markup Logic',
          'Hyperlink Text Main Language',
        ],
        correctAnswer: 'HyperText Markup Language',
      ),
      QuizQuestion(
        question: 'Which language is used to build Flutter apps?',
        options: ['Kotlin', 'Swift', 'Dart', 'Java'],
        correctAnswer: 'Dart',
      ),
      QuizQuestion(
        question: 'What does Wi-Fi allow devices to do?',
        options: [
          'Print files',
          'Connect wirelessly to a network',
          'Increase battery life',
          'Store photos',
        ],
        correctAnswer: 'Connect wirelessly to a network',
      ),
    ],
  ),
  QuizCategory(
    id: 'history',
    title: 'History',
    icon: '📜',
    questions: [
      QuizQuestion(
        question: 'Who was the first President of the United States?',
        options: [
          'Abraham Lincoln',
          'George Washington',
          'Thomas Jefferson',
          'John Adams',
        ],
        correctAnswer: 'George Washington',
      ),
      QuizQuestion(
        question: 'The pyramids were built in which country?',
        options: ['India', 'Greece', 'Egypt', 'Mexico'],
        correctAnswer: 'Egypt',
      ),
      QuizQuestion(
        question: 'Which wall fell in 1989?',
        options: [
          'Great Wall of China',
          'Berlin Wall',
          'Wall of Jericho',
          'Hadrian Wall',
        ],
        correctAnswer: 'Berlin Wall',
      ),
      QuizQuestion(
        question: 'Who discovered America in 1492?',
        options: [
          'Christopher Columbus',
          'Marco Polo',
          'Vasco da Gama',
          'Ferdinand Magellan',
        ],
        correctAnswer: 'Christopher Columbus',
      ),
      QuizQuestion(
        question: 'Which ancient civilization built Machu Picchu?',
        options: ['Maya', 'Inca', 'Aztec', 'Roman'],
        correctAnswer: 'Inca',
      ),
    ],
  ),
  QuizCategory(
    id: 'general-knowledge',
    title: 'General Knowledge',
    icon: '🧠',
    questions: [
      QuizQuestion(
        question: 'How many continents are there?',
        options: ['5', '6', '7', '8'],
        correctAnswer: '7',
      ),
      QuizQuestion(
        question: 'What is the capital of France?',
        options: ['Berlin', 'Madrid', 'Paris', 'Rome'],
        correctAnswer: 'Paris',
      ),
      QuizQuestion(
        question: 'Which color is made by mixing red and white?',
        options: ['Pink', 'Purple', 'Orange', 'Brown'],
        correctAnswer: 'Pink',
      ),
      QuizQuestion(
        question: 'Which animal is known as the king of the jungle?',
        options: ['Tiger', 'Elephant', 'Lion', 'Bear'],
        correctAnswer: 'Lion',
      ),
      QuizQuestion(
        question: 'What is the largest ocean on Earth?',
        options: ['Atlantic', 'Indian', 'Pacific', 'Arctic'],
        correctAnswer: 'Pacific',
      ),
    ],
  ),
];

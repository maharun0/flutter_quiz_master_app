import 'package:shared_preferences/shared_preferences.dart';

import '../models/quiz_models.dart';

class QuizStorageService {
  static const _themeKey = 'is_dark_mode';
  static const _totalAttemptsKey = 'total_attempts';
  static const _highestScoreKey = 'highest_score';
  static const _lastScoreKey = 'last_score';
  static const _historyKey = 'quiz_history';

  Future<QuizStorageState> load() async {
    final prefs = await SharedPreferences.getInstance();
    return QuizStorageState(
      isDarkMode: prefs.getBool(_themeKey) ?? false,
      totalAttempts: prefs.getInt(_totalAttemptsKey) ?? 0,
      highestScore: ScoreSnapshot.fromStorage(
        prefs.getString(_highestScoreKey),
      ),
      lastScore: ScoreSnapshot.fromStorage(prefs.getString(_lastScoreKey)),
      history: QuizHistoryItem.decodeList(prefs.getStringList(_historyKey)),
    );
  }

  Future<void> saveTheme(bool isDarkMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_themeKey, isDarkMode);
  }

  Future<void> saveResults({
    required int totalAttempts,
    required ScoreSnapshot highestScore,
    required ScoreSnapshot lastScore,
    required List<QuizHistoryItem> history,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_totalAttemptsKey, totalAttempts);
    await prefs.setString(_highestScoreKey, highestScore.toStorage());
    await prefs.setString(_lastScoreKey, lastScore.toStorage());
    await prefs.setStringList(
      _historyKey,
      history.map((item) => item.encode()).toList(),
    );
  }
}

class QuizStorageState {
  const QuizStorageState({
    required this.isDarkMode,
    required this.totalAttempts,
    required this.highestScore,
    required this.lastScore,
    required this.history,
  });

  final bool isDarkMode;
  final int totalAttempts;
  final ScoreSnapshot highestScore;
  final ScoreSnapshot lastScore;
  final List<QuizHistoryItem> history;
}

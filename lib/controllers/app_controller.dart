import 'package:flutter/material.dart';

import '../models/quiz_models.dart';
import '../services/quiz_storage_service.dart';

class AppController extends ChangeNotifier {
  AppController({QuizStorageService? storageService})
    : _storageService = storageService ?? QuizStorageService();

  final QuizStorageService _storageService;

  bool _isDarkMode = false;
  int _totalAttempts = 0;
  ScoreSnapshot _highestScore = const ScoreSnapshot(correct: 0, total: 0);
  ScoreSnapshot _lastScore = const ScoreSnapshot(correct: 0, total: 0);
  List<QuizHistoryItem> _history = [];

  bool _isLoaded = false;
  bool _quizSubmitted = false;

  QuizCategory? _activeCategory;
  List<QuizQuestion> _activeQuestions = [];
  int _currentQuestionIndex = 0;
  int? _selectedOptionIndex;
  int _correctAnswers = 0;
  int _wrongAnswers = 0;
  QuizResult? _lastResult;

  bool get isLoaded => _isLoaded;
  bool get isDarkMode => _isDarkMode;
  int get totalAttempts => _totalAttempts;
  ScoreSnapshot get highestScore => _highestScore;
  ScoreSnapshot get lastScore => _lastScore;
  List<QuizHistoryItem> get history => List.unmodifiable(_history);
  QuizCategory? get activeCategory => _activeCategory;
  List<QuizQuestion> get activeQuestions => List.unmodifiable(_activeQuestions);
  int get currentQuestionIndex => _currentQuestionIndex;
  int? get selectedOptionIndex => _selectedOptionIndex;
  int get correctAnswers => _correctAnswers;
  int get wrongAnswers => _wrongAnswers;
  QuizResult? get lastResult => _lastResult;
  bool get canProceed => _selectedOptionIndex != null && !_quizSubmitted;
  bool get isLastQuestion =>
      _activeQuestions.isNotEmpty &&
      _currentQuestionIndex == _activeQuestions.length - 1;
  QuizQuestion? get currentQuestion =>
      _activeQuestions.isEmpty ? null : _activeQuestions[_currentQuestionIndex];

  Future<void> load() async {
    final state = await _storageService.load();
    _isDarkMode = state.isDarkMode;
    _totalAttempts = state.totalAttempts;
    _highestScore = state.highestScore;
    _lastScore = state.lastScore;
    _history = state.history;
    _isLoaded = true;
    notifyListeners();
  }

  Future<void> toggleTheme() async {
    _isDarkMode = !_isDarkMode;
    await _storageService.saveTheme(_isDarkMode);
    notifyListeners();
  }

  void startQuiz(QuizCategory category) {
    _activeCategory = category;
    _activeQuestions = category.questions;
    _currentQuestionIndex = 0;
    _selectedOptionIndex = null;
    _correctAnswers = 0;
    _wrongAnswers = 0;
    _quizSubmitted = false;
    _lastResult = null;
    notifyListeners();
  }

  void selectOption(int optionIndex) {
    if (_quizSubmitted) {
      return;
    }
    _selectedOptionIndex = optionIndex;
    notifyListeners();
  }

  Future<void> goNext() async {
    if (!canProceed || currentQuestion == null) {
      return;
    }

    final selectedOption = currentQuestion!.options[_selectedOptionIndex!];
    if (selectedOption == currentQuestion!.correctAnswer) {
      _correctAnswers++;
    } else {
      _wrongAnswers++;
    }

    if (isLastQuestion) {
      await _finishQuiz();
      return;
    }

    _currentQuestionIndex++;
    _selectedOptionIndex = null;
    notifyListeners();
  }

  Future<void> playAgain() async {
    final category = _activeCategory;
    if (category == null) {
      return;
    }
    startQuiz(category);
  }

  Future<void> _finishQuiz() async {
    if (_quizSubmitted || _activeQuestions.isEmpty || _activeCategory == null) {
      return;
    }

    _quizSubmitted = true;
    _totalAttempts++;
    _lastScore = ScoreSnapshot(
      correct: _correctAnswers,
      total: _activeQuestions.length,
    );

    if (_highestScore.isBetterThan(_lastScore)) {
      _highestScore = _lastScore;
    }

    _history = [
      QuizHistoryItem(
        score: _lastScore,
        categoryTitle: _activeCategory!.title,
        recordedAt: DateTime.now(),
      ),
      ..._history,
    ].take(10).toList();

    await _storageService.saveResults(
      totalAttempts: _totalAttempts,
      highestScore: _highestScore,
      lastScore: _lastScore,
      history: _history,
    );

    _lastResult = QuizResult(
      categoryTitle: _activeCategory!.title,
      totalQuestions: _activeQuestions.length,
      correctAnswers: _correctAnswers,
      wrongAnswers: _wrongAnswers,
    );
    notifyListeners();
  }
}

# Quiz Master

A feature-rich Flutter quiz application built for the Module 4 assignment.

## Overview

Quiz Master is a local-only quiz app with theme persistence, score tracking, history storage, and a clean multi-screen flow. It uses `GoRouter` for navigation and `SharedPreferences` for saving user preferences and quiz history.

## Features

- Home dashboard with welcome banner, statistics, and category cards
- Light and dark theme toggle with persistence
- Quiz screen with question counter, progress indicator, and MCQ selection
- Result screen with score summary and retry/navigation actions
- SharedPreferences-based tracking for:
	- total attempts
	- highest score
	- last score
	- last 10 quiz results
- No API usage; all data is stored locally

## Tech Stack

- Flutter
- Dart
- GoRouter
- SharedPreferences

## Getting Started

### Prerequisites

- Flutter SDK installed
- A connected device or emulator

### Install dependencies

```bash
flutter pub get
```

### Run the app

```bash
flutter run
```

### Run tests

```bash
flutter test
```

## Project Structure

```text
lib/
	app.dart
	main.dart
	controllers/
	models/
	screens/
	services/
	widgets/
```

## Notes

- Quiz content is hardcoded locally in the app.
- Theme and quiz history persist after app restart.
- The app is intentionally kept simple and focused on the assignment requirements.

## Assignment Checklist

- GoRouter integration
- Theme toggle and persistence
- SharedPreferences integration
- Home dashboard
- Statistics section
- Category cards
- Quiz screen
- Progress indicator
- MCQ selection
- Result screen
- Play again feature
- Back to home feature
- Total attempts tracking
- Highest score tracking
- Last score tracking
- Last 10 quiz history tracking

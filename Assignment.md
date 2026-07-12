# Module 4 Assignment

## Course Assignment: Quiz Master – A Feature-Rich Flutter Application

**Assignment Released:** June 17, 2026 <br>
**Total Marks:** 100 <br>
**Submission Deadline:** June 30, 2026 <br>
**Repository Name:** `flutter_quiz_master_app` <br>

---

# Assignment Objective

এই প্রজেক্টের মূল উদ্দেশ্য হলো রিয়াল-ওয়ার্ল্ড Flutter অ্যাপ্লিকেশন ডেভেলপমেন্টের অভিজ্ঞতা অর্জন করা।

এই অ্যাসাইনমেন্টটি সফলভাবে সম্পন্ন করার মাধ্যমে শিক্ষার্থীরা নিম্নলিখিত গুরুত্বপূর্ণ ইন্ডাস্ট্রি-স্ট্যান্ডার্ড স্কিলগুলো প্র্যাকটিক্যালি শিখতে পারবে:

* State Management (Theme Management)
* Local Persistence (SharedPreferences)
* Declarative Routing (GoRouter)
* Custom UI/UX Design
* Data Modeling (Model Classes)

---

# Tech Stack & Key Concepts

| Area             | Technology                                                       |
| ---------------- | ---------------------------------------------------------------- |
| Routing          | GoRouter (Declarative Routing System)                            |
| Local Storage    | SharedPreferences                                                |
| State Management | Theme Management with Persistence                                |
| Architecture     | Clean Code Structure (Separate UI, Models, Controllers/Services) |

---

# 1. Home Screen (Dashboard)

এটি অ্যাপের সেন্ট্রাল হাব বা মূল ড্যাশবোর্ড হিসেবে কাজ করবে। ডিজাইন হতে হবে প্রফেশনাল এবং ইউজার-ফ্রেন্ডলি।

## A. AppBar Functionalities

### App Title

* Quiz Master

### Theme Toggle Button

* Custom icon বা switch ব্যবহার করতে হবে।
* Light Mode ☀️ ↔ Dark Mode 🌙

### Theme Persistence

* ইউজার থিম পরিবর্তন করার পর অ্যাপ সম্পূর্ণ বন্ধ (Kill) করে পুনরায় চালু করলেও নির্বাচিত থিম বজায় থাকতে হবে।
* SharedPreferences ব্যবহার করে থিম সংরক্ষণ করতে হবে।

---

## B. Dashboard Body Sections

### Welcome Section

একটি আকর্ষণীয় হেডার টেক্সট প্রদর্শন করতে হবে:

> Welcome to Quiz Master! Test your knowledge and improve your learning skills.

---

### Statistics Section

SharedPreferences থেকে রিয়াল-টাইম ডেটা রিড করে নিম্নলিখিত তথ্য দেখাতে হবে:

1. Total Quiz Attempts

   * Example: `12`

2. Highest Score

   * Example: `9/10`

3. Last Score

   * Example: `7/10`

প্রদর্শনের জন্য Custom Container অথবা Grid View ব্যবহার করা যেতে পারে।

---

### Categories Section

কমপক্ষে **৫টি Quiz Category** থাকতে হবে।

#### Example Categories

* 🏀 Sports
* 🔬 Science
* 💻 Technology
* 📜 History
* 🧠 General Knowledge

#### Category Card Design

প্রতিটি কার্ডে থাকতে হবে:

* Category Icon / Illustration
* Category Name
* Total Question Count

Example:

```text
💻 Technology
5 Questions
```

#### Interaction

* Category Card-এ Tap করলে Quiz Screen-এ Navigate করবে।
* নির্দিষ্ট Category-এর Question Data পাঠাতে হবে।

---

# 2. Quiz Screen

ইউজার যখন কুইজে অংশগ্রহণ করবেন, তখন এই স্ক্রিনটি ওপেন হবে।

---

## Question Counter

বর্তমান প্রশ্ন নম্বর প্রদর্শন করতে হবে।

Example:

```text
Question 2 of 5
```

---

## Progress Indicator

* LinearProgressIndicator ব্যবহার করতে হবে।
* প্রশ্নের সাথে সাথে Progress Update হবে।

---

## Question Card

* Question একটি সুন্দর Container/Card-এর মধ্যে দেখাতে হবে।
* Readability নিশ্চিত করতে হবে।

---

## Multiple Choice Questions (MCQ)

প্রতিটি প্রশ্নের জন্য:

* 4টি Option থাকবে।
* User শুধুমাত্র 1টি Option Select করতে পারবেন।

### Selection Behavior

Option Select করার পর:

* Border Color পরিবর্তন হবে অথবা
* Background Color পরিবর্তন হবে

অর্থাৎ Selected Option স্পষ্টভাবে Highlight হবে।

---

## Navigation Buttons

### Next Button

* পরবর্তী প্রশ্নে যাওয়ার জন্য।
* Option Select না করা পর্যন্ত Disabled রাখা যেতে পারে।

### Finish Button

* সর্বশেষ প্রশ্নে "Next" এর পরিবর্তে "Finish" Button দেখাতে হবে।

---

# 3. Result Screen

কুইজ শেষ হওয়ার সাথে সাথে ইউজার একটি বিস্তারিত Performance Summary দেখতে পাবেন।

---

## Performance Metrics

প্রদর্শন করতে হবে:

1. Total Questions
2. Correct Answers
3. Wrong Answers
4. Final Score
5. Percentage

### Example

```text
Total Questions: 5
Correct Answers: 4
Wrong Answers: 1
Final Score: 4/5
Percentage: 80%
```

---

## Action Buttons

### Play Again

* একই Quiz পুনরায় শুরু করবে।

### Back To Home

* Dashboard Screen-এ ফিরে যাবে।

---

# 4. Result History (Local Storage Tracking)

SharedPreferences ব্যবহার করে Quiz Data Persist করতে হবে।

---

## Metrics Persistence

প্রতিবার Quiz শেষ হওয়ার পর নিম্নলিখিত তথ্য Update করতে হবে:

* Total Attempts
* Highest Score
* Last Score

---

## Quiz History List

শেষ 10টি Quiz Result সংরক্ষণ করতে হবে।

### Requirements

* নতুন Result সবার উপরে থাকবে।
* শুধুমাত্র সর্বশেষ 10টি Result রাখতে হবে।
* Dashboard অথবা আলাদা History Section-এ দেখাতে হবে।

### Example

```text
History
-------
10/10
8/10
7/10
6/10
5/10
```

---

## Important Note

❌ কোনো API ব্যবহার করা যাবে না।

✅ সমস্ত Data Local Storage (SharedPreferences) ব্যবহার করে Handle করতে হবে।

---

# 5. Submission Guidelines

## 1. GitHub Repository

* Repository অবশ্যই Public হতে হবে।
* Repository Name:

```text
flutter_quiz_master_app
```

---

## 2. README.md

* একটি Professional README.md যুক্ত করতে হবে।

---

## 3. Demo Video (3–5 Minutes)

একটি Screen Recording Video তৈরি করতে হবে যেখানে:

* Theme Switching দেখানো হবে
* Quiz Play দেখানো হবে
* Result Screen দেখানো হবে
* History Tracking দেখানো হবে
* Data Persistence দেখানো হবে

### Submission Format

* Google Drive Link অথবা
* Unlisted YouTube Link

---

# Evaluation Checklist

## Core Features

* [ ] GoRouter Integration
* [ ] Theme Toggle
* [ ] Theme Persistence
* [ ] SharedPreferences Integration
* [ ] Home Dashboard
* [ ] Statistics Section
* [ ] Category Cards
* [ ] Quiz Screen
* [ ] Progress Indicator
* [ ] MCQ Selection
* [ ] Result Screen
* [ ] Play Again Feature
* [ ] Back To Home Feature

## Persistence Features

* [ ] Total Attempts Tracking
* [ ] Highest Score Tracking
* [ ] Last Score Tracking
* [ ] Last 10 Quiz History Tracking

## Code Quality

* [ ] Clean Architecture
* [ ] Model Classes
* [ ] Reusable Widgets
* [ ] Proper Folder Structure
* [ ] Professional UI/UX

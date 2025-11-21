# sampleprj

# 📊 Neodocs Flutter Assignment — Dynamic Range Bar Visualization

A Flutter application that visualizes multiple dynamic ranges using a segmented bar widget, fetches metadata from an API, and updates the indicator reactively based on user input — all without using setState.

## Getting Started

🚀 Features
## ✅ Dynamic Range Segmented Bar

Renders multiple ranges with:

Numeric start–end

Range meaning

Background color

Segments adjust width proportionally to numeric size.

## ✅ Boundary Markers (0, 21, 50, 78, 92, 121, 147)

Shows numbers above each range split point, perfectly aligned.

## ✅ Reactive State Management

Uses ChangeNotifier (Flutter-native)

UI updates automatically as user enters values.

## ✅ API Integration

GET request using HttpClient

Handles Bearer Token authentication

Parses JSON into custom RangeItem model

Gracefully handles:

API failure

Wrong format

Connection error

## ✅ User Input

Accepts numeric input

Updates the indicator arrow position dynamically

Input is clamped within allowed range.

## ✅ Clean Architecture

Service layer → API

ViewModel → business logic + state

Widgets → pure UI

No business logic inside UI layer

## 🧱Architecture Overview
lib/
 ├── main.dart
 ├── models/
 │    └── range_item.dart
 ├── services/
 │    └── range_service.dart
 ├── viewmodels/
 │    └── range_viewmodel.dart
 └── widgets/
      └── bar_widget.dart
## Layers:
| Layer         | Responsibility                                         |
| ------------- | ------------------------------------------------------ |
| **Service**   | Fetch data from API                                    |
| **ViewModel** | Handle input, compute indicator position, expose state |
| **Widget**    | Render UI based on state                               |


## 📦 How to Run
1. Clone repository
git clone https://github.com/Abhu2002/neodocs_task.git
cd neodocs_task
2. Get dependencies
flutter pub get
3. Run the app
flutter run

## 📸 Screenshots

![Output_1](https://github.com/user-attachments/assets/7b9b68af-ac21-4154-b556-d0874047481e)
![Output_2](https://github.com/user-attachments/assets/1dc08bd5-e708-46ce-9ebc-6a1e15a3e7f3)

## 👨‍💻 Author
Abhay Kapadnis

Flutter Developer






# CarvOn - Car Rental App

CarvOn is a modern, feature-rich car rental application built with Flutter. It provides a seamless user experience for browsing, booking, and reviewing rental cars. The app leverages Firebase for backend services and Hive for local data persistence, ensuring a robust and efficient platform.

## Features

-   **User Authentication**: Secure sign-up, log-in, and password reset functionality using Firebase Authentication.
-   **Car Browsing**: Explore a wide range of vehicles categorized by brand (Mercedes, BMW, Audi, etc.).
-   **Advanced Search**: Quickly find specific cars by name, brand, or features.
-   **Detailed Car Views**: Access comprehensive details for each car, including specifications, features, and 3D models.
-   **Smart Booking System**: Select rental dates with an intuitive date picker, view total pricing, and book available cars. The system automatically checks for scheduling conflicts.
-   **User Profiles**: A dedicated screen for users to view their personal information.
-   **Feedback and Ratings**: Users can rate and review cars after a completed booking, helping other users make informed decisions.
-   **Location-Aware Experience**: The app uses your current location to provide a personalized greeting.
-   **Favorites**: Mark cars as favorites for quick access later.

## Tech Stack & Architecture

This project is built with a modern Flutter stack, emphasizing clean architecture and maintainability.

-   **Framework**: Flutter
-   **State Management**: BLoC / Cubit for predictable and scalable state management.
-   **Backend**: Firebase (Authentication & Cloud Firestore) for user management and real-time data storage.
-   **Local Storage**: Hive for fast and efficient local data caching of user profiles and feedback.
-   **Dependency Injection**: GetIt for decoupling and managing dependencies.
-   **Routing**: Centralized navigation management for a clear and organized routing structure.
-   **UI Toolkit**: `flutter_screenutil` for responsive UI, along with packages like `font_awesome_flutter` and `smooth_page_indicator`.
-   **Location Services**: `geolocator` and `geocoding` for fetching and displaying user location.

The codebase follows a feature-first directory structure, where each feature (e.g., Auth, Home, Booking) is organized into its own UI, Logic (Cubit), and Data layers.

## Project Structure

The project is structured to separate concerns and improve scalability.

```
lib/
├── core/
│   ├── di/                 # Dependency Injection setup (GetIt)
│   ├── helpers/            # Helper functions and extensions
│   ├── routing/            # App routes and navigation
│   ├── theming/            # Font and style helpers
│   ├── utils/              # App constants (colors, assets)
│   └── widgets/            # Reusable core widgets (buttons, text fields)
│
├── feature/
│   ├── auth/               # User authentication (login, signup, reset)
│   ├── Booking/            # Booking logic and models
│   ├── car_Details/        # Car details screen
│   ├── FeedBack/           # Feedback and rating system
│   ├── home/               # Main home screen, car listings, search
│   ├── navigation_screen.dart/ # Bottom navigation bar shell
│   ├── onBoarding/         # Onboarding and start screens
│   └── Profile/            # User profile screen
│
├── car_rent_app.dart       # Root application widget
└── main.dart               # Main entry point of the application
```

## Getting Started

To get a local copy up and running, follow these simple steps.

### Prerequisites

-   Flutter SDK installed on your machine.
-   A configured Firebase project.

### Installation

1.  **Clone the repository:**
    ```sh
    git clone https://github.com/adel-saeed21/car_rent.git
    cd car_rent
    ```

2.  **Set up Firebase:**
    -   Create a new project on the [Firebase Console](https://console.firebase.google.com/).
    -   Add an Android application to your Firebase project.
    -   Download the `google-services.json` file and place it in the `android/app/` directory.

3.  **Install dependencies:**
    ```sh
    flutter pub get
    ```

4.  **Run the code generator:**
    The project uses code generation for models and Hive adapters. Run the following command:
    ```sh
    flutter pub run build_runner build --delete-conflicting-outputs
    ```

5.  **Run the application:**
    ```sh
    flutter run

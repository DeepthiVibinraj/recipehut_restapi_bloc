# recipehut

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

lib/
├── core/ # App-wide helpers and configs
│ ├── constants/ # Base URLs, API keys, etc.
│ ├── network/ # API client setup (Dio/Http)
│ ├── error/ # Exceptions and failure models
│ └── utils/ # Formatters, helpers, etc.
│
├── data/ # Data layer (models & services)
│ ├── models/ # RecipeModel, NutritionModel...
│ ├── sources/ # SpoonacularService (API calls)
│ └── repositories/ # Abstract -> RecipeRepositoryImpl
│
├── domain/ # Business logic (pure dart)
│ ├── entities/ # Recipe, Ingredient (clean models)
│ ├── usecases/ # getRecipes(), getRecipeDetails()...
│ └── repositories/ # Abstract interfaces
│
├── presentation/ # UI + ViewModels (BLoC as ViewModel)
│ ├── blocs/ # BLoC & events/states per screen
│ │ ├── recipe_bloc.dart
│ │ └── recipe_event.dart / recipe_state.dart
│ ├── views/ # Screens/pages
│ │ ├── home_page.dart
│ │ ├── recipe_detail_page.dart
│ │ └── search_page.dart
│ └── widgets/ # Reusable UI widgets
│ ├── recipe_card.dart
│ ├── search_bar.dart
│ └── loading_widget.dart
│
├── app/ # App entry and routing
│ ├── router.dart # GoRouter / AutoRoute setup
│ └── app.dart # MaterialApp, theme, DI
│
├── injection/ # get_it setup or provider setup
│ └── injection_container.dart
│
└── main.dart # Entry point

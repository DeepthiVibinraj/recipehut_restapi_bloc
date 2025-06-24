// import 'package:bloc/bloc.dart';
// import 'package:recipehut/services/api_service.dart';

// import 'package:recipehut/view_models/bloc/home/home_event.dart';
// import 'package:recipehut/view_models/bloc/home/home_state.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:convert';

// // class HomeBloc extends Bloc<HomeEvent, HomeState> {
// //   final ApiService apiService;

// //   HomeBloc(this.apiService) : super(HomeInitial()) {
// //     on<FetchRecipe>(_onFetchRecipe);
// //     on<LoadStoredRecipe>(_onLoadStoredRecipe);
// //     on<FetchAllRecipes>((event, emit) async {
// //       emit(HomeLoading());
// //       try {
// //         final recipes = await apiService.fetchMultipleRecipes();
// //         emit(HomeRecipesLoaded(recipes));
// //       } catch (e) {
// //         emit(HomeError('Failed to load all recipes: $e'));
// //       }
// //     });
// //   }

// //   Future<void> _onFetchRecipe(
// //       FetchRecipe event, Emitter<HomeState> emit) async {
// //     emit(HomeLoading());
// //     try {
// //       final recipe = await apiService.fetchRecipe();

// //       // Cache the recipe and today's date
// //       final prefs = await SharedPreferences.getInstance();
// //       final today = DateTime.now().toIso8601String().split('T').first;
// //       prefs.setString('lastRecipeDate', today);
// //       prefs.setString('recipeOfTheDay', jsonEncode(recipe.toJson()));

// //       emit(HomeLoaded(recipe, []));
// //     } catch (e) {
// //       emit(HomeError('Failed to load recipe: $e'));
// //     }
// //   }

// //   void _onLoadStoredRecipe(LoadStoredRecipe event, Emitter<HomeState> emit) {
// //     emit(HomeLoaded(event.recipe, []));
// //   }
// // }
// class HomeBloc extends Bloc<HomeEvent, HomeState> {
//   final ApiService api;
//   HomeBloc(this.api) : super(HomeInitial()) {
//     on<FetchAllRecipes>(_fetchAll);
//     on<LoadStoredRecipe>(_loadStored);

//   }

//   Future<void> _fetchAll(FetchAllRecipes e, Emitter<HomeState> emit) async {
//     emit(HomeLoading());
//     try {
//       final recipeOTD = await api.fetchRecipeOfTheDay();
//       final popular = await api.fetchPopularRecipes();

//       // cache recipeOTD only
//       final prefs = await SharedPreferences.getInstance();
//       prefs.setString(
//           'lastRecipeDate', DateTime.now().toIso8601String().split('T').first);
//       prefs.setString('recipeOfTheDay', jsonEncode(recipeOTD.toJson()));

//       emit(HomeLoaded(recipeOTD, popular));
//     } catch (err) {
//       emit(HomeError(err.toString()));
//     }
//   }

//   void _loadStored(LoadStoredRecipe e, Emitter<HomeState> emit) async {
//     emit(HomeLoading());
//     try {
//       final popular = await api.fetchPopularRecipes();
//       emit(HomeLoaded(e.recipe, popular));
//     } catch (err) {
//       emit(HomeError(err.toString()));
//     }
//   }
// }
import 'package:bloc/bloc.dart';
import 'package:recipehut/services/api_service.dart';
import 'package:recipehut/view_models/bloc/home/home_event.dart';
import 'package:recipehut/view_models/bloc/home/home_state.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

// class HomeBloc extends Bloc<HomeEvent, HomeState> {
//   final ApiService apiService;

//   HomeBloc(this.apiService) : super(HomeInitial()) {
//     on<FetchRecipe>(_onFetchRecipe);
//     on<LoadStoredRecipe>(_onLoadStoredRecipe);
//     on<FetchAllRecipes>((event, emit) async {
//       emit(HomeLoading());
//       try {
//         final recipes = await apiService.fetchMultipleRecipes();
//         emit(HomeRecipesLoaded(recipes));
//       } catch (e) {
//         emit(HomeError('Failed to load all recipes: $e'));
//       }
//     });
//   }

//   Future<void> _onFetchRecipe(
//       FetchRecipe event, Emitter<HomeState> emit) async {
//     emit(HomeLoading());
//     try {
//       final recipe = await apiService.fetchRecipe();

//       // Cache the recipe and today's date
//       final prefs = await SharedPreferences.getInstance();
//       final today = DateTime.now().toIso8601String().split('T').first;
//       prefs.setString('lastRecipeDate', today);
//       prefs.setString('recipeOfTheDay', jsonEncode(recipe.toJson()));

//       emit(HomeLoaded(recipe, []));
//     } catch (e) {
//       emit(HomeError('Failed to load recipe: $e'));
//     }
//   }

//   void _onLoadStoredRecipe(LoadStoredRecipe event, Emitter<HomeState> emit) {
//     emit(HomeLoaded(event.recipe, []));
//   }
// }
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ApiService api;
  HomeBloc(this.api) : super(HomeInitial()) {
    on<FetchAllRecipes>(_fetchAll);
    on<LoadStoredRecipe>(_loadStored);
  }

  Future<void> _fetchAll(FetchAllRecipes e, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    try {
      final recipeOTD = await api.fetchRecipeOfTheDay();
      final popular = await api.fetchPopularRecipes();

      // cache recipeOTD only
      final prefs = await SharedPreferences.getInstance();
      prefs.setString(
          'lastRecipeDate', DateTime.now().toIso8601String().split('T').first);
      prefs.setString('recipeOfTheDay', jsonEncode(recipeOTD.toJson()));

      emit(HomeLoaded(recipeOTD, popular));
    } catch (err) {
      emit(HomeError(err.toString()));
    }
  }

  void _loadStored(LoadStoredRecipe e, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    try {
      final popular = await api.fetchPopularRecipes();
      emit(HomeLoaded(e.recipe, popular));
    } catch (err) {
      emit(HomeError(err.toString()));
    }
  }
}

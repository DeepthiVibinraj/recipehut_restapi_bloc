// import 'package:equatable/equatable.dart';
// import 'package:recipehut/data/models/recipe_model.dart';

// abstract class HomeState extends Equatable {
//   const HomeState();
//   @override
//   List<Object?> get props => [];
// }

// class HomeInitial extends HomeState {}

// class HomeLoading extends HomeState {}

// class HomeError extends HomeState {
//   final String message;
//   const HomeError(this.message);
//   @override
//   List<Object?> get props => [message];
// }

// class HomeLoaded extends HomeState {
//   final RecipeModel recipeOfTheDay;
//   final List<RecipeModel> recipes;
//   const HomeLoaded(this.recipeOfTheDay, this.recipes);
//   @override
//   List<Object?> get props => [recipeOfTheDay, recipes];
// }
import 'package:equatable/equatable.dart';
import 'package:recipehut/data/models/recipe_model.dart';

abstract class HomeState extends Equatable {
  const HomeState();
  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeError extends HomeState {
  final String message;
  const HomeError(this.message);
  @override
  List<Object?> get props => [message];
}

class HomeLoaded extends HomeState {
  final RecipeModel recipeOfTheDay;
  final List<RecipeModel> recipes;
  const HomeLoaded(this.recipeOfTheDay, this.recipes);
  @override
  List<Object?> get props => [recipeOfTheDay, recipes];
}

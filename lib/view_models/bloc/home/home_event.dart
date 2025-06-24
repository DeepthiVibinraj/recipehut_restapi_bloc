// import 'package:equatable/equatable.dart';
// import '../../../data/models/recipe_model.dart';

// // abstract class HomeEvent extends Equatable {
// //   const HomeEvent();

// //   @override
// //   List<Object?> get props => [];
// // }

// // class FetchRecipe extends HomeEvent {}

// // class FetchAllRecipes extends HomeEvent {}

// // class LoadStoredRecipe extends HomeEvent {
// //   final RecipeModel recipe;

// //   const LoadStoredRecipe(this.recipe);

// //   @override
// //   List<Object?> get props => [recipe];
// // }
// abstract class HomeEvent extends Equatable {
//   const HomeEvent();

//   @override
//   List<Object?> get props => [];
// }

// class FetchRecipe extends HomeEvent {}

// class FetchAllRecipes extends HomeEvent {}

// class LoadStoredRecipe extends HomeEvent {
//   final RecipeModel recipe;

//   const LoadStoredRecipe(this.recipe);

//   @override
//   List<Object?> get props => [recipe];
// }
import 'package:equatable/equatable.dart';
import 'package:recipehut/data/models/recipe_model.dart';

// abstract class HomeEvent extends Equatable {
//   const HomeEvent();

//   @override
//   List<Object?> get props => [];
// }

// class FetchRecipe extends HomeEvent {}

// class FetchAllRecipes extends HomeEvent {}

// class LoadStoredRecipe extends HomeEvent {
//   final RecipeModel recipe;

//   const LoadStoredRecipe(this.recipe);

//   @override
//   List<Object?> get props => [recipe];
// }
abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class FetchRecipe extends HomeEvent {}

class FetchAllRecipes extends HomeEvent {}

class LoadStoredRecipe extends HomeEvent {
  final RecipeModel recipe;

  const LoadStoredRecipe(this.recipe);

  @override
  List<Object?> get props => [recipe];
}

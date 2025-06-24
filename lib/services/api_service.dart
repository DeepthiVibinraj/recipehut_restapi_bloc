// // lib/services/api_service.dart
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import '../models/recipe_model.dart';

// class ApiService {
//   static const String _apiKey =
//       'c862ca137b194bbd8a613e42be38fa84'; // Replace with your Spoonacular API key

//   Future<RecipeModel> fetchRecipe() async {
//     final url = Uri.parse(
//         'https://api.spoonacular.com/recipes/random?number=1&apiKey=$_apiKey');
//     final response = await http.get(url);

//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);
//       return RecipeModel.fromJson(data['recipes'][0]);
//     } else {
//       throw Exception('Failed to load recipe');
//     }
//   }
// }
import 'package:http/http.dart' as http;
import 'package:recipehut/core/constants/api_constants.dart';
import 'dart:convert';
import '../data/models/recipe_model.dart';

class ApiService {
  Future<RecipeModel> fetchRecipeOfTheDay() async {
    final url =
        Uri.parse('$spoonacularBaseUrl/recipes/random?number=1&apiKey=$apiKey');
    final res = await http.get(url);
    if (res.statusCode == 200) {
      final json = jsonDecode(res.body);
      return RecipeModel.fromJson(json['recipes'][0]);
    }
    throw Exception('Failed to load recipes');
  }

  Future<List<RecipeModel>> fetchPopularRecipes({int count = 10}) async {
    final url = Uri.parse(
        '$spoonacularBaseUrl/recipes/random?number=$count&apiKey=$apiKey');
    final res = await http.get(url);
    if (res.statusCode == 200) {
      final json = jsonDecode(res.body);
      return (json['recipes'] as List)
          .map((e) => RecipeModel.fromJson(e))
          .toList();
    }
    throw Exception('Failed to load recipes');
  }
}

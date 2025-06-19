import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipehut/models/recipe_model.dart';
import 'package:recipehut/view_models/bloc/home_bloc.dart';
import 'package:recipehut/view_models/bloc/home_event.dart';
import 'package:recipehut/views/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'services/api_service.dart';

import 'dart:convert';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final storedDate = prefs.getString('lastRecipeDate');
  final today = DateTime.now().toIso8601String().split('T').first;

  RecipeModel? storedRecipe;

  if (storedDate == today) {
    final recipeJson = prefs.getString('recipeOfTheDay');
    if (recipeJson != null) {
      storedRecipe = RecipeModel.fromJson(jsonDecode(recipeJson));
    }
  }

  runApp(MyApp(storedRecipe: storedRecipe));
}

class MyApp extends StatelessWidget {
  final RecipeModel? storedRecipe;
  const MyApp({super.key, required this.storedRecipe});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe Hut',
      theme: ThemeData(
        primarySwatch: Colors.green,
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (_) => HomeBloc(ApiService())
          ..add(storedRecipe != null
              ? LoadStoredRecipe(storedRecipe!)
              : FetchRecipe()),
        child: HomePage(),
      ),
    );
  }
}

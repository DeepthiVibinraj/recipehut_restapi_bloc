// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:recipehut/data/models/recipe_model.dart';
// import 'package:recipehut/view_models/bloc/home/home_bloc.dart';
// import 'package:recipehut/view_models/bloc/home/home_event.dart';
// import 'package:recipehut/views/home/home_page.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import 'services/api_service.dart';

// import 'dart:convert';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   final prefs = await SharedPreferences.getInstance();
//   final storedDate = prefs.getString('lastRecipeDate');
//   final today = DateTime.now().toIso8601String().split('T').first;

//   RecipeModel? storedRecipe;

//   if (storedDate == today) {
//     final recipeJson = prefs.getString('recipeOfTheDay');
//     if (recipeJson != null) {
//       storedRecipe = RecipeModel.fromJson(jsonDecode(recipeJson));
//     }
//   }

//   runApp(MyApp(storedRecipe: storedRecipe));
// }

// class MyApp extends StatelessWidget {
//   final RecipeModel? storedRecipe;
//   const MyApp({super.key, required this.storedRecipe});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Recipe Hut',
//       theme: ThemeData(
//         primarySwatch: Colors.green,
//         useMaterial3: true,
//       ),
//       home: BlocProvider(
//         create: (_) => HomeBloc(ApiService())
//           ..add(storedRecipe != null
//               ? LoadStoredRecipe(storedRecipe!)
//               : FetchRecipe()),
//         child: HomePage(),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipehut/services/api_service.dart';
import 'package:recipehut/view_models/bloc/auth/auth_bloc.dart';
import 'package:recipehut/view_models/bloc/home/home_bloc.dart';
import 'package:recipehut/view_models/bloc/home/home_event.dart';
import 'package:recipehut/views/auth/signup_page.dart';

import 'data/repositories/auth_repository.dart';
import 'services/storage_service.dart';

import 'views/auth/login_page.dart';
import 'views/home/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AuthRepository authRepo = AuthRepository();
  final StorageService storage = StorageService();
  final apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthBloc(authRepo: authRepo, storage: storage),
        ),
        BlocProvider(
          create: (_) => HomeBloc(apiService),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Auth App',
        initialRoute: '/',
        routes: {
          '/': (context) => LoginPage(),
          '/signup': (context) => SignupPage(),
        },
      ),
    );
  }
}

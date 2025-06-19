import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipehut/constants/categories.dart';
import 'package:recipehut/view_models/bloc/home_bloc.dart';
import 'package:recipehut/view_models/bloc/home_event.dart';
import 'package:recipehut/view_models/bloc/home_state.dart';
import 'package:recipehut/widgets/category_tile.dart';
import 'package:recipehut/widgets/recipe_card.dart';

// class HomePage extends StatelessWidget {
//   const HomePage({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Recipe Hut')),
//       body: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
//         if (state is HomeLoading) {
//           return const Center(child: CircularProgressIndicator());
//         }
//         if (state is HomeError) {
//           return Center(child: Text(state.message));
//         }
//         if (state is HomeLoaded) {
//           final recipeOTD = state.recipe;
//           final recipes = state.recipes;
//           return SafeArea(
//             child: SingleChildScrollView(
//               padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
//               child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // Recipe of the Day
//                     ClipRRect(
//                       borderRadius: BorderRadius.circular(16),
//                       child: Image.network(recipeOTD.image,
//                           height: 220,
//                           width: double.infinity,
//                           fit: BoxFit.cover),
//                     ),
//                     const SizedBox(height: 12),
//                     Text(recipeOTD.title,
//                         style: const TextStyle(
//                             fontSize: 20, fontWeight: FontWeight.bold)),
//                     const SizedBox(height: 24),
//                     const Text('Categories',
//                         style: TextStyle(
//                             fontSize: 20, fontWeight: FontWeight.bold)),
//                     const SizedBox(height: 8),
//                     SizedBox(
//                       height: 90,
//                       child: ListView.separated(
//                         scrollDirection: Axis.horizontal,
//                         itemCount: recipeCategories.length,
//                         separatorBuilder: (_, __) => const SizedBox(width: 12),
//                         itemBuilder: (context, idx) {
//                           final c = recipeCategories[idx];
//                           return CategoryTile(
//                               title: c['name']!,
//                               imageUrl: c['image']!,
//                               onTap: () {});
//                         },
//                       ),
//                     ),
//                     const SizedBox(height: 24),
//                     const Text(
//                       'Popular Recipes',
//                       style:
//                           TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                     ),
//                     const SizedBox(height: 8),
//                     ListView.builder(
//                       shrinkWrap: true,
//                       primary: false,
//                       physics: const NeverScrollableScrollPhysics(),
//                       itemCount: recipes.length,
//                       itemBuilder: (ctx, i) => RecipeCard(recipe: recipes[i]),
//                     ),
//                   ]),
//             ),
//           );
//         }
//         return const Center(child: Text('No data'));
//       }),
//       // floatingActionButton: FloatingActionButton(
//       //   onPressed: () => context.read<HomeBloc>().add(FetchRecipes()),
//       //   child: const Icon(Icons.refresh),
//       // ),
//     );
//   }
// // }
// class HomePage extends StatelessWidget {
//   const HomePage({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Recipe Hut')),
//       body: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
//         if (state is HomeLoading) {
//           return const Center(child: CircularProgressIndicator());
//         }
//         if (state is HomeError) {
//           return Center(child: Text(state.message));
//         }
//         if (state is HomeLoaded) {
//           final recipeOTD = state.recipe;
//           final recipes = state.recipes;
//           return SingleChildScrollView(
//             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
//             child:
//                 Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//               // Recipe of the Day
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(16),
//                 child: Image.network(recipeOTD.image,
//                     height: 220, width: double.infinity, fit: BoxFit.cover),
//               ),
//               const SizedBox(height: 12),
//               Text(recipeOTD.title,
//                   style: const TextStyle(
//                       fontSize: 20, fontWeight: FontWeight.bold)),
//               const SizedBox(height: 24),
//               const Text('Categories',
//                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//               const SizedBox(height: 8),
//               SizedBox(
//                 height: 90,
//                 child: ListView.separated(
//                   scrollDirection: Axis.horizontal,
//                   itemCount: recipeCategories.length,
//                   separatorBuilder: (_, __) => const SizedBox(width: 12),
//                   itemBuilder: (context, idx) {
//                     final c = recipeCategories[idx];
//                     return CategoryTile(
//                         title: c['name']!, imageUrl: c['image']!, onTap: () {});
//                   },
//                 ),
//               ),
//               const SizedBox(height: 24),
//               const Text('Popular Recipes',
//                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//               const SizedBox(height: 8),
//               // Use simple Column to avoid nested scroll issue
//               if (recipes.isEmpty)
//                 const Text('No popular recipes today')
//               else
//                 Column(
//                   children: recipes.map((r) => RecipeCard(recipe: r)).toList(),
//                 ),
//             ]),
//           );
//         }
//         return const Center(child: Text('No data'));
//       }),
//     );
//   }
// }

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Recipe Hut')),
      body: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
        if (state is HomeLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is HomeError) {
          return Center(child: Text(state.message));
        }
        if (state is HomeLoaded) {
          final recipeOTD = state.recipeOfTheDay;
          final recipes = state.recipes;
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              // Recipe of the Day
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(recipeOTD.image,
                    height: 220, width: double.infinity, fit: BoxFit.cover),
              ),
              const SizedBox(height: 12),
              Text(recipeOTD.title,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 24),
              const Text('Categories',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              SizedBox(
                height: 90,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: recipeCategories.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                  itemBuilder: (context, idx) {
                    final c = recipeCategories[idx];
                    return CategoryTile(
                        title: c['name']!, imageUrl: c['image']!, onTap: () {});
                  },
                ),
              ),
              const SizedBox(height: 24),
              const Text('Popular Recipes',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              // Use simple Column to avoid nested scroll issue
              if (recipes.isEmpty)
                const Text('No popular recipes today')
              else
                Column(
                  children: recipes.map((r) => RecipeCard(recipe: r)).toList(),
                ),
            ]),
          );
        }
        return const Center(child: Text('No data'));
      }),
    );
  }
}

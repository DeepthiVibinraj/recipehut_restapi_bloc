import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipehut/core/constants/categories.dart';
import 'package:recipehut/data/models/user_model.dart';
import 'package:recipehut/view_models/bloc/home/home_bloc.dart';
import 'package:recipehut/view_models/bloc/home/home_state.dart';
import 'package:recipehut/widgets/category_tile.dart';
import 'package:recipehut/widgets/recipe_card.dart';

class HomePage extends StatelessWidget {
  final UserModel user;
  const HomePage({super.key, required this.user});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        drawer: Drawer(),
        appBar: AppBar(
          backgroundColor: Colors.grey[100],
        ),
        body: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
          int timeNow = DateTime.now().hour;
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
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              timeNow <= 12
                                  ? 'Good Morning'
                                  : ((timeNow > 12) && (timeNow <= 16))
                                      ? 'Good Afternoon'
                                      : 'Good Evening',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Text(user.userName,
                                style: Theme.of(context).textTheme.titleLarge!)
                            // Text('Amritha Balan',
                            //     style: Theme.of(context).textTheme.titleLarge!)
                          ],
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.grey,
                          radius: 30,
                          child: Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 40,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text('What would you like to cook today?',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            ?.copyWith(fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          prefixIcon: Icon(Icons.search),
                          filled: true,
                          fillColor: Colors.white,
                          label: Text('Search any recipe')),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    //const SizedBox(height: 24),
                    const Text('Categories',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
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
                              title: c['name']!,
                              imageUrl: c['image']!,
                              onTap: () {});
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text('Recipe of the Day',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),

                    // Recipe of the Day
                    Container(
                      color: Colors.white,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(recipeOTD.image,
                            height: 220,
                            width: double.infinity,
                            fit: BoxFit.cover),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(recipeOTD.title,
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 20),
                    // const SizedBox(height: 24),
                    // const Text('Categories',
                    //     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    // const SizedBox(height: 8),

                    // const SizedBox(height: 24),
                    const Text('Popular Recipes',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    // Use simple Column to avoid nested scroll issue
                    if (recipes.isEmpty)
                      const Text('No popular recipes today')
                    else
                      // Somewhere inside your page ↓
                      SizedBox(
                        height: 260, // 180 image + padding + text
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.only(
                              right: 16), // nice leading space
                          itemCount: recipes.length,
                          itemBuilder: (context, index) {
                            final r = recipes[index];
                            return Padding(
                              padding: const EdgeInsets.only(
                                  right: 16), // space between cards
                              child: SizedBox(
                                width: 200, // 🔑 give each card a width
                                child: RecipeCard(recipe: r),
                              ),
                            );
                          },
                        ),
                      ),
                  ]),
            );
          }
          return const Center(child: Text('No data'));
        }),
      ),
    );
  }
}

// // import 'package:flutter/material.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:recipehut/view_models/bloc/auth/auth_bloc.dart';
// // import 'package:recipehut/view_models/bloc/auth/auth_event.dart';

// // class HomePage extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text("Home"),
// //         actions: [
// //           IconButton(
// //             icon: Icon(Icons.logout),
// //             onPressed: () {
// //               context.read<AuthBloc>().add(LogoutRequested());
// //               Navigator.pushReplacementNamed(context, '/');
// //             },
// //           )
// //         ],
// //       ),
// //       body: Center(child: Text("Welcome! You're logged in.")),
// //     );
// //   }
// // // }
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:recipehut/core/constants/categories.dart';

// import 'package:recipehut/view_models/bloc/home/home_bloc.dart';
// import 'package:recipehut/view_models/bloc/home/home_state.dart';

// import 'package:recipehut/widgets/category_tile.dart';
// import 'package:recipehut/widgets/recipe_card.dart';

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
//           final recipeOTD = state.recipeOfTheDay;
//           final recipes = state.recipes;
//           return SafeArea(
//             child: SingleChildScrollView(
//               padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
//               child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     //Recipe of the Day
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
// }
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:recipehut/core/constants/categories.dart';
// import 'package:recipehut/view_models/bloc/home/home_bloc.dart';
// import 'package:recipehut/view_models/bloc/home/home_state.dart';
// import 'package:recipehut/widgets/category_tile.dart';
// import 'package:recipehut/widgets/recipe_card.dart';

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
//           final recipeOTD = state.recipeOfTheDay;
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
//           final recipeOTD = state.recipeOfTheDay;
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
//               // const Text('Popular Recipes',
//               //     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//               // const SizedBox(height: 8),
//               // // Use simple Column to avoid nested scroll issue
//               // if (recipes.isEmpty)
//               //   const Text('No popular recipes today')
//               // else
//               //   Column(
//               //     children: recipes.map((r) => RecipeCard(recipe: r)).toList(),
//               //   ),
//             ]),
//           );
//         }
//         return const Center(child: Text('No data'));
//       }),
//     );
//   }
// }

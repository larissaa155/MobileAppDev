import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Map<String, String>> recipes = [
    {'name': 'Pasta', 'ingredients': 'Tomatoes, Pasta, Cheese', 'instructions': 'Boil pasta, add sauce, mix well.'},
    {'name': 'Pizza', 'ingredients': 'Dough, Tomato Sauce, Cheese', 'instructions': 'Roll dough, add sauce, bake.'},
    {'name': 'Salad', 'ingredients': 'Lettuce, Tomato, Cucumber', 'instructions': 'Chop and mix ingredients.'},
  ];

  List<Map<String, String>> favoriteRecipes = [];

  void toggleFavorite(Map<String, String> recipe) {
    setState(() {
      if (favoriteRecipes.contains(recipe)) {
        favoriteRecipes.remove(recipe);
      } else {
        favoriteRecipes.add(recipe);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe Book',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeScreen(recipes: recipes, toggleFavorite: toggleFavorite, favoriteRecipes: favoriteRecipes),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final List<Map<String, String>> recipes;
  final List<Map<String, String>> favoriteRecipes;
  final Function toggleFavorite;

  HomeScreen({required this.recipes, required this.toggleFavorite, required this.favoriteRecipes});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Recipe Book')),
      body: ListView.builder(
        itemCount: recipes.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(recipes[index]['name']!),
            trailing: IconButton(
              icon: Icon(Icons.favorite, color: favoriteRecipes.contains(recipes[index]) ? Colors.red : Colors.grey),
              onPressed: () => toggleFavorite(recipes[index]),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsScreen(recipe: recipes[index], toggleFavorite: toggleFavorite, isFavorite: favoriteRecipes.contains(recipes[index])),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.favorite),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FavoritesScreen(favoriteRecipes: favoriteRecipes, toggleFavorite: toggleFavorite),
            ),
          );
        },
      ),
    );
  }
}

class DetailsScreen extends StatelessWidget {
  final Map<String, String> recipe;
  final Function toggleFavorite;
  final bool isFavorite;

  DetailsScreen({required this.recipe, required this.toggleFavorite, required this.isFavorite});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(recipe['name']!)),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Ingredients: ${recipe['ingredients']}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Instructions: ${recipe['instructions']}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                toggleFavorite(recipe);
                Navigator.pop(context);
              },
              child: Text(isFavorite ? 'Remove from Favorites' : 'Add to Favorites'),
            ),
          ],
        ),
      ),
    );
  }
}

class FavoritesScreen extends StatelessWidget {
  final List<Map<String, String>> favoriteRecipes;
  final Function toggleFavorite;

  FavoritesScreen({required this.favoriteRecipes, required this.toggleFavorite});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Favorite Recipes')),
      body: favoriteRecipes.isEmpty
          ? Center(child: Text('No favorites yet!'))
          : ListView.builder(
              itemCount: favoriteRecipes.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(favoriteRecipes[index]['name']!),
                  trailing: IconButton(
                    icon: Icon(Icons.favorite, color: Colors.red),
                    onPressed: () => toggleFavorite(favoriteRecipes[index]),
                  ),
                );
              },
            ),
    );
  }
}

import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../services/api_service.dart';
import 'recipe_detail_screen.dart';
import '../widgets/recipe_tile.dart';
import '../widgets/shimmer_widget.dart';

class RecipeListScreen extends StatefulWidget {
  @override
  _RecipeListScreenState createState() => _RecipeListScreenState();
}

class _RecipeListScreenState extends State<RecipeListScreen>
    with SingleTickerProviderStateMixin {
  List<Recipe> _recipes = [];
  bool _isLoading = false;
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchRecipes('');
  }

  Future<void> fetchRecipes(String query) async {
    setState(() => _isLoading = true);
    try {
      final recipes = await ApiService.fetchRecipes(query);
      setState(() => _recipes = recipes);
    } catch (e) {
      print('Error: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Recipes API App')),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search recipes...',
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () => fetchRecipes(_searchController.text),
                ),
              ),
              onSubmitted: fetchRecipes,
            ),
          ),
          Expanded(
            child: _isLoading
                ? ShimmerWidget()
                : AnimatedList(
              initialItemCount: _recipes.length,
              itemBuilder: (context, index, animation) {
                final recipe = _recipes[index];
                return SlideTransition(
                  position: animation.drive(Tween(
                    begin: Offset(1, 0),
                    end: Offset(0, 0),
                  ).chain(CurveTween(curve: Curves.easeIn))),
                  child: RecipeTile(
                    recipe: recipe,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              RecipeDetailScreen(recipe: recipe),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

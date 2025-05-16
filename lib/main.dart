import 'package:flutter/material.dart';
import 'screens/recipe_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe API App',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: RecipeListScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

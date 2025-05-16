import 'package:flutter/material.dart';
import '../models/recipe.dart';

class RecipeTile extends StatelessWidget {
  final Recipe recipe;
  final VoidCallback onTap;

  const RecipeTile({required this.recipe, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: recipe.id,
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              recipe.imageUrl,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
          ),
          title: Text(recipe.name),
          subtitle: Text(recipe.category),
          trailing: Icon(Icons.arrow_forward_ios, size: 16),
          onTap: onTap,
        ),
      ),
    );
  }
}

class Recipe {
  final String id;
  final String name;
  final String category;
  final String instructions;
  final String imageUrl;

  Recipe({
    required this.id,
    required this.name,
    required this.category,
    required this.instructions,
    required this.imageUrl,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['idMeal'],
      name: json['strMeal'],
      category: json['strCategory'],
      instructions: json['strInstructions'],
      imageUrl: json['strMealThumb'],
    );
  }
}

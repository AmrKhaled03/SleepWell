class MealModel {
  final String idMeal;
  final String strMeal;
  final String strMealThumb;
  final String strInstructions;
  final String strArea;
  final String strYoutube;
  final String strSource;
  final List<Map<String, String>> ingredients;

  MealModel({
    required this.idMeal,
    required this.strMeal,
    required this.strMealThumb,
    required this.strInstructions,
    required this.strArea,
    required this.strYoutube,
    required this.strSource,
    required this.ingredients,
  });

  factory MealModel.fromJson(Map<String, dynamic> json) {
    List<Map<String, String>> ingredientsList = [];

    for (int i = 1; i <= 20; i++) {
      String? ingredient = json['strIngredient$i'];
      String? measure = json['strMeasure$i'];

      if (ingredient != null && ingredient.trim().isNotEmpty) {
        ingredientsList.add({
          'ingredient': ingredient.trim(),
          'measure': (measure ?? '').trim(),
        });
      }
    }

    return MealModel(
      idMeal: json['idMeal'],
      strMeal: json['strMeal'],
      strMealThumb: json['strMealThumb'],
      strInstructions: json['strInstructions'] ?? '',
      strArea: json['strArea'] ?? '',
      strYoutube: json['strYoutube'] ?? '',
      strSource: json['strSource'] ?? '',
      ingredients: ingredientsList,
    );
  }
}

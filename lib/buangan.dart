// --- Data Models (Example - can be expanded) ---
// You would typically define classes for FoodItem, Nutrients, etc.
// For simplicity, we are using strings for now.

/*
Example of how you might expand data models:

class FoodItem {
  final String name;
  final FoodCategory category;
  final Nutrients nutrients;

  FoodItem({required this.name, required this.category, required this.nutrients});
}

enum FoodCategory {
  vegetable,
  fruit,
  protein,
  carbohydrate,
  dairy,
  fat,
  other
}

class Nutrients {
  final double calories;
  final double proteinGrams;
  final double carbGrams;
  final double fatGrams;
  // ... other nutrients like vitamins, minerals

  Nutrients({
    this.calories = 0,
    this.proteinGrams = 0,
    this.carbGrams = 0,
    this.fatGrams = 0,
  });
}
*/

import 'package:gudfud/food_db.dart';

class ConsumedFoodLog {
  final String userInput; // What the user typed
  final FoodItem? matchedFood; // The FoodItem from DB, if matched
  final NutrientProfile consumedNutrients; // Nutrients for the serving consumed
  final double servingWeightGrams; // The weight of the serving consumed

  ConsumedFoodLog({
    required this.userInput,
    this.matchedFood,
    required this.consumedNutrients,
    required this.servingWeightGrams,
  });
}

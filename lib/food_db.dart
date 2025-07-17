// --- Data Models for Food Database ---

// Represents the nutritional breakdown of a food item.
// Values are typically per 100g or per standard serving.
class NutrientProfile {
  final double calories;
  final double proteinGrams;
  final double carbGrams;
  final double fatGrams;
  final double fiberGrams; // Added fiber as it's important
  // You can add more: e.g., sugarGrams, sodiumMg, vitaminCmg, ironMg, etc.

  NutrientProfile({
    this.calories = 0,
    this.proteinGrams = 0,
    this.carbGrams = 0,
    this.fatGrams = 0,
    this.fiberGrams = 0,
  });

  // Optional: A method to display nutrient info, useful for debugging
  @override
  String toString() {
    return 'Calories: $calories kcal, Protein: ${proteinGrams}g, Carbs: ${carbGrams}g, Fat: ${fatGrams}g, Fiber: ${fiberGrams}g';
  }

  NutrientProfile operator +(NutrientProfile other) {
    return NutrientProfile(
      calories: calories + other.calories,
      proteinGrams: proteinGrams + other.proteinGrams,
      carbGrams: carbGrams + other.carbGrams,
      fatGrams: fatGrams + other.fatGrams,
      fiberGrams: fiberGrams + other.fiberGrams,
    );
  }

  // Method to subtract another NutrientProfile from this one
  NutrientProfile operator -(NutrientProfile other) {
    return NutrientProfile(
      calories: calories - other.calories,
      proteinGrams: proteinGrams - other.proteinGrams,
      carbGrams: carbGrams - other.carbGrams,
      fatGrams: fatGrams - other.fatGrams,
      fiberGrams: fiberGrams - other.fiberGrams,
    );
  }

  // Method to get a new profile scaled by a factor (e.g. for different serving sizes)
  NutrientProfile scale(double factor) {
    return NutrientProfile(
      calories: calories * factor,
      proteinGrams: proteinGrams * factor,
      carbGrams: carbGrams * factor,
      fatGrams: fatGrams * factor,
      fiberGrams: fiberGrams * factor,
    );
  }
}

// Enum to categorize food items. This helps in broader dietary analysis.
enum FoodCategory {
  fruit,
  vegetable,
  grain, // Includes rice, bread, pasta, oats
  proteinLean, // Chicken breast, fish, tofu, lentils
  proteinFatty, // Salmon, beef steak, nuts
  dairy, // Milk, cheese, yogurt
  healthyFat, // Avocado, olive oil, nuts, seeds
  sweetSnack, // Cookies, candy (less emphasis on detailed nutrients, more on category)
  saltySnack, // Chips, pretzels
  beverage,
  other, // For items that don't fit neatly
  unknown,
}

// Represents a single food item in your database.
class FoodItem {
  final String id; // A unique identifier for each food item
  final String name; // User-friendly name, e.g., "Apple, raw, with skin"
  final FoodCategory category;
  final NutrientProfile nutrientsPer100g; // Nutrient values per 100 grams
  final String
      commonServingSizeDesc; // e.g., "1 medium (approx 180g)", "1 cup (cooked, 160g)"
  final double
      commonServingWeightGrams; // Weight of the common serving in grams

  FoodItem({
    required this.id,
    required this.name,
    required this.category,
    required this.nutrientsPer100g,
    this.commonServingSizeDesc = "100g", // Default if not specified
    this.commonServingWeightGrams = 100.0, // Default if not specified
  });

  // Optional: Method to calculate nutrients for a specific serving weight
  NutrientProfile getNutrientsForServing(double servingWeightGrams) {
    double factor = servingWeightGrams / 100.0; // Assuming nutrientsPer100g
    return NutrientProfile(
      calories: nutrientsPer100g.calories * factor,
      proteinGrams: nutrientsPer100g.proteinGrams * factor,
      carbGrams: nutrientsPer100g.carbGrams * factor,
      fatGrams: nutrientsPer100g.fatGrams * factor,
      fiberGrams: nutrientsPer100g.fiberGrams * factor,
    );
  }

  @override
  String toString() {
    return '$name ($category) - Nutrients per 100g: $nutrientsPer100g';
  }
}

// --- Sample Food Database ---
// This is a list of FoodItem objects. You'll expand this significantly.
// Nutrient values are ESTIMATIONS and should be verified/updated from reliable sources.

List<FoodItem> foodDatabase = [
  // Fruits
  FoodItem(
    id: "F001",
    name: "Apel",
    category: FoodCategory.fruit,
    nutrientsPer100g: NutrientProfile(
        calories: 58,
        proteinGrams: 0.3,
        carbGrams: 14.9,
        fatGrams: 0.4,
        fiberGrams: 2.6),
    commonServingSizeDesc: "1 buah",
    commonServingWeightGrams: 100.0,
  ),
  FoodItem(
    id: "F002",
    name: "Pisang, pisang ambon",
    category: FoodCategory.fruit,
    nutrientsPer100g: NutrientProfile(
        calories: 108,
        proteinGrams: 1.1,
        carbGrams: 24.3,
        fatGrams: 0.8,
        fiberGrams: 1.9),
    commonServingSizeDesc: "1 buah",
    commonServingWeightGrams: 100.0,
  ),
  FoodItem(
    id: "F003",
    name: "Jeruk",
    category: FoodCategory.fruit,
    nutrientsPer100g: NutrientProfile(
        calories: 47,
        proteinGrams: 0.9,
        carbGrams: 12,
        fatGrams: 0.1,
        fiberGrams: 2.4),
    commonServingSizeDesc: "1 medium (approx 130g)",
    commonServingWeightGrams: 130.0,
  ),
  FoodItem(
    id: "F004",
    name: "Stroberi",
    category: FoodCategory.fruit,
    nutrientsPer100g: NutrientProfile(
        calories: 32,
        proteinGrams: 0.7,
        carbGrams: 8,
        fatGrams: 0.3,
        fiberGrams: 2.0),
    commonServingSizeDesc: "1 cup, whole (approx 152g)",
    commonServingWeightGrams: 152.0,
  ),

  // Vegetables
  FoodItem(
    id: "V001",
    name: "Brokoli", // Or specify cooked if that's the primary data
    category: FoodCategory.vegetable,
    nutrientsPer100g: NutrientProfile(
        calories: 34,
        proteinGrams: 2.8,
        carbGrams: 7,
        fatGrams: 0.4,
        fiberGrams: 2.6),
    commonServingSizeDesc: "1 cup, chopped (approx 91g)",
    commonServingWeightGrams: 91.0,
  ),
  FoodItem(
    id: "V002",
    name: "Sayur bayam, Bayem",
    category: FoodCategory.vegetable,
    nutrientsPer100g: NutrientProfile(
        calories: 23,
        proteinGrams: 2.9,
        carbGrams: 3.6,
        fatGrams: 0.4,
        fiberGrams: 2.2),
    commonServingSizeDesc: "1 cup (approx 30g)",
    commonServingWeightGrams: 30.0,
  ),
  FoodItem(
    id: "V003",
    name: "Wortel",
    category: FoodCategory.vegetable,
    nutrientsPer100g: NutrientProfile(
        calories: 41,
        proteinGrams: 0.9,
        carbGrams: 10,
        fatGrams: 0.2,
        fiberGrams: 2.8),
    commonServingSizeDesc: "1 medium (approx 61g)",
    commonServingWeightGrams: 61.0,
  ),
  FoodItem(
    id: "V004",
    name: "Timun, mentimun, ketimun",
    category: FoodCategory.vegetable,
    nutrientsPer100g: NutrientProfile(
        calories: 15,
        proteinGrams: 0.7,
        carbGrams: 3.6,
        fatGrams: 0.1,
        fiberGrams: 0.5),
    commonServingSizeDesc: "1/2 medium (approx 100g)",
    commonServingWeightGrams: 100.0,
  ),

  // Proteins
  FoodItem(
    id: "P001",
    name: "Dada Ayam Goreng, dada ayam",
    category: FoodCategory.proteinLean,
    nutrientsPer100g: NutrientProfile(
        calories: 244,
        proteinGrams: 36.7,
        carbGrams: 1,
        fatGrams: 9.2,
        fiberGrams: 0),
    commonServingSizeDesc: "100g",
    commonServingWeightGrams: 100.0,
  ),
  FoodItem(
    id: "P0012",
    name: "Paha Ayam Goreng, paha ayam",
    category: FoodCategory.proteinLean,
    nutrientsPer100g: NutrientProfile(
        calories: 283,
        proteinGrams: 35.7,
        carbGrams: 0.5,
        fatGrams: 14.3,
        fiberGrams: 0),
    commonServingSizeDesc: "100g",
    commonServingWeightGrams: 100.0,
  ),
  FoodItem(
    id: "P0013",
    name: "Sate Ayam",
    category: FoodCategory.proteinLean,
    nutrientsPer100g: NutrientProfile(
        calories: 225,
        proteinGrams: 19.54,
        carbGrams: 4.87,
        fatGrams: 14.82,
        fiberGrams: 0),
    commonServingSizeDesc: "100g",
    commonServingWeightGrams: 100.0,
  ),
  FoodItem(
    id: "P0014",
    name: "Rendang Sapi, rendang",
    category: FoodCategory.proteinLean,
    nutrientsPer100g: NutrientProfile(
        calories: 193,
        proteinGrams: 22.6,
        carbGrams: 7.8,
        fatGrams: 7.9,
        fiberGrams: 0),
    commonServingSizeDesc: "100g",
    commonServingWeightGrams: 100.0,
  ),
  FoodItem(
    id: "P002",
    name: "Salmon",
    category: FoodCategory.proteinFatty,
    nutrientsPer100g: NutrientProfile(
        calories: 208,
        proteinGrams: 20,
        carbGrams: 0,
        fatGrams: 13,
        fiberGrams: 0),
    commonServingSizeDesc: "3 oz (approx 85g)",
    commonServingWeightGrams: 85.0,
  ),
  FoodItem(
    id: "P003",
    name: "Telur, telor",
    category: FoodCategory
        .proteinLean, // Can also be fatty depending on how many yolks
    nutrientsPer100g: NutrientProfile(
        calories: 155,
        proteinGrams: 13,
        carbGrams: 1.1,
        fatGrams: 11,
        fiberGrams: 0),
    commonServingSizeDesc: "1 large egg (approx 50g)",
    commonServingWeightGrams: 50.0,
  ),
  // FoodItem(
  //   id: "P004",
  //   name: "Lentils, cooked, boiled",
  //   category: FoodCategory.proteinLean, // Also a good source of carbs and fiber
  //   nutrientsPer100g: NutrientProfile(
  //       calories: 116,
  //       proteinGrams: 9,
  //       carbGrams: 20,
  //       fatGrams: 0.4,
  //       fiberGrams: 7.9),
  //   commonServingSizeDesc: "1/2 cup (approx 100g)",
  //   commonServingWeightGrams: 100.0,
  // ),
  FoodItem(
    id: "P005",
    name: "Tahu",
    category: FoodCategory.proteinLean,
    nutrientsPer100g: NutrientProfile(
        calories: 76,
        proteinGrams: 8,
        carbGrams: 1.9,
        fatGrams: 4.8,
        fiberGrams: 0.3), // Fiber can vary
    commonServingSizeDesc: "1/2 cup (approx 126g)",
    commonServingWeightGrams: 126.0,
  ),

  // Grains
  FoodItem(
    id: "G001",
    name: "Nasi, nasi putih (1 centong)",
    category: FoodCategory.grain,
    nutrientsPer100g: NutrientProfile(
        calories: 180,
        proteinGrams: 3,
        carbGrams: 39.8,
        fatGrams: 0.3,
        fiberGrams: 0.2),
    commonServingSizeDesc: "1 centong (approx 100g)",
    commonServingWeightGrams: 100.0,
  ),
  FoodItem(
    id: "G0012",
    name: "Mie, mie instan, indomie",
    category: FoodCategory.grain,
    nutrientsPer100g: NutrientProfile(
        calories: 350,
        proteinGrams: 8,
        carbGrams: 52,
        fatGrams: 12,
        fiberGrams: 0),
    commonServingSizeDesc: "1 bungkus",
    commonServingWeightGrams: 80.0,
  ),
  FoodItem(
    id: "G0013",
    name: "Bakso",
    category: FoodCategory.grain,
    nutrientsPer100g: NutrientProfile(
        calories: 357,
        proteinGrams: 29,
        carbGrams: 24,
        fatGrams: 19,
        fiberGrams: 0),
    commonServingSizeDesc: "1 mangkuk",
    commonServingWeightGrams: 80.0,
  ),
  FoodItem(
    id: "G0014",
    name: "Soto Ayam",
    category: FoodCategory.grain,
    nutrientsPer100g: NutrientProfile(
        calories: 312,
        proteinGrams: 24,
        carbGrams: 20,
        fatGrams: 15,
        fiberGrams: 0),
    commonServingSizeDesc: "1 mangkuk",
    commonServingWeightGrams: 100.0,
  ),
  FoodItem(
    id: "G0015",
    name: "Tempe Goreng",
    category: FoodCategory.grain,
    nutrientsPer100g: NutrientProfile(
        calories: 190,
        proteinGrams: 18,
        carbGrams: 8,
        fatGrams: 8,
        fiberGrams: 1.4),
    commonServingSizeDesc: "1 potong sedang",
    commonServingWeightGrams: 100.0,
  ),
  FoodItem(
    id: "G0016",
    name: "Tahu Goreng",
    category: FoodCategory.grain,
    nutrientsPer100g: NutrientProfile(
        calories: 115,
        proteinGrams: 9.7,
        carbGrams: 2.5,
        fatGrams: 8.5,
        fiberGrams: 1.4),
    commonServingSizeDesc: "1 potong sedang",
    commonServingWeightGrams: 100.0,
  ),
  FoodItem(
    id: "G002",
    name: "Nasi Merah",
    category: FoodCategory.grain,
    nutrientsPer100g: NutrientProfile(
        calories: 149,
        proteinGrams: 2.8,
        carbGrams: 32.5,
        fatGrams: 0.4,
        fiberGrams: 0.3),
    commonServingSizeDesc: "1 centong (approx 100g)",
    commonServingWeightGrams: 100.0,
  ),
  FoodItem(
    id: "G0021",
    name: "Nasi Goreng",
    category: FoodCategory.grain,
    nutrientsPer100g: NutrientProfile(
        calories: 168,
        proteinGrams: 6.3,
        carbGrams: 21.1,
        fatGrams: 6.2,
        fiberGrams: 0.3),
    commonServingSizeDesc: "1 centong (approx 100g)",
    commonServingWeightGrams: 100.0,
  ),
  FoodItem(
    id: "G003",
    name: "Roti",
    category: FoodCategory.grain,
    nutrientsPer100g: NutrientProfile(
        calories: 247,
        proteinGrams: 13,
        carbGrams: 41,
        fatGrams: 3.4,
        fiberGrams: 6.9),
    commonServingSizeDesc: "1 slice (approx 30g)",
    commonServingWeightGrams: 30.0,
  ),
  FoodItem(
    id: "G004",
    name: "Gandum, oats, oat",
    category: FoodCategory.grain,
    nutrientsPer100g: NutrientProfile(
        calories: 389,
        proteinGrams: 16.9,
        carbGrams: 66.3,
        fatGrams: 6.9,
        fiberGrams: 10.6),
    commonServingSizeDesc: "1/2 cup dry (approx 40g)",
    commonServingWeightGrams: 40.0,
  ),

  // Dairy
  FoodItem(
    id: "D001",
    name: "Susu",
    category: FoodCategory.dairy,
    nutrientsPer100g: NutrientProfile(
        calories: 61,
        proteinGrams: 3.2,
        carbGrams: 4.8,
        fatGrams: 3.3,
        fiberGrams: 0), // 100g milk is approx 97ml
    commonServingSizeDesc: "1 cup (approx 244g)",
    commonServingWeightGrams: 244.0,
  ),
  FoodItem(
    id: "D002",
    name: "Yogurt",
    category: FoodCategory.dairy,
    nutrientsPer100g: NutrientProfile(
        calories: 61,
        proteinGrams: 3.5,
        carbGrams: 4.7,
        fatGrams: 3.3,
        fiberGrams: 0),
    commonServingSizeDesc: "1 container (6 oz, approx 170g)",
    commonServingWeightGrams: 170.0,
  ),
  FoodItem(
    id: "D003",
    name: "Keju",
    category: FoodCategory.dairy, // Also a source of fat and protein
    nutrientsPer100g: NutrientProfile(
        calories: 404,
        proteinGrams: 23,
        carbGrams: 3.1,
        fatGrams: 33,
        fiberGrams: 0),
    commonServingSizeDesc: "1 oz (approx 28g)",
    commonServingWeightGrams: 28.0,
  ),

  // Healthy Fats
  FoodItem(
    id: "HF001",
    name: "Alpukat, alpuket",
    category: FoodCategory.healthyFat, // Also a fruit
    nutrientsPer100g: NutrientProfile(
        calories: 160,
        proteinGrams: 2,
        carbGrams: 9,
        fatGrams: 15,
        fiberGrams: 7),
    commonServingSizeDesc: "1/2 medium (approx 100g)",
    commonServingWeightGrams: 100.0,
  ),
  FoodItem(
    id: "HF002",
    name: "Kacang Almond, almond",
    category: FoodCategory.healthyFat, // Also protein
    nutrientsPer100g: NutrientProfile(
        calories: 579,
        proteinGrams: 21,
        carbGrams: 22,
        fatGrams: 50,
        fiberGrams: 12.5),
    commonServingSizeDesc: "1 oz (23 almonds, approx 28g)",
    commonServingWeightGrams: 28.0,
  ),
  FoodItem(
    id: "HF003",
    name: "Minyak zaitun",
    category: FoodCategory.healthyFat,
    nutrientsPer100g: NutrientProfile(
        calories: 884,
        proteinGrams: 0,
        carbGrams: 0,
        fatGrams: 100,
        fiberGrams: 0),
    commonServingSizeDesc: "1 tablespoon (approx 14g)",
    commonServingWeightGrams: 14.0,
  ),

  // Add more categories and items as needed (e.g., beverages, snacks)
];

// --- Example Usage (How you might access this data) ---
void main() {
  // Find a food item by name (you'd likely use ID or a more robust search)
  FoodItem? apple = foodDatabase.firstWhere(
    (item) => item.name.toLowerCase().contains("apple"),
    orElse: () => FoodItem(
        // Return a dummy item or handle null
        id: "NULL",
        name: "Not Found",
        category: FoodCategory.unknown,
        nutrientsPer100g: NutrientProfile()),
  );

  if (apple.id != "NULL") {
    print("Found: ${apple.name}");
    print("Category: ${apple.category}");
    print("Nutrients per 100g: ${apple.nutrientsPer100g}");
    print(
        "Common serving: ${apple.commonServingSizeDesc} (${apple.commonServingWeightGrams}g)");

    // Calculate nutrients for a specific serving, e.g., 150g of apple
    double myAppleServingGrams = 150.0;
    NutrientProfile appleServingNutrients =
        apple.getNutrientsForServing(myAppleServingGrams);
    print(
        "Nutrients for $myAppleServingGrams g of ${apple.name}: $appleServingNutrients");
  } else {
    print("Apple not found in the database.");
  }

  // Example: Get all fruits
  List<FoodItem> fruits = foodDatabase
      .where((item) => item.category == FoodCategory.fruit)
      .toList();
  print("\nAll Fruits in Database:");
  fruits.forEach((fruit) => print("- ${fruit.name}"));
}

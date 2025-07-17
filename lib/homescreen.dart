import 'package:flutter/material.dart';
import 'package:gudfud/consumed_food.dart';
import 'package:gudfud/food_db.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _foodInputController = TextEditingController();
  bool _isDailyIntakeFulfilled = false;

  void _updateFulfillmentStatus() {
    if (_consumedFoodLogs.isEmpty) {
      _isDailyIntakeFulfilled = false;
      return;
    }
    _isDailyIntakeFulfilled = _totalConsumedNutrients.calories >=
            _dailyRecommendedIntake.calories &&
        _totalConsumedNutrients.proteinGrams >=
            _dailyRecommendedIntake.proteinGrams &&
        _totalConsumedNutrients.carbGrams >=
            _dailyRecommendedIntake.carbGrams &&
        _totalConsumedNutrients.fatGrams >= _dailyRecommendedIntake.fatGrams &&
        _totalConsumedNutrients.fiberGrams >=
            _dailyRecommendedIntake.fiberGrams;
  }

  // Sekarang pakenya ini
  List<ConsumedFoodLog> _consumedFoodLogs = [];
  NutrientProfile _totalConsumedNutrients = NutrientProfile();

  final NutrientProfile _dailyRecommendedIntake = NutrientProfile(
    calories: 1500,
    proteinGrams: 20,
    carbGrams: 200,
    fatGrams: 30,
    fiberGrams: 10,
  );

  String _recommendation = "Belum ada rekomendasi. Ayo tambah makananmu!";

  // --- DSS Logic (Simple Version) ---
  // This is a very basic placeholder for the DSS logic.
  // We'll discuss more advanced logic later.
  String _getFoodRecommendation() {
    if (_consumedFoodLogs.isEmpty) {
      return "Makan apa saja hari ini? Tambahkan makanan untuk melihat progres nutrisimu.";
    }

    // Calculate remaining needs
    double remainingCalories =
        _dailyRecommendedIntake.calories - _totalConsumedNutrients.calories;
    double remainingProtein = _dailyRecommendedIntake.proteinGrams -
        _totalConsumedNutrients.proteinGrams;
    double remainingCarbs =
        _dailyRecommendedIntake.carbGrams - _totalConsumedNutrients.carbGrams;
    double remainingFat =
        _dailyRecommendedIntake.fatGrams - _totalConsumedNutrients.fatGrams;
    double remainingFiber =
        _dailyRecommendedIntake.fiberGrams - _totalConsumedNutrients.fiberGrams;

    StringBuffer rec = StringBuffer();
    rec.writeln("✨ Asupan Nutrisi Saat Ini ✨");
    rec.writeln(
        "Kalori: ${_totalConsumedNutrients.calories.toStringAsFixed(1)} / ${_dailyRecommendedIntake.calories.toStringAsFixed(1)} kkal");
    rec.writeln(
        "Protein: ${_totalConsumedNutrients.proteinGrams.toStringAsFixed(1)} / ${_dailyRecommendedIntake.proteinGrams.toStringAsFixed(1)} g");
    rec.writeln(
        "Karbo: ${_totalConsumedNutrients.carbGrams.toStringAsFixed(1)} / ${_dailyRecommendedIntake.carbGrams.toStringAsFixed(1)} g");
    rec.writeln(
        "Lemak: ${_totalConsumedNutrients.fatGrams.toStringAsFixed(1)} / ${_dailyRecommendedIntake.fatGrams.toStringAsFixed(1)} g");
    rec.writeln(
        "Serat: ${_totalConsumedNutrients.fiberGrams.toStringAsFixed(1)} / ${_dailyRecommendedIntake.fiberGrams.toStringAsFixed(1)} g");
    rec.writeln("\n🎯 Kebutuhan Nutrisi Lagi:");

    bool allMet = true;

    if (remainingCalories > 0) {
      rec.writeln("🔥 Kalori: ${remainingCalories.toStringAsFixed(1)} kkal");
      allMet = false;
    }
    if (remainingProtein > 0) {
      rec.writeln("💪 Protein: ${remainingProtein.toStringAsFixed(1)} g");
      // Suggest protein sources
      List<String> proteinSources = foodDatabase
          .where((food) =>
              food.category == FoodCategory.proteinLean ||
              food.category == FoodCategory.proteinFatty)
          .map((food) => food.name.split(',')[0]) // Get simpler name
          .take(2) // Take first 2 examples
          .toList();
      if (proteinSources.isNotEmpty)
        rec.writeln("   Coba: ${proteinSources.join(', ')}");
      allMet = false;
    }
    if (remainingCarbs > 0) {
      rec.writeln("🍚 Karbohidrat: ${remainingCarbs.toStringAsFixed(1)} g");
      List<String> carbSources = foodDatabase
          .where((food) => food.category == FoodCategory.grain)
          .map((food) => food.name.split(',')[0])
          .take(2)
          .toList();
      if (carbSources.isNotEmpty)
        rec.writeln("   Coba: ${carbSources.join(', ')}");
      allMet = false;
    }
    if (remainingFat > 0) {
      rec.writeln("🥑 Lemak Sehat: ${remainingFat.toStringAsFixed(1)} g");
      List<String> fatSources = foodDatabase
          .where((food) => food.category == FoodCategory.healthyFat)
          .map((food) => food.name.split(',')[0])
          .take(2)
          .toList();
      if (fatSources.isNotEmpty)
        rec.writeln("   Coba: ${fatSources.join(', ')}");
      allMet = false;
    }
    if (remainingFiber > 0) {
      rec.writeln("🥦 Serat: ${remainingFiber.toStringAsFixed(1)} g");
      List<String> fiberSources = foodDatabase
          .where((food) =>
              food.category == FoodCategory.vegetable ||
              food.category == FoodCategory.fruit)
          .map((food) => food.name.split(',')[0])
          .take(2)
          .toList();
      if (fiberSources.isNotEmpty)
        rec.writeln("   Coba: ${fiberSources.join(', ')}");
      allMet = false;
    }

    if (allMet &&
        _totalConsumedNutrients.calories >= _dailyRecommendedIntake.calories) {
      return "🎉 Selamat! Kebutuhan nutrisi harianmu tampaknya sudah terpenuhi dengan baik berdasarkan target yang ditetapkan. Pertahankan pola makan sehatmu!";
    } else if (allMet &&
        _totalConsumedNutrients.calories < _dailyRecommendedIntake.calories) {
      rec.writeln(
          "\n💡 Semua target nutrisi (protein, karbo, lemak, serat) sudah baik, namun kalori masih kurang. Tambah porsi makanan sehatmu atau pilih makanan padat kalori.");
    }

    return rec.toString();
  }

  // --- Search function to find food in the database ---
  FoodItem? _findFoodInDb(String foodName) {
    String query = foodName.toLowerCase().trim();
    if (query.isEmpty) return null;

    // PRIO SEARCH SAMA PERSIS
    for (var food in foodDatabase) {
      if (food.name.toLowerCase() == query) {
        return food;
      }
    }

    // PRIO 2 SEARCH
    List<FoodItem> startsWithMatches = [];
    for (var food in foodDatabase) {
      if (food.name.toLowerCase().startsWith(query)) {
        startsWithMatches.add(food);
      }
    }
    if (startsWithMatches.isNotEmpty) {
      return startsWithMatches.first;
    }

    //PRIO 3
    List<FoodItem> wholeWordMatches = [];
    try {
      // RegExp.escape is good practice if query could contain special regex characters
      String pattern = r'\b' + RegExp.escape(query) + r'\b';
      RegExp wholeWordRegExp = RegExp(pattern, caseSensitive: false);

      for (var food in foodDatabase) {
        if (wholeWordRegExp.hasMatch(food.name)) {
          wholeWordMatches.add(food);
        }
      }
      if (wholeWordMatches.isNotEmpty) {
        // Again, taking the first one. Further sorting could be applied.
        // print("Search Debug: WholeWord match found -> ${wholeWordMatches.first.name}");
        return wholeWordMatches.first;
      }
    } catch (e) {
      // Handle potential RegExp errors, though unlikely with RegExp.escape
      // print("Search Debug: RegExp error for whole word match: $e");
    }

    List<FoodItem> containsMatches = [];
    for (var food in foodDatabase) {
      if (food.name.toLowerCase().contains(query)) {
        containsMatches.add(food);
      }
    }
    if (containsMatches.isNotEmpty) {
      // To further refine this, you could sort containsMatches.
      // For example, prefer matches where the query isn't preceded by another letter,
      // or matches where the overall item name is shorter.
      // For simplicity now, we'll take the first one.
      // If "Ayam Goreng" or "Sate Ayam" exist, they should have been caught by steps 2 or 3.
      // print("Search Debug: General 'contains' match found -> ${containsMatches.first.name}");
      return containsMatches.first;
    }
    return null; // Not found
  }

  void _addFoodAndGetRecommendation() {
    final String foodInput = _foodInputController.text.trim();
    if (foodInput.isEmpty) {
      setState(() {
        _recommendation = "Masukkan nama makanan terlebih dahulu.";
      });
      return;
    }

    FoodItem? matchedItem = _findFoodInDb(foodInput);
    NutrientProfile nutrientsForThisServing =
        NutrientProfile(); // Default to zero nutrients
    double servingWeight = 0; // Default serving weight

    String foodDisplayName =
        foodInput; // Use user input as default display name

    if (matchedItem != null) {
      // Use common serving size and its nutrients from the database
      servingWeight = matchedItem.commonServingWeightGrams;
      nutrientsForThisServing =
          matchedItem.getNutrientsForServing(servingWeight);
      foodDisplayName = matchedItem.name; // Use database name for clarity
      setState(() {
        _recommendation = "Menambahkan ${matchedItem.name}.";
      });
    } else {
      setState(() {
        _recommendation =
            "$foodInput tidak ditemukan di database. Nutrisi tidak ditambahkan. Periksa ejaan atau tambahkan ke database.";
      });
    }

    final newLog = ConsumedFoodLog(
      userInput: foodInput, // What the user originally typed
      matchedFood: matchedItem,
      consumedNutrients: nutrientsForThisServing,
      servingWeightGrams: servingWeight,
    );

    setState(() {
      _consumedFoodLogs.add(newLog);
      // Add this food's nutrients to the total
      _totalConsumedNutrients =
          _totalConsumedNutrients + nutrientsForThisServing;
      _foodInputController.clear();
      _updateFulfillmentStatus();
      // Update the overall recommendation based on new totals
      _recommendation = _getFoodRecommendation();
    });
  }

  void _resetConsumption() {
    setState(() {
      _consumedFoodLogs.clear();
      _totalConsumedNutrients = NutrientProfile(); // Reset to zeros
      _recommendation = "Belum ada rekomendasi. Ayo tambah makananmu!";
      _foodInputController.clear();
      _updateFulfillmentStatus();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Color cardBackgroundColor;
    Color cardBorderColor;
    Color cardTextColor;
    IconData recommendationIcon;

    if (_isDailyIntakeFulfilled) {
      cardBackgroundColor = Colors.green.shade50;
      cardBorderColor = theme.primaryColor;
      cardTextColor = theme.primaryColorDark;
      recommendationIcon = Icons.check_circle_rounded;
    } else {
      cardBackgroundColor = Colors.orange.shade50;
      cardBorderColor = theme.colorScheme.secondary;
      cardTextColor = theme.colorScheme.secondary;
      recommendationIcon = Icons.lightbulb_rounded;
    }

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Image.asset(
              'assets/gudfud logo.png',
              height: 32,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.fastfood, color: Colors.white);
              },
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              'GudFud',
              style: theme.appBarTheme.titleTextStyle,
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // --- Input Section ---
            TextField(
              controller: _foodInputController,
              decoration: InputDecoration(
                labelText: 'Apa yang kamu makan hari ini?',
                hintText: 'contoh: "Nasi", "Ayam Goreng", "Mie Goreng"',
                prefixIcon: Icon(Icons.restaurant_menu_rounded,
                    color: theme.primaryColor),
                suffixIcon: IconButton(
                  icon: Icon(Icons.add_circle_rounded,
                      color: theme.primaryColor, size: 30),
                  onPressed: _addFoodAndGetRecommendation,
                  tooltip: 'Tambah Makanan',
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              onSubmitted: (_) => _addFoodAndGetRecommendation(),
              style:
                  theme.textTheme.bodyMedium?.copyWith(color: Colors.black87),
            ),
            const SizedBox(height: 4.0),
            // ElevatedButton.icon(
            //   icon: const Icon(Icons.restaurant_menu),
            //   label: const Text('Munculkan Sugesti Makanan'),
            //   onPressed: _addFoodAndGetRecommendation,
            //   style: ElevatedButton.styleFrom(
            //     padding: const EdgeInsets.symmetric(vertical: 12.0),
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(12.0),
            //     ),
            //   ),
            // ),
            const SizedBox(height: 16.0),

            // --- Consumed Foods Display ---
            Text(
              'Hari ini Kamu Makan:',
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(height: 8.0),
            Expanded(
              child: _consumedFoodLogs.isEmpty
                  ? Center(
                      child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.no_food_rounded,
                          size: 60,
                          color: Colors.grey.shade400,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Belum ada makanan/minuman.',
                          style: theme.textTheme.bodyMedium
                              ?.copyWith(color: Colors.grey.shade600),
                        ),
                      ],
                    ))
                  : ListView.builder(
                      itemCount: _consumedFoodLogs.length,
                      itemBuilder: (context, index) {
                        final log = _consumedFoodLogs[index];
                        String title = log.userInput;
                        String subtitle = "Nutrisi tidak ada dalam database!";
                        IconData leadingIconData = Icons.help_outline_rounded;

                        if (log.matchedFood != null) {
                          title = log.matchedFood!.name;
                          subtitle =
                              "${log.consumedNutrients.calories.toStringAsFixed(0)} kkal | P: ${log.consumedNutrients.proteinGrams.toStringAsFixed(0)}g | K: ${log.consumedNutrients.carbGrams.toStringAsFixed(0)}g | L: ${log.consumedNutrients.fatGrams.toStringAsFixed(0)}g";
                          // Anda bisa menambahkan logika untuk ikon berbeda berdasarkan kategori makanan
                          leadingIconData =
                              Icons.lunch_dining_rounded; // Contoh ikon
                        }

                        return Card(
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor:
                                  theme.primaryColor.withOpacity(0.1),
                              child: Icon(
                                leadingIconData,
                                color: theme.primaryColor,
                                size: 24,
                              ),
                            ),
                            title: Text(
                              title,
                              style: theme.textTheme.titleMedium,
                            ),
                            subtitle: Text(
                              subtitle,
                              style: theme.textTheme.bodySmall,
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.remove_circle_outline_rounded,
                                  color: Colors.red[400]),
                              onPressed: () {
                                setState(() {
                                  final removedLog =
                                      _consumedFoodLogs.removeAt(index);
                                  _totalConsumedNutrients =
                                      _totalConsumedNutrients -
                                          removedLog.consumedNutrients;
                                  _updateFulfillmentStatus();
                                  _recommendation = _getFoodRecommendation();
                                });
                              },
                              tooltip: 'Hapus Item',
                            ),
                          ),
                        );
                      },
                    ),
            ),
            const SizedBox(height: 24.0),

            // --- Recommendation Section ---
            Text(
              'Rekomendasi Gizi Untukmu:',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8.0),
            Container(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.25,
              ),
              child: Card(
                elevation: 4.0,
                color: cardBackgroundColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  side: BorderSide(color: cardBorderColor, width: 1.5),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          recommendationIcon,
                          size: 40,
                          color: cardTextColor,
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          _recommendation,
                          style: GoogleFonts.nunito(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                            color: cardTextColor,
                            height: 1.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            TextButton.icon(
              icon: const Icon(
                Icons.refresh_rounded,
                size: 20,
              ),
              label: const Text('Reset List Makanan'),
              onPressed: _resetConsumption,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _foodInputController.dispose();
    super.dispose();
  }
}

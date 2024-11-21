class RecipeAnalysis {
  final double hydrationPercentage;
  final double saltPercentage;
  final double starterPercentage;
  final double totalFlourWeight;

  double totalFlourContent;

  double totalWaterContent;
  
  RecipeAnalysis({
    required this.hydrationPercentage,
    required this.saltPercentage,
    required this.starterPercentage,
    required this.totalFlourWeight,
    required double totalWaterContent,
    required double totalFlourContent,
  }) : totalWaterContent = totalWaterContent,
       totalFlourContent = totalFlourContent;
}

class Ingredient {
  String name;
  double amount;
  String unit;

  Ingredient({required this.name, this.amount = 0.0, this.unit = 'g'});
}
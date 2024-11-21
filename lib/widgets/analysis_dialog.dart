import 'package:flutter/material.dart';
import '../models/recipe_analysis.dart';
import 'gauge_indicator.dart';

class AnalysisDialog extends StatelessWidget {
  final RecipeAnalysis analysis;
  final List<Ingredient> flours;

  const AnalysisDialog({
    Key? key,
    required this.analysis,
    required this.flours,
  }) : super(key: key);

  double _calculateTotalWeight() {
    // Sum up all ingredients
    double totalFlourWeight = analysis.totalFlourContent;
    double totalWaterContent = analysis.totalWaterContent;
    
    // Calculate total weight before baking
    double totalWeightBeforeBaking = totalFlourWeight + totalWaterContent;
    
    // Calculate expected weight after baking (85% of total)
    return totalWeightBeforeBaking * 0.85;
  }

  @override
  Widget build(BuildContext context) {
    final totalBreadWeight = _calculateTotalWeight();
    
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Stack(
                children: [
                  const Row(
                    children: [
                      Icon(Icons.analytics, size: 28),
                      SizedBox(width: 12),
                      Text(
                        'Recipe Analysis',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              
              // Total Weight Card
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                color: Theme.of(context).primaryColor.withOpacity(0.1),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.scale,
                            color: Theme.of(context).primaryColor,
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Expected Bread Weight',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${totalBreadWeight.toStringAsFixed(1)}g',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              'After 15% water loss',
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Flour Composition
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[200]!),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.bakery_dining),
                        SizedBox(width: 8),
                        Text(
                          'Flour Composition',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    ...flours.map((flour) {
                      double percentage = (flour.amount / analysis.totalFlourWeight) * 100;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              flour.name,
                              style: const TextStyle(fontSize: 16),
                            ),
                            Text(
                              '${flour.amount.toStringAsFixed(1)}g (${percentage.toStringAsFixed(1)}%)',
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                    const Divider(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total Flour',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          '${analysis.totalFlourWeight.toStringAsFixed(1)}g',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Gauges
              GaugeIndicator(
                label: 'Hydration',
                value: analysis.hydrationPercentage,
                min: 50,
                max: 90,
                minRecommended: 65,
                maxRecommended: 75,
              ),
              const SizedBox(height: 16),
              
              GaugeIndicator(
                label: 'Salt',
                value: analysis.saltPercentage,
                min: 0,
                max: 4,
                minRecommended: 1.8,
                maxRecommended: 2.2,
              ),
              const SizedBox(height: 16),
              
              GaugeIndicator(
                label: 'Starter',
                value: analysis.starterPercentage,
                min: 0,
                max: 50,
                minRecommended: 15,
                maxRecommended: 30,
              ),
              
              const SizedBox(height: 24),
              
              // Ingredients Summary
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.amber[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.amber[200]!),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Total Ingredients',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Before Baking:',
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          '${(totalBreadWeight / 0.85).toStringAsFixed(1)}g',
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Expected After Baking:',
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          '${totalBreadWeight.toStringAsFixed(1)}g',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
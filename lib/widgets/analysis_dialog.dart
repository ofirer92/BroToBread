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
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      insetPadding: EdgeInsets.symmetric(
        horizontal: isSmallScreen ? 16 : 24,
        vertical: isSmallScreen ? 24 : 40,
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(isSmallScreen ? 16 : 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Stack(
                children: [
                  Row(
                    children: [
                      Icon(Icons.analytics, size: isSmallScreen ? 24 : 28),
                      SizedBox(width: isSmallScreen ? 10 : 12),
                      Text(
                        'Recipe Analysis',
                        style: TextStyle(
                          fontSize: isSmallScreen ? 20 : 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    right: 0,
                    top: -8,
                    child: IconButton(
                      icon: Icon(Icons.close, size: isSmallScreen ? 20 : 24),
                      onPressed: () => Navigator.of(context).pop(),
                      padding: EdgeInsets.all(isSmallScreen ? 4 : 8),
                      constraints: BoxConstraints(
                        minWidth: isSmallScreen ? 36 : 40,
                        minHeight: isSmallScreen ? 36 : 40,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: isSmallScreen ? 16 : 24),
              
              // Total Weight Card
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                color: Theme.of(context).primaryColor.withOpacity(0.1),
                child: Padding(
                  padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.scale,
                            color: Theme.of(context).primaryColor,
                            size: isSmallScreen ? 20 : 24,
                          ),
                          SizedBox(width: isSmallScreen ? 6 : 8),
                          Flexible(
                            child: Text(
                              'Expected Bread Weight',
                              style: TextStyle(
                                fontSize: isSmallScreen ? 16 : 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: isSmallScreen ? 10 : 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${totalBreadWeight.toStringAsFixed(1)}g',
                            style: TextStyle(
                              fontSize: isSmallScreen ? 20 : 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Flexible(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: isSmallScreen ? 8 : 12,
                                vertical: isSmallScreen ? 4 : 6,
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
                                  fontSize: isSmallScreen ? 11 : 12,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: isSmallScreen ? 16 : 24),
              
              // Flour Composition
              Container(
                padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[200]!),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.bakery_dining, size: isSmallScreen ? 20 : 24),
                        SizedBox(width: isSmallScreen ? 6 : 8),
                        Text(
                          'Flour Composition',
                          style: TextStyle(
                            fontSize: isSmallScreen ? 16 : 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: isSmallScreen ? 12 : 16),
                    ...flours.map((flour) {
                      double percentage = (flour.amount / analysis.totalFlourWeight) * 100;
                      return Padding(
                        padding: EdgeInsets.only(bottom: isSmallScreen ? 6 : 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                flour.name,
                                style: TextStyle(fontSize: isSmallScreen ? 14 : 16),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '${flour.amount.toStringAsFixed(1)}g (${percentage.toStringAsFixed(1)}%)',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: isSmallScreen ? 14 : 16,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                    Divider(height: isSmallScreen ? 20 : 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Flour',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: isSmallScreen ? 15 : 16,
                          ),
                        ),
                        Text(
                          '${analysis.totalFlourWeight.toStringAsFixed(1)}g',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: isSmallScreen ? 15 : 16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: isSmallScreen ? 16 : 24),
              
              // Gauges
              GaugeIndicator(
                label: 'Hydration',
                value: analysis.hydrationPercentage,
                min: 50,
                max: 90,
                minRecommended: 65,
                maxRecommended: 75,
              ),
              SizedBox(height: isSmallScreen ? 12 : 16),

              GaugeIndicator(
                label: 'Salt',
                value: analysis.saltPercentage,
                min: 0,
                max: 4,
                minRecommended: 1.8,
                maxRecommended: 2.2,
              ),
              SizedBox(height: isSmallScreen ? 12 : 16),

              GaugeIndicator(
                label: 'Starter',
                value: analysis.starterPercentage,
                min: 0,
                max: 50,
                minRecommended: 15,
                maxRecommended: 30,
              ),

              SizedBox(height: isSmallScreen ? 16 : 24),

              // Ingredients Summary
              Container(
                padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
                decoration: BoxDecoration(
                  color: Colors.amber[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.amber[200]!),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Ingredients',
                      style: TextStyle(
                        fontSize: isSmallScreen ? 16 : 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: isSmallScreen ? 10 : 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Before Baking:',
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: isSmallScreen ? 14 : 16,
                          ),
                        ),
                        Text(
                          '${(totalBreadWeight / 0.85).toStringAsFixed(1)}g',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: isSmallScreen ? 14 : 16,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: isSmallScreen ? 6 : 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            'Expected After Baking:',
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: isSmallScreen ? 14 : 16,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${totalBreadWeight.toStringAsFixed(1)}g',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: isSmallScreen ? 14 : 16,
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
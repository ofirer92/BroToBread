import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/analysis_dialog.dart';
import '../models/recipe_analysis.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final List<Ingredient> flours = [Ingredient(name: 'קמח לחם')];
  final waterController = TextEditingController();
  final saltController = TextEditingController();
  final starterController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    waterController.dispose();
    saltController.dispose();
    starterController.dispose();
    super.dispose();
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: const Text('מחשבון לחם'),
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: () => Navigator.of(context).pop(),
      ),
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).primaryColor,
              Theme.of(context).primaryColor.withRed(100),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
    );
  }

  Widget _buildFlourCard(int index, BuildContext context) {
    final flour = flours[index];
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;

    return Card(
      margin: EdgeInsets.symmetric(vertical: isSmallScreen ? 6 : 8),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'קמח ${index + 1}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: isSmallScreen ? 15 : 16,
                  ),
                ),
                if (flours.length > 1)
                  const Spacer(),
                if (flours.length > 1)
                  IconButton(
                    icon: const Icon(Icons.delete_outline),
                    color: Colors.red[400],
                    onPressed: () => _removeFlour(index),
                    tooltip: 'הסר קמח',
                    padding: EdgeInsets.all(isSmallScreen ? 8 : 12),
                    constraints: BoxConstraints(
                      minWidth: isSmallScreen ? 40 : 48,
                      minHeight: isSmallScreen ? 40 : 48,
                    ),
                  ),
              ],
            ),
            SizedBox(height: isSmallScreen ? 10 : 12),
            TextField(
              textDirection: TextDirection.rtl,
              decoration: InputDecoration(
                labelText: 'סוג הקמח',
                hintText: 'לדוגמה: קמח לחם',
                prefixIcon: Icon(
                  Icons.agriculture,
                  color: Theme.of(context).primaryColor,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: isSmallScreen ? 12 : 16,
                  vertical: isSmallScreen ? 12 : 16,
                ),
              ),
              onChanged: (value) => flour.name = value,
            ),
            SizedBox(height: isSmallScreen ? 10 : 12),
            TextField(
              textDirection: TextDirection.ltr,
              textAlign: TextAlign.right,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: 'כמות',
                hintText: '0.0',
                suffixText: 'גרם',
                prefixIcon: Icon(
                  Icons.scale,
                  color: Theme.of(context).primaryColor,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: isSmallScreen ? 12 : 16,
                  vertical: isSmallScreen ? 12 : 16,
                ),
              ),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
              ],
              onChanged: (value) => flour.amount = double.tryParse(value) ?? 0.0,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIngredientInput(
    BuildContext context,
    String label,
    TextEditingController controller,
    IconData icon,
    {String? helperText}
  ) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: isSmallScreen ? 6 : 8),
      child: TextField(
        controller: controller,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.right,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        decoration: InputDecoration(
          labelText: label,
          helperText: helperText,
          helperMaxLines: 2,
          helperStyle: TextStyle(fontSize: isSmallScreen ? 11 : 12),
          suffixText: 'גרם',
          prefixIcon: Icon(icon, color: Theme.of(context).primaryColor),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: isSmallScreen ? 12 : 16,
            vertical: isSmallScreen ? 12 : 16,
          ),
        ),
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
        ],
      ),
    );
  }

  void _addFlour() {
    setState(() {
      flours.add(Ingredient(name: ''));
    });
  }

  void _removeFlour(int index) {
    if (flours.length > 1) {
      setState(() {
        flours.removeAt(index);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('חייב להיות לפחות סוג קמח אחד'),
          backgroundColor: Colors.orange,
        ),
      );
    }
  }

  void _calculate() {
    double totalFlour = flours.fold(0, (sum, flour) => sum + flour.amount);
    
    if (totalFlour == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('נא להזין כמויות קמח תחילה'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    
    double waterAmount = double.tryParse(waterController.text) ?? 0;
    double saltAmount = double.tryParse(saltController.text) ?? 0;
    double starterAmount = double.tryParse(starterController.text) ?? 0;
    
    double waterContent = waterAmount + (starterAmount / 2);
    double flourContent = totalFlour + (starterAmount / 2);
    
    double hydrationPercentage = flourContent > 0 ? (waterContent / flourContent) * 100 : 0;
    
    RecipeAnalysis analysis = RecipeAnalysis(
      hydrationPercentage: hydrationPercentage,
      saltPercentage: (saltAmount / flourContent) * 100,
      starterPercentage: (starterAmount / totalFlour) * 100,
      totalFlourWeight: totalFlour,
      totalWaterContent: waterContent,
      totalFlourContent: flourContent,
    );
    
    showDialog(
      context: context,
      builder: (context) => AnalysisDialog(
        analysis: analysis,
        flours: flours,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;

    return Scaffold(
      key: _scaffoldKey,
      appBar: _buildAppBar(),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // Flours Section
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'קמחים',
                              style: TextStyle(
                                fontSize: isSmallScreen ? 18 : 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            ElevatedButton.icon(
                              onPressed: _addFlour,
                              icon: const Icon(Icons.add, size: 20),
                              label: Text(
                                'הוסף קמח',
                                style: TextStyle(fontSize: isSmallScreen ? 13 : 14),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context).primaryColor,
                                foregroundColor: Colors.white,
                                padding: EdgeInsets.symmetric(
                                  horizontal: isSmallScreen ? 12 : 16,
                                  vertical: isSmallScreen ? 8 : 12,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: isSmallScreen ? 12 : 16),
                        ...flours.asMap().entries.map((entry) =>
                          _buildFlourCard(entry.key, context)
                        ).toList(),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: isSmallScreen ? 16 : 24),

                // Other Ingredients Section
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'מרכיבים נוספים',
                          style: TextStyle(
                            fontSize: isSmallScreen ? 18 : 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: isSmallScreen ? 12 : 16),
                        _buildIngredientInput(
                          context,
                          'מים',
                          waterController,
                          Icons.water_drop,
                          helperText: 'סך ההידרציה כולל מים + חצי ממשקל המחמצת',
                        ),
                        _buildIngredientInput(
                          context,
                          'מלח',
                          saltController,
                          Icons.grain,
                          helperText: 'מומלץ: 1.8-2.2% ממשקל הקמח הכולל',
                        ),
                        _buildIngredientInput(
                          context,
                          'מחמצת',
                          starterController,
                          Icons.bakery_dining,
                          helperText: 'נחשב כ-50% מים ו-50% קמח בחישוב ההידרציה',
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: isSmallScreen ? 16 : 24),

                // Calculate Button
                SizedBox(
                  width: double.infinity,
                  height: isSmallScreen ? 50 : 56,
                  child: ElevatedButton.icon(
                    onPressed: _calculate,
                    icon: Icon(Icons.calculate, size: isSmallScreen ? 20 : 24),
                    label: Text(
                      'חשב מתכון',
                      style: TextStyle(
                        fontSize: isSmallScreen ? 16 : 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                    ),
                  ),
                ),

                SizedBox(height: isSmallScreen ? 16 : 24),

                // Information Note
                Container(
                  padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
                  decoration: BoxDecoration(
                    color: Colors.amber.shade50,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.amber.shade200,
                    ),
                  ),
                  child: Text(
                    'הערה: המחשבון מניח שהמחמצת היא בהידרציה של 100% '
                    '(כמות שווה של קמח ומים). חישוב ההידרציה '
                    'כולל את המים והקמח מהמחמצת.',
                    style: TextStyle(
                      color: Colors.brown[700],
                      fontSize: isSmallScreen ? 13 : 14,
                    ),
                    textAlign: TextAlign.right,
                    textDirection: TextDirection.rtl,
                  ),
                ),

                SizedBox(height: isSmallScreen ? 16 : 24),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
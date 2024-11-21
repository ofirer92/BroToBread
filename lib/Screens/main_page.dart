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

  Widget _buildFlourCard(int index) {
    final flour = flours[index];
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'קמח ${index + 1}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
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
                  ),
              ],
            ),
            const SizedBox(height: 12),
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
              ),
              onChanged: (value) => flour.name = value,
            ),
            const SizedBox(height: 12),
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
    String label,
    TextEditingController controller,
    IconData icon,
    {String? helperText}
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controller,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.right,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        decoration: InputDecoration(
          labelText: label,
          helperText: helperText,
          helperMaxLines: 2,
          suffixText: 'גרם',
          prefixIcon: Icon(icon, color: Theme.of(context).primaryColor),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
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
    return Scaffold(
      key: _scaffoldKey,
      appBar: _buildAppBar(),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // Flours Section
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'קמחים',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            ElevatedButton.icon(
                              onPressed: _addFlour,
                              icon: const Icon(Icons.add),
                              label: const Text('הוסף קמח'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context).primaryColor,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        ...flours.asMap().entries.map((entry) => 
                          _buildFlourCard(entry.key)
                        ).toList(),
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Other Ingredients Section
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'מרכיבים נוספים',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        _buildIngredientInput(
                          'מים',
                          waterController,
                          Icons.water_drop,
                          helperText: 'סך ההידרציה כולל מים + חצי ממשקל המחמצת',
                        ),
                        _buildIngredientInput(
                          'מלח',
                          saltController,
                          Icons.grain,
                          helperText: 'מומלץ: 1.8-2.2% ממשקל הקמח הכולל',
                        ),
                        _buildIngredientInput(
                          'מחמצת',
                          starterController,
                          Icons.bakery_dining,
                          helperText: 'נחשב כ-50% מים ו-50% קמח בחישוב ההידרציה',
                        ),
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Calculate Button
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton.icon(
                    onPressed: _calculate,
                    icon: const Icon(Icons.calculate),
                    label: const Text(
                      'חשב מתכון',
                      style: TextStyle(
                        fontSize: 18,
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

                const SizedBox(height: 24),

                // Information Note
                Container(
                  padding: const EdgeInsets.all(16),
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
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.right,
                    textDirection: TextDirection.rtl,
                  ),
                ),
                
                const SizedBox(height: 24),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'timer_page.dart';

class TimerSelectionPage extends StatelessWidget {
  const TimerSelectionPage({Key? key}) : super(key: key);

  Widget _buildTimerOption(
    BuildContext context, {
    required String title,
    required String description,
    required IconData icon,
    required List<String> features,
    String? tip,
    required VoidCallback onTap,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;

    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(
        horizontal: isSmallScreen ? 12 : 16,
        vertical: isSmallScreen ? 6 : 8,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: EdgeInsets.all(isSmallScreen ? 16 : 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header with Icon and Title
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(isSmallScreen ? 10 : 12),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      icon,
                      size: isSmallScreen ? 28 : 32,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  SizedBox(width: isSmallScreen ? 12 : 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: isSmallScreen ? 19 : 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: isSmallScreen ? 3 : 4),
                        Text(
                          description,
                          style: TextStyle(
                            fontSize: isSmallScreen ? 13 : 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: isSmallScreen ? 16 : 20),
              
              // Features List
              ...features.map((feature) => Padding(
                padding: EdgeInsets.only(bottom: isSmallScreen ? 10 : 12),
                child: Row(
                  children: [
                    Icon(
                      Icons.check_circle_outline,
                      size: isSmallScreen ? 18 : 20,
                      color: Theme.of(context).primaryColor,
                    ),
                    SizedBox(width: isSmallScreen ? 10 : 12),
                    Expanded(
                      child: Text(
                        feature,
                        style: TextStyle(
                          fontSize: isSmallScreen ? 14 : 16,
                        ),
                      ),
                    ),
                  ],
                ),
              )).toList(),

              // Tip Section (if provided)
              if (tip != null) ...[
                SizedBox(height: isSmallScreen ? 12 : 16),
                Container(
                  padding: EdgeInsets.all(isSmallScreen ? 10 : 12),
                  decoration: BoxDecoration(
                    color: Colors.amber.shade50,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.amber.shade200),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.lightbulb_outline,
                        color: Theme.of(context).primaryColor,
                        size: isSmallScreen ? 18 : 20,
                      ),
                      SizedBox(width: isSmallScreen ? 10 : 12),
                      Expanded(
                        child: Text(
                          tip,
                          style: TextStyle(
                            fontSize: isSmallScreen ? 13 : 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],

              SizedBox(height: isSmallScreen ? 12 : 16),

              // Action Button
              ElevatedButton(
                onPressed: onTap,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    vertical: isSmallScreen ? 10 : 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'בחר',
                  style: TextStyle(
                    fontSize: isSmallScreen ? 15 : 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('בחר סוג טיימר'),
        centerTitle: true,
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
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 24),
            children: [
              _buildTimerOption(
                context,
                title: 'הכנת הלחם',
                description: 'טיימרים לכל שלבי ההכנה',
                icon: Icons.bakery_dining,
                features: [
                  'אוטוליזה - ערבוב קמח ומים',
                  'ערבוב - הוספת מלח ומחמצת',
                  'תסיסה ראשונית עם תזכורות לקיפולים',
                  'התראות על זמני קיפול הבצק',
                ],
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TimerPage(timerType: TimerType.making),
                  ),
                ),
              ),
              _buildTimerOption(
                context,
                title: 'אפיית הלחם',
                description: 'טיימרים לשלבי האפייה',
                icon: Icons.local_fire_department,
                features: [
                  'אפייה עם מכסה - 20 דקות',
                  'אפייה ללא מכסה - 20 דקות',
                ],
                tip: 'טיפ: חמם את הסיר והמכסה מראש בתנור למשך 30 דקות לפני תחילת האפייה',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TimerPage(timerType: TimerType.baking),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
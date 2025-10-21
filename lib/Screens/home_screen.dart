import 'package:flutter/material.dart';
import 'main_page.dart';
import 'timer_selection_page.dart';
import '../l10n/app_localizations.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  Widget _buildNavigationCard(
    BuildContext context, {
    required String titleKey,
    required String descriptionKey,
    required IconData icon,
    required Color iconBackgroundColor,
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
        child: Container(
          padding: EdgeInsets.all(isSmallScreen ? 16 : 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
                decoration: BoxDecoration(
                  color: iconBackgroundColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: isSmallScreen ? 40 : 48,
                  color: iconBackgroundColor,
                ),
              ),
              SizedBox(height: isSmallScreen ? 12 : 16),
              Text(
                AppLocalizations.of(context).get(titleKey),
                style: TextStyle(
                  fontSize: isSmallScreen ? 20 : 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: isSmallScreen ? 6 : 8),
              Text(
                AppLocalizations.of(context).get(descriptionKey),
                style: TextStyle(
                  fontSize: isSmallScreen ? 14 : 16,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360 || screenHeight < 600;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Theme.of(context).primaryColor,
              Theme.of(context).colorScheme.secondary,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: isSmallScreen ? 24 : 48),

              // App Logo and Title
              Container(
                padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.bakery_dining,
                  size: isSmallScreen ? 56 : 72,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: isSmallScreen ? 16 : 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  AppLocalizations.of(context).get('appName'),
                  style: TextStyle(
                    fontSize: isSmallScreen ? 24 : 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  AppLocalizations.of(context).get('assistant'),
                  style: TextStyle(
                    fontSize: isSmallScreen ? 18 : 24,
                    color: const Color(0xFFFEF3C7),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: isSmallScreen ? 24 : 48),
              
              // Main Content Area
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFFEF3C7),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(isSmallScreen ? 24 : 32),
                      topRight: Radius.circular(isSmallScreen ? 24 : 32),
                    ),
                  ),
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(vertical: isSmallScreen ? 20 : 32),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            AppLocalizations.of(context).get('chooseYourTool'),
                            style: TextStyle(
                              fontSize: isSmallScreen ? 20 : 24,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(height: isSmallScreen ? 16 : 24),
                        
                        // Recipe Calculator Card
                        _buildNavigationCard(
                          context,
                          titleKey: 'recipeCalculator',
                          descriptionKey: 'recipeCalculatorDesc',
                          icon: Icons.calculate_outlined,
                          iconBackgroundColor: Theme.of(context).primaryColor,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const MainPage()),
                          ),
                        ),
                        
                        // Timers Card
                        _buildNavigationCard(
                          context,
                          titleKey: 'breadTimers',
                          descriptionKey: 'breadTimersDesc',
                          icon: Icons.timer_outlined,
                          iconBackgroundColor: Theme.of(context).primaryColor,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const TimerSelectionPage()),
                          ),
                        ),
                        
                        // Version Info
                        const SizedBox(height: 24),
                        Text(
                          'גרסה 1.0.0',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
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
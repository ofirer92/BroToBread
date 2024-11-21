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
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: iconBackgroundColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: 48,
                  color: iconBackgroundColor,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                AppLocalizations.of(context).get(titleKey),
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                AppLocalizations.of(context).get(descriptionKey),
                style: TextStyle(
                  fontSize: 16,
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
              const SizedBox(height: 48),
              
              // App Logo and Title
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.bakery_dining,
                  size: 72,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                AppLocalizations.of(context).get('appName'),
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                AppLocalizations.of(context).get('assistant'),
                style: const TextStyle(
                  fontSize: 24,
                  color: Color(0xFFFEF3C7),
                ),
              ),
              const SizedBox(height: 48),
              
              // Main Content Area
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFFFEF3C7),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32),
                    ),
                  ),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(vertical: 32),
                    child: Column(
                      children: [
                        Text(
                          AppLocalizations.of(context).get('chooseYourTool'),
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 24),
                        
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
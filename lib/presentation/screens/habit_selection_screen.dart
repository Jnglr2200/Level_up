import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../data/database/local_database.dart';
import '../../data/services/player_data_service.dart';
import 'main_navigator.dart';

class HabitCategory {
  final String name;
  final IconData icon;
  const HabitCategory({required this.name, required this.icon});
}

class HabitSelectionScreen extends StatefulWidget {
  final Player player;
  const HabitSelectionScreen({super.key, required this.player});

  @override
  State<HabitSelectionScreen> createState() => _HabitSelectionScreenState();
}

class _HabitSelectionScreenState extends State<HabitSelectionScreen> {
  final List<HabitCategory> _categories = const [
    HabitCategory(name: 'Ejercicio', icon: Icons.fitness_center),
    HabitCategory(name: 'Alimentación', icon: Icons.restaurant),
    HabitCategory(name: 'Descanso', icon: Icons.bedtime),
    HabitCategory(name: 'Salud Mental', icon: Icons.self_improvement),
    HabitCategory(name: 'Productividad', icon: Icons.work),
  ];
  final Set<String> _selectedCategories = {};

  void _toggleCategory(String categoryName) {
    setState(() {
      if (_selectedCategories.contains(categoryName)) {
        _selectedCategories.remove(categoryName);
      } else {
        _selectedCategories.add(categoryName);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ... (Los textos de la parte superior no cambian) ...
              const SizedBox(height: 48),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  childAspectRatio: 1,
                  children: _categories.map((category) {
                    final isSelected = _selectedCategories.contains(category.name);
                    return _buildCategoryButton(category, isSelected);
                  }).toList(),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _selectedCategories.isEmpty
                    ? null
                    : () async {
                  await PlayerDataService.instance.saveSelectedHabits(                    playerId: widget.player.id,
                    habits: _selectedCategories,
                  );

                  if (mounted) {
                    // --- LÍNEA CORREGIDA ---
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => MainNavigator(player: widget.player)),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  disabledBackgroundColor: Colors.grey.withOpacity(0.5),
                ),
                child: Text('Continuar', style: GoogleFonts.orbitron(fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryButton(HabitCategory category, bool isSelected) {
    return GestureDetector(
      onTap: () => _toggleCategory(category.name),
      child: Container(
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).colorScheme.secondary.withOpacity(0.3)
              : Colors.blue.shade900.withOpacity(0.8),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? Theme.of(context).colorScheme.secondary
                : Colors.blue.shade700,
            width: 3,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(category.icon, size: 48, color: Colors.white),
            const SizedBox(height: 16),
            Text(
              category.name,
              style: GoogleFonts.orbitron(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
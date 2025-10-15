import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../data/services/player_data_service.dart';
import 'main_navigator.dart';

// Un pequeño modelo para organizar mejor nuestras categorías
class HabitCategory {
  final String name;
  final IconData icon;

  const HabitCategory({required this.name, required this.icon});
}

class HabitSelectionScreen extends StatefulWidget {
  const HabitSelectionScreen({super.key});

  @override
  State<HabitSelectionScreen> createState() => _HabitSelectionScreenState();
}

class _HabitSelectionScreenState extends State<HabitSelectionScreen> {
  // Lista de todas las categorías disponibles
  final List<HabitCategory> _categories = const [
    HabitCategory(name: 'Ejercicio', icon: Icons.fitness_center),
    HabitCategory(name: 'Alimentación', icon: Icons.restaurant),
    HabitCategory(name: 'Descanso', icon: Icons.bedtime),
    HabitCategory(name: 'Salud Mental', icon: Icons.self_improvement),
    HabitCategory(name: 'Productividad', icon: Icons.work),
  ];

  // Usamos un Set para guardar las categorías seleccionadas
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
              Text(
                '¿Qué quieres mejorar?',
                textAlign: TextAlign.center,
                style: GoogleFonts.orbitron(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Selecciona una o más áreas para enfocar tus misiones diarias.',
                textAlign: TextAlign.center,
                style: GoogleFonts.orbitron(
                  fontSize: 16,
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 48),

              // --- SECCIÓN CORREGIDA ---
              // Ahora solo tenemos un Expanded, que contiene el GridView
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2, // Dos columnas
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  childAspectRatio: 1, // Botones cuadrados
                  children: _categories.map((category) {
                    final isSelected = _selectedCategories.contains(category.name);
                    return _buildCategoryButton(category, isSelected);
                  }).toList(),
                ),
              ),
              // --- FIN DE LA SECCIÓN CORREGIDA ---

              const SizedBox(height: 24), // Espacio antes del botón

              // Botón para continuar
              ElevatedButton(
                onPressed: _selectedCategories.isEmpty
                    ? null
                    : () async {
                  await PlayerDataService().saveSelectedHabits(_selectedCategories);
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const MainNavigator()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  disabledBackgroundColor: Colors.grey.withOpacity(0.5),
                ),
                child: Text(
                  'Continuar',
                  style: GoogleFonts.orbitron(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget helper para construir cada botón de categoría (no cambia)
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
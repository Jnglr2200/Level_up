import 'package:flutter/material.dart';
import 'misiones_screen.dart';
import 'progreso_screen.dart';
import 'perfil_screen.dart';

class MainNavigator extends StatefulWidget {
  const MainNavigator({super.key});

  @override
  State<MainNavigator> createState() => _MainNavigatorState();
}

class _MainNavigatorState extends State<MainNavigator> {
  int _selectedIndex = 0;

  static const List<Widget> _screens = <Widget>[
    MisionesScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Función para crear un ícono con el estilo "estrella"
  Widget _buildStarIcon(IconData icon, bool isSelected) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Icon(
          Icons.star, // O un ícono de forma similar a una estrella/polígono
          color: isSelected ? Colors.cyan.shade400 : Colors.blue.shade700, // Color de la estrella
          size: isSelected ? 38 : 34, // Tamaño de la estrella
        ),
        Icon(
          icon, // El ícono real dentro de la estrella
          color: isSelected ? Colors.blue.shade900 : Colors.white, // Color del ícono interior
          size: isSelected ? 20 : 18, // Tamaño del ícono interior
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens.elementAt(_selectedIndex),

      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onItemTapped,
        // Los estilos del NavigationBar ahora vienen del main.dart Theme,
        // pero podemos sobrescribirlos o ajustarlos aquí si es necesario.
        destinations: <NavigationDestination>[
          NavigationDestination(
            icon: _buildStarIcon(Icons.fitness_center, _selectedIndex == 0),
            label: 'Misiones',
          ),
          NavigationDestination(
            icon: _buildStarIcon(Icons.bar_chart, _selectedIndex == 1),
            label: 'Progreso',
          ),
          NavigationDestination(
            icon: _buildStarIcon(Icons.person, _selectedIndex == 2),
            label: 'Avatar',
          ),
          NavigationDestination(
            icon: _buildStarIcon(Icons.settings, _selectedIndex == 3), // Cambié a settings por ejemplo
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}
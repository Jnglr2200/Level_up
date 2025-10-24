import 'package:flutter/material.dart';
import '../../data/database/local_database.dart';
import 'misiones_screen.dart';
import 'progreso_screen.dart';
//import 'avatar_screen.dart';

class MainNavigator extends StatefulWidget {
  final Player player;
  const MainNavigator({super.key, required this.player});

  @override
  State<MainNavigator> createState() => _MainNavigatorState();
}

class _MainNavigatorState extends State<MainNavigator> {
  int _selectedIndex = 0;

  // Esta lista contiene las tres pantallas principales
  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      MisionesScreen(player: widget.player),
      ProgresoScreen(player: widget.player), // <-- Pantalla de Progreso en el índice 1
      //const AvatarScreen(), // (Esta la construiremos después)
    ];
  }

  // Esta función se llama cuando tocas un ícono de la barra
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
// En lib/presentation/screens/main_navigator.dart

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // --- CAMBIO CLAVE ---
      // Reemplaza "body: _screens[_selectedIndex]" con esto:
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      // ---------------------

      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: 'Misiones'),
          BottomNavigationBarItem(icon: Icon(Icons.show_chart), label: 'Progreso'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Avatar'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: Colors.blue.shade900.withOpacity(0.8),
        selectedItemColor: Colors.cyanAccent,
        unselectedItemColor: Colors.white70,
      ),
    );
  }}
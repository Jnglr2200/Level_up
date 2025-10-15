import 'package:flutter/material.dart';
import '../../data/database/local_database.dart'; // Importa el modelo Player
import 'misiones_screen.dart';
import 'progreso_screen.dart';

class MainNavigator extends StatefulWidget {
  // Ahora requiere que le pases el jugador que ha iniciado sesión
  final Player player;

  const MainNavigator({super.key, required this.player});

  @override
  State<MainNavigator> createState() => _MainNavigatorState();
}

class _MainNavigatorState extends State<MainNavigator> {
  int _selectedIndex = 0;

  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    // Pasa el jugador a las pantallas que lo necesiten
    _screens = [
      MisionesScreen(player: widget.player), // Le pasamos el jugador

    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: 'Misiones'),
          BottomNavigationBarItem(icon: Icon(Icons.show_chart), label: 'Progreso'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Avatar'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
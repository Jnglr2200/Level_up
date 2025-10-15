import 'package:flutter/material.dart';
import '../../data/database/local_database.dart'; // Importa el modelo Player
import '../../data/services/player_data_service.dart';
// ... (otros imports que necesites como google_fonts)

class MisionesScreen extends StatefulWidget {
  final Player player;

  const MisionesScreen({super.key, required this.player});

  @override
  State<MisionesScreen> createState() => _MisionesScreenState();
}

class _MisionesScreenState extends State<MisionesScreen> {
  // ... (tus variables de misiones, animación, etc. no cambian)

  // Variables de estado del jugador
  late int _level;
  late int _currentExp;
  late int _streakCount;
  late String _userName;
  final int _maxExp = 100;

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    // Usamos los datos iniciales del jugador que nos pasaron
    setState(() {
      _userName = widget.player.name;
      _level = widget.player.level;
      _currentExp = widget.player.xp;
      _streakCount = widget.player.streak;
      _isLoading = false;
    });
  }

  void _completeMission(int index) {
    // ... (Tu lógica de animación y SnackBar no cambia)

    // Actualiza el estado local
    setState(() {
      _currentExp += 25;
      if (_currentExp >= _maxExp) {
        _level++;
        _currentExp -= _maxExp;
      }
    });

    // ... (Tu lógica de removeItem y SnackBar)

    // Llama a la nueva función de guardado con el ID del jugador
    PlayerDataService().savePlayerProgress(
      playerId: widget.player.id,
      level: _level,
      xp: _currentExp,
      streak: _streakCount,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      // Si está cargando, muestra un indicador de progreso
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    } else {
      // Si ya terminó de cargar, construye y devuelve la pantalla principal
      return Scaffold(
        appBar: AppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Bienvenido,', style: TextStyle(fontSize: 14)),
              Text(_userName, style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          actions: [
            // Puedes añadir aquí otros widgets como el contador de racha
          ],
        ),
        body: Column(
          children: [
            // Barra de XP (un ejemplo simple)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text('Nivel $_level', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: _currentExp / _maxExp,
                    minHeight: 10,
                  ),
                  Text('$_currentExp / $_maxExp XP'),
                ],
              ),
            ),

            // Placeholder para tu lista de misiones
            Expanded(
              child: Center(
                child: Text(
                  'Aquí va tu lista de misiones.',
                  // Reemplaza esto con tu ListView.builder de misiones
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../data/models/exercise_model.dart';
import '../../data/recommended_missions.dart';
import '../../data/services/player_data_service.dart';

import 'dart:async'; // <-- 1. IMPORTANTE: Importa la librería para el Timer


class MisionesScreen extends StatefulWidget {
  const MisionesScreen({super.key});

  @override
  State<MisionesScreen> createState() => _MisionesScreenState();
}

class _MisionesScreenState extends State<MisionesScreen> {
  // --- ESTADO Y LÓGICA ---
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  late List<Exercise> _missions;
  int _currentExp = 0;
  final int _maxExp = 100;
  int _level = 1;
  String _userName = 'Jugador'; // Ahora es una variable normal
  int _streakCount = 0; // <-- Quita la palabra 'final'
  Timer? _countdownTimer;
  int _remainingSeconds = 15;
  bool _allMissionsCompleted = false;
  bool _timeUpFailure = false;
  bool _isLoading = true;


  @override
  void initState() {
    super.initState();
    _missions = List.from(recommendedMissions);
    _loadPlayerData();
    _startTimer();
  }
  Future<void> _loadPlayerData() async {
    final data = await PlayerDataService().loadData();
    setState(() {
      _userName = data['name']!; // <-- AÑADE ESTA LÍNEA
      _level = data['level']!;
      _currentExp = data['xp']!;
      _streakCount = data['streak']!;
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        if (mounted) setState(() => _remainingSeconds--);
      } else {
        // El tiempo se acabó
        timer.cancel();
        // Solo si el widget todavía existe Y no se han completado todas las misiones
        if (mounted && !_allMissionsCompleted) {
          _clearAllMissions(); // Llama a la nueva función para limpiar la lista
        }
      }
    });
  }
  void _clearAllMissions() {
    // Marca que el usuario ha fallado
    setState(() {
      _timeUpFailure = true;
    });

    // Itera sobre la lista de misiones para eliminarlas una por una con un retraso
    for (int i = 0; i < _missions.length; i++) {
      // Usamos un Future.delayed para crear un efecto de cascada
      Future.delayed(Duration(milliseconds: i * 200), () {
        if (_listKey.currentState != null) {
          final missionToRemove = _missions.first; // Siempre la primera de la lista restante
          _listKey.currentState!.removeItem(
            0, // Siempre se elimina el índice 0 porque la lista se va acortando
                (context, animation) => SizeTransition(
              sizeFactor: animation,
              child: _buildMissionItem(context, missionToRemove, 0, isRemoving: true),
            ),
            duration: const Duration(milliseconds: 300),
          );
          _missions.remove(missionToRemove); // La eliminamos de los datos
        }
      });
    }
  }
  String _formatDuration(int totalSeconds) {
    final duration = Duration(seconds: totalSeconds);
    final hours = duration.inHours.toString().padLeft(2, '0');
    final minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
    final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return '$hours:$minutes:$seconds';
  }

  void _completeMission(int index) {
    final Exercise completedMission = _missions[index];

    // Actualiza XP y Nivel
    setState(() {
      _currentExp += 25;
      if (_currentExp >= _maxExp) {
        _level++;
        _currentExp -= _maxExp;
      }
    });

    // Dispara animación
    _listKey.currentState?.removeItem(
      index,
          (context, animation) => SizeTransition(
        sizeFactor: animation,
        child: _buildMissionItem(context, completedMission, index, isRemoving: true),
      ),
      duration: const Duration(milliseconds: 500),
    );

    // Elimina de la lista de datos
    _missions.remove(completedMission);

    // Muestra mensaje
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('¡Misión "${completedMission.name}" completada!', style: GoogleFonts.orbitron(fontSize: 10, color: Colors.black)),
        backgroundColor: Colors.cyan.shade400,
      ),
    );

    // Revisa si era la última misión
    if (_missions.isEmpty) {
      setState(() {
        _allMissionsCompleted = true;
        _countdownTimer?.cancel();
      });
    }
    // Dentro de _completeMission
    PlayerDataService().saveData(
      name: _userName, // <-- AÑADE ESTO
      level: _level,
      xp: _currentExp,
      streak: _streakCount,
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isAlertMode = _remainingSeconds == 0 && !_allMissionsCompleted;
    final alertColor = Colors.red.shade700;
    final normalColor = Colors.cyan.shade400;
    if (_isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu, color: Colors.white),
              onPressed: () {},
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        title: const Text(''),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(_userName, style: GoogleFonts.orbitron(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                    Text('LVL $_level', style: GoogleFonts.orbitron(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: _currentExp / _maxExp,
                  backgroundColor: Colors.blue.shade700,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.cyan.shade400),
                  minHeight: 10,
                  borderRadius: BorderRadius.circular(5),
                ),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerRight,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('XP: $_currentExp / $_maxExp', style: GoogleFonts.orbitron(color: Colors.white70, fontSize: 12)),
                      const SizedBox(width: 16),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Icon(Icons.local_fire_department, color: Colors.orange.shade700, size: 36),
                          Text('$_streakCount', style: GoogleFonts.orbitron(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.blue.shade900.withOpacity(0.8),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: isAlertMode ? alertColor : normalColor, width: 3),
                boxShadow: [BoxShadow(color: (isAlertMode ? alertColor : normalColor).withOpacity(0.4), blurRadius: 10, spreadRadius: 2)],
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text('MISION DIARIA', style: GoogleFonts.orbitron(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold, shadows: [Shadow(color: normalColor, blurRadius: 10)])),
                  ),
                  const Divider(color: Colors.blueGrey, height: 2, thickness: 1),
                  Expanded(
                    child: _allMissionsCompleted
                        ? _buildSuccessMessage()
                        : (_timeUpFailure
                        ? _buildFailureMessage() // <-- Muestra el mensaje de fallo si el tiempo se acabó
                        : AnimatedList(
                      key: _listKey,
                      initialItemCount: _missions.length,
                      itemBuilder: (context, index, animation) {
                        return SizeTransition(
                          sizeFactor: animation,
                          child: _buildMissionItem(context, _missions[index], index),
                        );
                      },
                      padding: const EdgeInsets.only(bottom: 8),
                    )
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(color: Colors.blue.shade800, borderRadius: const BorderRadius.vertical(bottom: Radius.circular(10))),
                    child: Column(
                      children: [
                        _buildTimerStatus(_allMissionsCompleted, isAlertMode),
                        const SizedBox(height: 8),
                        Text('RECOMPENSA: MAYOR RESISTENCIA, DISCIPLINA Y MASA MUSCULAR', style: GoogleFonts.orbitron(color: Colors.white, fontSize: 10), textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildSuccessMessage() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.check_circle, color: Colors.greenAccent, size: 80),
          const SizedBox(height: 16),
          Text(
            '¡MISIONES COMPLETADAS!',
            style: GoogleFonts.orbitron(
                fontSize: 20,
                color: Colors.greenAccent,
                shadows: const [Shadow(color: Colors.greenAccent, blurRadius: 10)]
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimerStatus(bool allMissionsDone, bool isAlertMode) {
    if (allMissionsDone) {
      return Text(
        '¡Has completado el día!',
        style: GoogleFonts.orbitron(color: Colors.greenAccent, fontSize: 14),
      );
    } else if (isAlertMode) {
      return Text(
        '¡TIEMPO AGOTADO!',
        style: GoogleFonts.orbitron(color: Colors.red.shade700, fontSize: 14, fontWeight: FontWeight.bold),
      );
    } else {
      final String timeRemainingFormatted = _formatDuration(_remainingSeconds);
      return Text(
        'TIEMPO RESTANTE: $timeRemainingFormatted',
        style: GoogleFonts.orbitron(color: Colors.white70, fontSize: 12),
      );
    }
  }
// Añade este widget junto a _buildSuccessMessage y _buildTimerStatus

  Widget _buildFailureMessage() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.warning, color: Colors.red.shade700, size: 80),
          const SizedBox(height: 16),
          Text(
            'HAS FALLADO LA MISIÓN',
            style: GoogleFonts.orbitron(
              fontSize: 20,
              color: Colors.red.shade700,
              shadows: [Shadow(color: Colors.red.shade700, blurRadius: 10)],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
  Widget _buildMissionItem(BuildContext context, Exercise exercise, int index, {bool isRemoving = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: Row(
        children: [
          SizedBox(
            width: 24,
            height: 24,
            child: Checkbox(
              value: false,
              onChanged: isRemoving ? null : (bool? value) {
                if (value == true) {
                  _completeMission(index);
                }
              },
              activeColor: Colors.cyan.shade400,
              checkColor: Colors.black,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4), side: BorderSide(color: Colors.blue.shade200, width: 2)),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              '${exercise.instructions.split('. ')[0]}.',
              style: GoogleFonts.orbitron(color: Colors.white, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
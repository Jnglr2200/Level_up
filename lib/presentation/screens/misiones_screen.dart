import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// --- Imports de Datos ---
import '../../data/database/local_database.dart';
import '../../data/models/mission_model.dart';
import '../../data/services/player_data_service.dart';
import '../../data/services/mission_generator_service.dart';

class MisionesScreen extends StatefulWidget {
  final Player player;
  const MisionesScreen({super.key, required this.player});

  @override
  State<MisionesScreen> createState() => _MisionesScreenState();
}

class _MisionesScreenState extends State<MisionesScreen> {
  // --- Estado del Jugador ---
  // Estos se cargarán desde la base de datos
  late String _userName;
  late int _level;
  late int _currentExp;
  late int _streakCount;
  late int _totalMissions;
  late int _maxStreak;
  final int _maxExp = 100; // XP necesario para subir de nivel

  // --- Estado de la Pantalla ---
  List<Mission> _dailyMissions = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // Carga los datos frescos y genera las misiones cuando la pantalla se inicia
    _loadAndGenerateMissions();
  }

  /// Carga los datos más recientes del jugador desde la BD y genera las misiones del día.
  Future<void> _loadAndGenerateMissions() async {
    print("MISIONES_SCREEN: Iniciando carga de datos...");

    // 1. Llama al Singleton para obtener los datos más frescos
    final freshPlayerData = await PlayerDataService.instance.refreshPlayer(widget.player.id);

    print("MISIONES_SCREEN: Datos recibidos. Jugador: ${freshPlayerData?.name}");

    if (freshPlayerData == null) {
      if (mounted) setState(() => _isLoading = false);
      // Opcional: Mostrar un error
      return;
    }

    // 2. Genera las misiones basadas en los hábitos del jugador
    final selectedHabits = freshPlayerData.selectedHabits?.split(',').toSet() ?? {};
    final generatedMissions = MissionGeneratorService().generateDailyMissions(
      selectedHabits: selectedHabits,
      missionCount: 4, // Límite de 4 misiones diarias
    );

    // 3. Actualiza el estado de la pantalla con todos los datos
    setState(() {
      // Datos del jugador
      _userName = freshPlayerData.name;
      _level = freshPlayerData.level;
      _currentExp = freshPlayerData.xp;
      _streakCount = freshPlayerData.streak;
      _totalMissions = freshPlayerData.totalMissions;
      _maxStreak = freshPlayerData.maxStreak;

      // Misiones y carga
      _dailyMissions = generatedMissions;
      _isLoading = false;
    });
  }

  /// Se llama cuando el usuario completa una misión.
  void _completeMission(Mission missionToComplete) async {
    // 1. Actualiza el estado local de la UI inmediatamente
    setState(() {
      _currentExp += missionToComplete.xp;
      _totalMissions++;
      _streakCount++; // (Puedes añadir lógica de reseteo de racha en otro lugar)

      // Sube de nivel si es necesario
      if (_currentExp >= _maxExp) {
        _level++;
        _currentExp -= _maxExp;
        // Opcional: Mostrar un diálogo de "¡Subiste de nivel!"
      }

      // Revisa si la racha actual es un nuevo récord
      if (_streakCount > _maxStreak) {
        _maxStreak = _streakCount;
      }

      // Elimina la misión de la lista
      _dailyMissions.remove(missionToComplete);
    });

    // 2. Guarda el progreso en la base de datos (usando el Singleton)
    await PlayerDataService.instance.savePlayerProgress(
      playerId: widget.player.id,
      level: _level,
      xp: _currentExp,
      streak: _streakCount,
      totalMissions: _totalMissions,
      maxStreak: _maxStreak,
    );

    // 3. Muestra un mensaje de éxito
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('¡Misión "${missionToComplete.title}" completada! +${missionToComplete.xp} XP'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Muestra una pantalla de carga mientras se obtienen los datos
    if (_isLoading) {
      return const Scaffold(
        backgroundColor: Color(0xFF1a1a2e), // Color de fondo del tema
        body: Center(child: CircularProgressIndicator()),
      );
    }

    // Construye la pantalla principal
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Bienvenido,', style: GoogleFonts.orbitron(fontSize: 14, color: Colors.white70)),
            Text(_userName, style: GoogleFonts.orbitron(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          // --- Widget de Perfil y Barra de XP ---
          _buildPlayerHeader(),

          const Divider(color: Colors.blueGrey),

          // --- Lista de Misiones ---
          Expanded(
            child: _dailyMissions.isEmpty
                ? _buildMissionsCompleted()
                : _buildMissionList(),
          ),
        ],
      ),
    );
  }

  /// Widget para la cabecera del jugador (Nivel y XP)
  Widget _buildPlayerHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('NIVEL $_level', style: GoogleFonts.orbitron(fontWeight: FontWeight.bold, color: Colors.white)),
              Text('$_currentExp / $_maxExp XP', style: GoogleFonts.orbitron(color: Colors.white70)),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: _currentExp / _maxExp,
            minHeight: 12,
            borderRadius: BorderRadius.circular(6),
            backgroundColor: Colors.blue.shade900,
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.cyan),
          ),
        ],
      ),
    );
  }

  /// Widget para la lista de misiones
  Widget _buildMissionList() {
    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: _dailyMissions.length,
      itemBuilder: (context, index) {
        final mission = _dailyMissions[index];
        return Card(
          color: Colors.blue.shade900.withOpacity(0.8),
          child: ListTile(
            leading: const Icon(Icons.check_box_outline_blank, color: Colors.cyanAccent),
            title: Text(mission.title, style: GoogleFonts.orbitron(color: Colors.white, fontWeight: FontWeight.bold)),
            subtitle: Text(mission.description, style: GoogleFonts.orbitron(color: Colors.white70)),
            trailing: ElevatedButton(
              onPressed: () => _completeMission(mission),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.cyanAccent,
                foregroundColor: Colors.black,
              ),
              child: Text('+${mission.xp} XP'),
            ),
          ),
        );
      },
    );
  }

  /// Widget que se muestra cuando no hay misiones
  Widget _buildMissionsCompleted() {
    return Center(
      child: Text(
        '¡Misiones completadas por hoy!',
        style: GoogleFonts.orbitron(fontSize: 18, color: Colors.greenAccent),
      ),
    );
  }
}
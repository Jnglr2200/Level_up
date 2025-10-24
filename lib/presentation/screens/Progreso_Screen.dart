import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../data/database/local_database.dart';
import '../../data/services/player_data_service.dart';

class ProgresoScreen extends StatefulWidget {
  final Player player;
  const ProgresoScreen({super.key, required this.player});

  @override
  State<ProgresoScreen> createState() => _ProgresoScreenState();
}

class _ProgresoScreenState extends State<ProgresoScreen> {
  late Player _currentPlayer;
  bool _isLoading = true;
  final int _maxExp = 100; // Asumimos 100 XP por nivel

  @override
  void initState() {
    super.initState();
    _loadPlayerData();
  }

  // Usamos 'didUpdateWidget' para recargar si el jugador cambia
  // y 'AutomaticKeepAliveClientMixin' podría ser mejor, pero esto funciona
  // por ahora para refrescar al cambiar de pestaña.
  // **Edición:** No, `IndexedStack` ya soluciona esto.
  // Vamos a añadir un botón de refrescar manual por si acaso.
  Future<void> _loadPlayerData() async {
    if (!mounted) return;
    setState(() => _isLoading = true);

    // --- ARREGLO AQUÍ ---
    // Usa la instancia única del servicio
    final freshData = await PlayerDataService.instance.refreshPlayer(widget.player.id);
    // --------------------

    if (freshData != null && mounted) {
      setState(() {
        _currentPlayer = freshData;
        _isLoading = false;
      });
    } else if (mounted) {
      setState(() => _isLoading = false);
    }
  }
  String _calculateRank(int level) {
    if (level <= 10) return 'Rango E';
    if (level <= 20) return 'Rango D';
    if (level <= 30) return 'Rango C';
    if (level <= 40) return 'Rango B';
    if (level <= 50) return 'Rango A';
    return 'Rango S - Cazador Maestro';
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text('Progreso del Cazador', style: GoogleFonts.orbitron(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        actions: [
          // Botón para refrescar manualmente los datos
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadPlayerData,
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildProfileCard(
            _currentPlayer.name,
            _currentPlayer.level,
            _calculateRank(_currentPlayer.level),
            _currentPlayer.xp, // Pasa el XP actual
          ),
          const SizedBox(height: 24),
          Text(
            'Estadísticas Clave',
            style: GoogleFonts.orbitron(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 16),
          GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              // --- TARJETAS DE ESTADÍSTICAS ACTUALIZADAS ---
              _buildStatCard(
                icon: Icons.local_fire_department,
                label: 'Misiones Realizadas',
                value: '${_currentPlayer.streak} Misiones',
                color: Colors.orange.shade700,
              ),
            ],
          ),
        ],
      ),
    );
  }

  // --- WIDGET DE PERFIL ACTUALIZADO CON BARRA DE XP ---
  Widget _buildProfileCard(String name, int level, String rank, int currentXp) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.blue.shade900.withOpacity(0.8),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.cyan.shade400, width: 2),
      ),
      child: Row(
        children: [
          const Icon(Icons.person, color: Colors.cyan, size: 60),
          const SizedBox(width: 20),
          Expanded( // Usamos Expanded para que la barra de XP se ajuste
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: GoogleFonts.orbitron(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
                const SizedBox(height: 4),
                Text('Nivel $level - $rank', style: GoogleFonts.orbitron(fontSize: 16, color: Colors.white70)),
                // --- BARRA DE XP AÑADIDA ---
                const SizedBox(height: 12),
                LinearProgressIndicator(
                  value: currentXp / _maxExp,
                  minHeight: 10,
                  borderRadius: BorderRadius.circular(5),
                  backgroundColor: Colors.blue.shade800,
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.cyanAccent),
                ),
                const SizedBox(height: 4),
                Text('$currentXp / $_maxExp XP', style: GoogleFonts.orbitron(fontSize: 14, color: Colors.white70)),
                // -----------------------------
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- (El widget _buildStatCard no cambia su definición) ---
  Widget _buildStatCard({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.shade900.withOpacity(0.8),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(height: 12),
          Text(label, style: GoogleFonts.orbitron(color: Colors.white70, fontSize: 14)),
          const SizedBox(height: 4),
          Text(value, style: GoogleFonts.orbitron(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
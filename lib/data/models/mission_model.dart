class Mission {
  final String id;
  final String title;
  final String description;
  final int xp;
  final String category;
  final String difficulty;

  const Mission({
    required this.id,
    required this.title,
    required this.description,
    required this.xp,
    required this.category,
    required this.difficulty,
  });

  /// Factory constructor para crear una Misión desde un mapa JSON (la API)
  factory Mission.fromJson(Map<String, dynamic> json) {
    return Mission(
      id: json['id'],
      title: json['title'],
      description: json['description'],

      // --- ESTA ES LA LÍNEA QUE ARREGLA EL ERROR ---
      xp: (json['xp'] as num).toInt(),
      // ---------------------------------------------

      category: json['category'],
      difficulty: json['difficulty'],
    );
  }
}
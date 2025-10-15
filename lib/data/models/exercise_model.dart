class Exercise {
  final String name;
  final String type;
  final String muscle;
  final String difficulty;
  final String instructions;
  bool isCompleted; // <-- AÑADE ESTA LÍNEA

  Exercise({
    required this.name,
    required this.type,
    required this.muscle,
    required this.difficulty,
    required this.instructions,
    this.isCompleted = false, // <-- AÑADE ESTO
  });

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      name: json['name'] ?? 'No Name',
      type: json['type'] ?? 'No Type',
      muscle: json['muscle'] ?? 'No Muscle',
      difficulty: json['difficulty'] ?? 'No Difficulty',
      instructions: json['instructions'] ?? 'No Instructions',
    );
  }
}
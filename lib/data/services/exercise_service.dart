/*import 'dart:convert';
import 'package:http/http.dart' as http; // <-- Asegúrate de que esta línea esté así
import 'dart:math'; // Importa la librería de matemáticas para el generador aleatorio
import '../models/mission_bank.dart';

class ExerciseService {
  final String _apiKey = 'syT/9sYr/y9C8nq1/3DGrw==zB6001nZpWuSkLEE'; // <-- IMPORTANTE: Consigue tu clave en la web de API Ninjas
  final String _baseUrl = 'https://api.api-ninjas.com/v1/exercises';

  Future<List<Exercise>> fetchExercises({
    List<String> types = const ['strength', 'cardio', 'plyometrics'],
    int limit = 10,
  }) async {
    // 1. Elige un tipo de ejercicio al azar de tu lista.
    final randomType = types[Random().nextInt(types.length)];

    // 2. Construye la URL para buscar ejercicios de ese tipo específico.
    final url = '$_baseUrl?type=$randomType&limit=$limit';

    print('Buscando misiones desde: $url'); // Imprime la URL para depurar

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {'X-Api-Key': _apiKey},
      );

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        // 3. Ya no necesitamos filtrar aquí porque pedimos el tipo correcto a la API.
        return data.map((json) => Exercise.fromJson(json)).toList();
      } else {
        // Lanza un error más claro
        throw Exception('Error de la API: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Fallo al conectar con el servidor: $e');
    }
  }
}*/
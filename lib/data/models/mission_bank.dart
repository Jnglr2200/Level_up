import '../models/mission_model.dart';

// Esta es tu lista maestra con todas las misiones posibles.
// ¡Puedes añadir tantas como quieras!

const List<Mission> missionBank = [
  // --- Categoría: Ejercicio ---
  Mission(
    id: 'ex_01',
    title: 'Caminata Rápida',
    description: 'Realiza una caminata de 30 minutos a un ritmo enérgico.',
    xp: 25,
    difficulty: 'fácil', // Corregido
    category: 'Ejercicio',
  ),
  Mission(
    id: 'ex_02',
    title: 'Serie de Flexiones',
    description: 'Completa 3 series de 10 flexiones.',
    xp: 20,
    difficulty: 'medio', // Corregido
    category: 'Ejercicio',
  ),
  Mission(
    id: 'ex_03',
    title: 'Estiramiento Profundo',
    description: 'Dedica 15 minutos a estirar los principales grupos musculares.',
    xp: 15,
    difficulty: 'fácil', // Corregido
    category: 'Ejercicio',
  ),
  Mission(
    id: 'ex_04',
    title: 'Sentadillas',
    description: 'Realiza 3 series de 15 sentadillas con peso corporal.',
    xp: 20,
    difficulty: 'medio', // Corregido
    category: 'Ejercicio',
  ),
  Mission(
    id: 'ex_05',
    title: 'Plancha Isométrica',
    description: 'Mantén la posición de plancha durante 60 segundos.',
    xp: 30,
    difficulty: 'medio', // Corregido
    category: 'Ejercicio',
  ),
  Mission(
    id: 'ex_06',
    title: 'Saltar la Cuerda',
    description: 'Salta la cuerda durante 10 minutos, con pequeños descansos.',
    xp: 35,
    difficulty: 'difícil', // Corregido
    category: 'Ejercicio',
  ),
  Mission(
    id: 'ex_07',
    title: 'Zancadas Alternas',
    description: 'Completa 3 series de 12 zancadas por cada pierna.',
    xp: 25,
    difficulty: 'medio', // Corregido
    category: 'Ejercicio',
  ),
  Mission(
    id: 'ex_08',
    title: 'Subir Escaleras',
    description: 'Sube y baja escaleras durante 10 minutos seguidos.',
    xp: 40,
    difficulty: 'difícil', // Corregido
    category: 'Ejercicio',
  ),

  // --- Categoría: Alimentación ---
  Mission(
    id: 'al_01',
    title: 'Hidratación Maestra',
    description: 'Bebe 2 litros de agua a lo largo del día.',
    xp: 20,
    difficulty: 'fácil', // Corregido
    category: 'Alimentación',
  ),
  Mission(
    id: 'al_02',
    title: 'Snack Saludable',
    description: 'Come una pieza de fruta en lugar de un snack procesado.',
    xp: 15,
    difficulty: 'fácil', // Corregido
    category: 'Alimentación',
  ),

  // --- Categoría: Descanso ---
  Mission(
    id: 'de_01',
    title: 'Meditación Corta',
    description: 'Realiza una meditación guiada de 10 minutos.',
    xp: 15,
    difficulty: 'fácil', // Corregido
    category: 'Descanso',
  ),
  Mission(
    id: 'de_02',
    title: 'Sin Pantallas',
    description: 'Apaga todas las pantallas 30 minutos antes de dormir.',
    xp: 25,
    difficulty: 'medio', // Corregido
    category: 'Descanso',
  ),

  // --- Categoría: Salud Mental ---
  Mission(
    id: 'sm_01',
    title: 'Diario de Gratitud',
    description: 'Escribe 3 cosas por las que estés agradecido hoy.',
    xp: 20,
    difficulty: 'fácil', // Corregido
    category: 'Salud Mental',
  ),

  // --- Categoría: Productividad ---
  Mission(
    id: 'pr_01',
    title: 'Organiza tu Espacio',
    description: 'Dedica 15 minutos a ordenar tu escritorio o área de trabajo.',
    xp: 20,
    difficulty: 'fácil', // Corregido
    category: 'Productividad',
  ),
];
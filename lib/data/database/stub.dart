// lib/data/database/stub.dart

import 'package:drift/drift.dart';

QueryExecutor connect() {
  throw UnsupportedError(
    'No se encontró una implementación de base de datos para esta plataforma.',
  );
}
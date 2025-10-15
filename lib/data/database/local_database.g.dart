// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_database.dart';

// ignore_for_file: type=lint
class $PlayersTable extends Players with TableInfo<$PlayersTable, Player> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlayersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _levelMeta = const VerificationMeta('level');
  @override
  late final GeneratedColumn<int> level = GeneratedColumn<int>(
      'level', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(1));
  static const VerificationMeta _xpMeta = const VerificationMeta('xp');
  @override
  late final GeneratedColumn<int> xp = GeneratedColumn<int>(
      'xp', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _streakMeta = const VerificationMeta('streak');
  @override
  late final GeneratedColumn<int> streak = GeneratedColumn<int>(
      'streak', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _selectedHabitsMeta =
      const VerificationMeta('selectedHabits');
  @override
  late final GeneratedColumn<String> selectedHabits = GeneratedColumn<String>(
      'selected_habits', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _hasSelectedHabitsMeta =
      const VerificationMeta('hasSelectedHabits');
  @override
  late final GeneratedColumn<bool> hasSelectedHabits = GeneratedColumn<bool>(
      'has_selected_habits', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("has_selected_habits" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, level, xp, streak, selectedHabits, hasSelectedHabits];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'players';
  @override
  VerificationContext validateIntegrity(Insertable<Player> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('level')) {
      context.handle(
          _levelMeta, level.isAcceptableOrUnknown(data['level']!, _levelMeta));
    }
    if (data.containsKey('xp')) {
      context.handle(_xpMeta, xp.isAcceptableOrUnknown(data['xp']!, _xpMeta));
    }
    if (data.containsKey('streak')) {
      context.handle(_streakMeta,
          streak.isAcceptableOrUnknown(data['streak']!, _streakMeta));
    }
    if (data.containsKey('selected_habits')) {
      context.handle(
          _selectedHabitsMeta,
          selectedHabits.isAcceptableOrUnknown(
              data['selected_habits']!, _selectedHabitsMeta));
    }
    if (data.containsKey('has_selected_habits')) {
      context.handle(
          _hasSelectedHabitsMeta,
          hasSelectedHabits.isAcceptableOrUnknown(
              data['has_selected_habits']!, _hasSelectedHabitsMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Player map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Player(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      level: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}level'])!,
      xp: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}xp'])!,
      streak: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}streak'])!,
      selectedHabits: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}selected_habits']),
      hasSelectedHabits: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}has_selected_habits'])!,
    );
  }

  @override
  $PlayersTable createAlias(String alias) {
    return $PlayersTable(attachedDatabase, alias);
  }
}

class Player extends DataClass implements Insertable<Player> {
  final int id;
  final String name;
  final int level;
  final int xp;
  final int streak;
  final String? selectedHabits;
  final bool hasSelectedHabits;
  const Player(
      {required this.id,
      required this.name,
      required this.level,
      required this.xp,
      required this.streak,
      this.selectedHabits,
      required this.hasSelectedHabits});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['level'] = Variable<int>(level);
    map['xp'] = Variable<int>(xp);
    map['streak'] = Variable<int>(streak);
    if (!nullToAbsent || selectedHabits != null) {
      map['selected_habits'] = Variable<String>(selectedHabits);
    }
    map['has_selected_habits'] = Variable<bool>(hasSelectedHabits);
    return map;
  }

  PlayersCompanion toCompanion(bool nullToAbsent) {
    return PlayersCompanion(
      id: Value(id),
      name: Value(name),
      level: Value(level),
      xp: Value(xp),
      streak: Value(streak),
      selectedHabits: selectedHabits == null && nullToAbsent
          ? const Value.absent()
          : Value(selectedHabits),
      hasSelectedHabits: Value(hasSelectedHabits),
    );
  }

  factory Player.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Player(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      level: serializer.fromJson<int>(json['level']),
      xp: serializer.fromJson<int>(json['xp']),
      streak: serializer.fromJson<int>(json['streak']),
      selectedHabits: serializer.fromJson<String?>(json['selectedHabits']),
      hasSelectedHabits: serializer.fromJson<bool>(json['hasSelectedHabits']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'level': serializer.toJson<int>(level),
      'xp': serializer.toJson<int>(xp),
      'streak': serializer.toJson<int>(streak),
      'selectedHabits': serializer.toJson<String?>(selectedHabits),
      'hasSelectedHabits': serializer.toJson<bool>(hasSelectedHabits),
    };
  }

  Player copyWith(
          {int? id,
          String? name,
          int? level,
          int? xp,
          int? streak,
          Value<String?> selectedHabits = const Value.absent(),
          bool? hasSelectedHabits}) =>
      Player(
        id: id ?? this.id,
        name: name ?? this.name,
        level: level ?? this.level,
        xp: xp ?? this.xp,
        streak: streak ?? this.streak,
        selectedHabits:
            selectedHabits.present ? selectedHabits.value : this.selectedHabits,
        hasSelectedHabits: hasSelectedHabits ?? this.hasSelectedHabits,
      );
  Player copyWithCompanion(PlayersCompanion data) {
    return Player(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      level: data.level.present ? data.level.value : this.level,
      xp: data.xp.present ? data.xp.value : this.xp,
      streak: data.streak.present ? data.streak.value : this.streak,
      selectedHabits: data.selectedHabits.present
          ? data.selectedHabits.value
          : this.selectedHabits,
      hasSelectedHabits: data.hasSelectedHabits.present
          ? data.hasSelectedHabits.value
          : this.hasSelectedHabits,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Player(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('level: $level, ')
          ..write('xp: $xp, ')
          ..write('streak: $streak, ')
          ..write('selectedHabits: $selectedHabits, ')
          ..write('hasSelectedHabits: $hasSelectedHabits')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, name, level, xp, streak, selectedHabits, hasSelectedHabits);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Player &&
          other.id == this.id &&
          other.name == this.name &&
          other.level == this.level &&
          other.xp == this.xp &&
          other.streak == this.streak &&
          other.selectedHabits == this.selectedHabits &&
          other.hasSelectedHabits == this.hasSelectedHabits);
}

class PlayersCompanion extends UpdateCompanion<Player> {
  final Value<int> id;
  final Value<String> name;
  final Value<int> level;
  final Value<int> xp;
  final Value<int> streak;
  final Value<String?> selectedHabits;
  final Value<bool> hasSelectedHabits;
  const PlayersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.level = const Value.absent(),
    this.xp = const Value.absent(),
    this.streak = const Value.absent(),
    this.selectedHabits = const Value.absent(),
    this.hasSelectedHabits = const Value.absent(),
  });
  PlayersCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.level = const Value.absent(),
    this.xp = const Value.absent(),
    this.streak = const Value.absent(),
    this.selectedHabits = const Value.absent(),
    this.hasSelectedHabits = const Value.absent(),
  }) : name = Value(name);
  static Insertable<Player> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? level,
    Expression<int>? xp,
    Expression<int>? streak,
    Expression<String>? selectedHabits,
    Expression<bool>? hasSelectedHabits,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (level != null) 'level': level,
      if (xp != null) 'xp': xp,
      if (streak != null) 'streak': streak,
      if (selectedHabits != null) 'selected_habits': selectedHabits,
      if (hasSelectedHabits != null) 'has_selected_habits': hasSelectedHabits,
    });
  }

  PlayersCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<int>? level,
      Value<int>? xp,
      Value<int>? streak,
      Value<String?>? selectedHabits,
      Value<bool>? hasSelectedHabits}) {
    return PlayersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      level: level ?? this.level,
      xp: xp ?? this.xp,
      streak: streak ?? this.streak,
      selectedHabits: selectedHabits ?? this.selectedHabits,
      hasSelectedHabits: hasSelectedHabits ?? this.hasSelectedHabits,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (level.present) {
      map['level'] = Variable<int>(level.value);
    }
    if (xp.present) {
      map['xp'] = Variable<int>(xp.value);
    }
    if (streak.present) {
      map['streak'] = Variable<int>(streak.value);
    }
    if (selectedHabits.present) {
      map['selected_habits'] = Variable<String>(selectedHabits.value);
    }
    if (hasSelectedHabits.present) {
      map['has_selected_habits'] = Variable<bool>(hasSelectedHabits.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlayersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('level: $level, ')
          ..write('xp: $xp, ')
          ..write('streak: $streak, ')
          ..write('selectedHabits: $selectedHabits, ')
          ..write('hasSelectedHabits: $hasSelectedHabits')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $PlayersTable players = $PlayersTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [players];
}

typedef $$PlayersTableCreateCompanionBuilder = PlayersCompanion Function({
  Value<int> id,
  required String name,
  Value<int> level,
  Value<int> xp,
  Value<int> streak,
  Value<String?> selectedHabits,
  Value<bool> hasSelectedHabits,
});
typedef $$PlayersTableUpdateCompanionBuilder = PlayersCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<int> level,
  Value<int> xp,
  Value<int> streak,
  Value<String?> selectedHabits,
  Value<bool> hasSelectedHabits,
});

class $$PlayersTableFilterComposer
    extends Composer<_$AppDatabase, $PlayersTable> {
  $$PlayersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get level => $composableBuilder(
      column: $table.level, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get xp => $composableBuilder(
      column: $table.xp, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get streak => $composableBuilder(
      column: $table.streak, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get selectedHabits => $composableBuilder(
      column: $table.selectedHabits,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get hasSelectedHabits => $composableBuilder(
      column: $table.hasSelectedHabits,
      builder: (column) => ColumnFilters(column));
}

class $$PlayersTableOrderingComposer
    extends Composer<_$AppDatabase, $PlayersTable> {
  $$PlayersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get level => $composableBuilder(
      column: $table.level, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get xp => $composableBuilder(
      column: $table.xp, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get streak => $composableBuilder(
      column: $table.streak, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get selectedHabits => $composableBuilder(
      column: $table.selectedHabits,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get hasSelectedHabits => $composableBuilder(
      column: $table.hasSelectedHabits,
      builder: (column) => ColumnOrderings(column));
}

class $$PlayersTableAnnotationComposer
    extends Composer<_$AppDatabase, $PlayersTable> {
  $$PlayersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get level =>
      $composableBuilder(column: $table.level, builder: (column) => column);

  GeneratedColumn<int> get xp =>
      $composableBuilder(column: $table.xp, builder: (column) => column);

  GeneratedColumn<int> get streak =>
      $composableBuilder(column: $table.streak, builder: (column) => column);

  GeneratedColumn<String> get selectedHabits => $composableBuilder(
      column: $table.selectedHabits, builder: (column) => column);

  GeneratedColumn<bool> get hasSelectedHabits => $composableBuilder(
      column: $table.hasSelectedHabits, builder: (column) => column);
}

class $$PlayersTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PlayersTable,
    Player,
    $$PlayersTableFilterComposer,
    $$PlayersTableOrderingComposer,
    $$PlayersTableAnnotationComposer,
    $$PlayersTableCreateCompanionBuilder,
    $$PlayersTableUpdateCompanionBuilder,
    (Player, BaseReferences<_$AppDatabase, $PlayersTable, Player>),
    Player,
    PrefetchHooks Function()> {
  $$PlayersTableTableManager(_$AppDatabase db, $PlayersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PlayersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PlayersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PlayersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<int> level = const Value.absent(),
            Value<int> xp = const Value.absent(),
            Value<int> streak = const Value.absent(),
            Value<String?> selectedHabits = const Value.absent(),
            Value<bool> hasSelectedHabits = const Value.absent(),
          }) =>
              PlayersCompanion(
            id: id,
            name: name,
            level: level,
            xp: xp,
            streak: streak,
            selectedHabits: selectedHabits,
            hasSelectedHabits: hasSelectedHabits,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            Value<int> level = const Value.absent(),
            Value<int> xp = const Value.absent(),
            Value<int> streak = const Value.absent(),
            Value<String?> selectedHabits = const Value.absent(),
            Value<bool> hasSelectedHabits = const Value.absent(),
          }) =>
              PlayersCompanion.insert(
            id: id,
            name: name,
            level: level,
            xp: xp,
            streak: streak,
            selectedHabits: selectedHabits,
            hasSelectedHabits: hasSelectedHabits,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$PlayersTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $PlayersTable,
    Player,
    $$PlayersTableFilterComposer,
    $$PlayersTableOrderingComposer,
    $$PlayersTableAnnotationComposer,
    $$PlayersTableCreateCompanionBuilder,
    $$PlayersTableUpdateCompanionBuilder,
    (Player, BaseReferences<_$AppDatabase, $PlayersTable, Player>),
    Player,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$PlayersTableTableManager get players =>
      $$PlayersTableTableManager(_db, _db.players);
}

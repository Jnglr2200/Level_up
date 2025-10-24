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
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
      'email', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _passwordMeta =
      const VerificationMeta('password');
  @override
  late final GeneratedColumn<String> password = GeneratedColumn<String>(
      'password', aliasedName, false,
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
  static const VerificationMeta _totalMissionsMeta =
      const VerificationMeta('totalMissions');
  @override
  late final GeneratedColumn<int> totalMissions = GeneratedColumn<int>(
      'total_missions', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _maxStreakMeta =
      const VerificationMeta('maxStreak');
  @override
  late final GeneratedColumn<int> maxStreak = GeneratedColumn<int>(
      'max_streak', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
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
  static const VerificationMeta _lastMissionDateMeta =
      const VerificationMeta('lastMissionDate');
  @override
  late final GeneratedColumn<String> lastMissionDate = GeneratedColumn<String>(
      'last_mission_date', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _activeMissionIdsMeta =
      const VerificationMeta('activeMissionIds');
  @override
  late final GeneratedColumn<String> activeMissionIds = GeneratedColumn<String>(
      'active_mission_ids', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        email,
        password,
        level,
        xp,
        streak,
        selectedHabits,
        totalMissions,
        maxStreak,
        hasSelectedHabits,
        lastMissionDate,
        activeMissionIds
      ];
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
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('password')) {
      context.handle(_passwordMeta,
          password.isAcceptableOrUnknown(data['password']!, _passwordMeta));
    } else if (isInserting) {
      context.missing(_passwordMeta);
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
    if (data.containsKey('total_missions')) {
      context.handle(
          _totalMissionsMeta,
          totalMissions.isAcceptableOrUnknown(
              data['total_missions']!, _totalMissionsMeta));
    }
    if (data.containsKey('max_streak')) {
      context.handle(_maxStreakMeta,
          maxStreak.isAcceptableOrUnknown(data['max_streak']!, _maxStreakMeta));
    }
    if (data.containsKey('has_selected_habits')) {
      context.handle(
          _hasSelectedHabitsMeta,
          hasSelectedHabits.isAcceptableOrUnknown(
              data['has_selected_habits']!, _hasSelectedHabitsMeta));
    }
    if (data.containsKey('last_mission_date')) {
      context.handle(
          _lastMissionDateMeta,
          lastMissionDate.isAcceptableOrUnknown(
              data['last_mission_date']!, _lastMissionDateMeta));
    }
    if (data.containsKey('active_mission_ids')) {
      context.handle(
          _activeMissionIdsMeta,
          activeMissionIds.isAcceptableOrUnknown(
              data['active_mission_ids']!, _activeMissionIdsMeta));
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
      email: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}email'])!,
      password: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}password'])!,
      level: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}level'])!,
      xp: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}xp'])!,
      streak: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}streak'])!,
      selectedHabits: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}selected_habits']),
      totalMissions: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}total_missions'])!,
      maxStreak: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}max_streak'])!,
      hasSelectedHabits: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}has_selected_habits'])!,
      lastMissionDate: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}last_mission_date']),
      activeMissionIds: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}active_mission_ids']),
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
  final String email;
  final String password;
  final int level;
  final int xp;
  final int streak;
  final String? selectedHabits;
  final int totalMissions;
  final int maxStreak;
  final bool hasSelectedHabits;
  final String? lastMissionDate;
  final String? activeMissionIds;
  const Player(
      {required this.id,
      required this.name,
      required this.email,
      required this.password,
      required this.level,
      required this.xp,
      required this.streak,
      this.selectedHabits,
      required this.totalMissions,
      required this.maxStreak,
      required this.hasSelectedHabits,
      this.lastMissionDate,
      this.activeMissionIds});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['email'] = Variable<String>(email);
    map['password'] = Variable<String>(password);
    map['level'] = Variable<int>(level);
    map['xp'] = Variable<int>(xp);
    map['streak'] = Variable<int>(streak);
    if (!nullToAbsent || selectedHabits != null) {
      map['selected_habits'] = Variable<String>(selectedHabits);
    }
    map['total_missions'] = Variable<int>(totalMissions);
    map['max_streak'] = Variable<int>(maxStreak);
    map['has_selected_habits'] = Variable<bool>(hasSelectedHabits);
    if (!nullToAbsent || lastMissionDate != null) {
      map['last_mission_date'] = Variable<String>(lastMissionDate);
    }
    if (!nullToAbsent || activeMissionIds != null) {
      map['active_mission_ids'] = Variable<String>(activeMissionIds);
    }
    return map;
  }

  PlayersCompanion toCompanion(bool nullToAbsent) {
    return PlayersCompanion(
      id: Value(id),
      name: Value(name),
      email: Value(email),
      password: Value(password),
      level: Value(level),
      xp: Value(xp),
      streak: Value(streak),
      selectedHabits: selectedHabits == null && nullToAbsent
          ? const Value.absent()
          : Value(selectedHabits),
      totalMissions: Value(totalMissions),
      maxStreak: Value(maxStreak),
      hasSelectedHabits: Value(hasSelectedHabits),
      lastMissionDate: lastMissionDate == null && nullToAbsent
          ? const Value.absent()
          : Value(lastMissionDate),
      activeMissionIds: activeMissionIds == null && nullToAbsent
          ? const Value.absent()
          : Value(activeMissionIds),
    );
  }

  factory Player.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Player(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      email: serializer.fromJson<String>(json['email']),
      password: serializer.fromJson<String>(json['password']),
      level: serializer.fromJson<int>(json['level']),
      xp: serializer.fromJson<int>(json['xp']),
      streak: serializer.fromJson<int>(json['streak']),
      selectedHabits: serializer.fromJson<String?>(json['selectedHabits']),
      totalMissions: serializer.fromJson<int>(json['totalMissions']),
      maxStreak: serializer.fromJson<int>(json['maxStreak']),
      hasSelectedHabits: serializer.fromJson<bool>(json['hasSelectedHabits']),
      lastMissionDate: serializer.fromJson<String?>(json['lastMissionDate']),
      activeMissionIds: serializer.fromJson<String?>(json['activeMissionIds']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'email': serializer.toJson<String>(email),
      'password': serializer.toJson<String>(password),
      'level': serializer.toJson<int>(level),
      'xp': serializer.toJson<int>(xp),
      'streak': serializer.toJson<int>(streak),
      'selectedHabits': serializer.toJson<String?>(selectedHabits),
      'totalMissions': serializer.toJson<int>(totalMissions),
      'maxStreak': serializer.toJson<int>(maxStreak),
      'hasSelectedHabits': serializer.toJson<bool>(hasSelectedHabits),
      'lastMissionDate': serializer.toJson<String?>(lastMissionDate),
      'activeMissionIds': serializer.toJson<String?>(activeMissionIds),
    };
  }

  Player copyWith(
          {int? id,
          String? name,
          String? email,
          String? password,
          int? level,
          int? xp,
          int? streak,
          Value<String?> selectedHabits = const Value.absent(),
          int? totalMissions,
          int? maxStreak,
          bool? hasSelectedHabits,
          Value<String?> lastMissionDate = const Value.absent(),
          Value<String?> activeMissionIds = const Value.absent()}) =>
      Player(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        password: password ?? this.password,
        level: level ?? this.level,
        xp: xp ?? this.xp,
        streak: streak ?? this.streak,
        selectedHabits:
            selectedHabits.present ? selectedHabits.value : this.selectedHabits,
        totalMissions: totalMissions ?? this.totalMissions,
        maxStreak: maxStreak ?? this.maxStreak,
        hasSelectedHabits: hasSelectedHabits ?? this.hasSelectedHabits,
        lastMissionDate: lastMissionDate.present
            ? lastMissionDate.value
            : this.lastMissionDate,
        activeMissionIds: activeMissionIds.present
            ? activeMissionIds.value
            : this.activeMissionIds,
      );
  Player copyWithCompanion(PlayersCompanion data) {
    return Player(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      email: data.email.present ? data.email.value : this.email,
      password: data.password.present ? data.password.value : this.password,
      level: data.level.present ? data.level.value : this.level,
      xp: data.xp.present ? data.xp.value : this.xp,
      streak: data.streak.present ? data.streak.value : this.streak,
      selectedHabits: data.selectedHabits.present
          ? data.selectedHabits.value
          : this.selectedHabits,
      totalMissions: data.totalMissions.present
          ? data.totalMissions.value
          : this.totalMissions,
      maxStreak: data.maxStreak.present ? data.maxStreak.value : this.maxStreak,
      hasSelectedHabits: data.hasSelectedHabits.present
          ? data.hasSelectedHabits.value
          : this.hasSelectedHabits,
      lastMissionDate: data.lastMissionDate.present
          ? data.lastMissionDate.value
          : this.lastMissionDate,
      activeMissionIds: data.activeMissionIds.present
          ? data.activeMissionIds.value
          : this.activeMissionIds,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Player(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('password: $password, ')
          ..write('level: $level, ')
          ..write('xp: $xp, ')
          ..write('streak: $streak, ')
          ..write('selectedHabits: $selectedHabits, ')
          ..write('totalMissions: $totalMissions, ')
          ..write('maxStreak: $maxStreak, ')
          ..write('hasSelectedHabits: $hasSelectedHabits, ')
          ..write('lastMissionDate: $lastMissionDate, ')
          ..write('activeMissionIds: $activeMissionIds')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      name,
      email,
      password,
      level,
      xp,
      streak,
      selectedHabits,
      totalMissions,
      maxStreak,
      hasSelectedHabits,
      lastMissionDate,
      activeMissionIds);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Player &&
          other.id == this.id &&
          other.name == this.name &&
          other.email == this.email &&
          other.password == this.password &&
          other.level == this.level &&
          other.xp == this.xp &&
          other.streak == this.streak &&
          other.selectedHabits == this.selectedHabits &&
          other.totalMissions == this.totalMissions &&
          other.maxStreak == this.maxStreak &&
          other.hasSelectedHabits == this.hasSelectedHabits &&
          other.lastMissionDate == this.lastMissionDate &&
          other.activeMissionIds == this.activeMissionIds);
}

class PlayersCompanion extends UpdateCompanion<Player> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> email;
  final Value<String> password;
  final Value<int> level;
  final Value<int> xp;
  final Value<int> streak;
  final Value<String?> selectedHabits;
  final Value<int> totalMissions;
  final Value<int> maxStreak;
  final Value<bool> hasSelectedHabits;
  final Value<String?> lastMissionDate;
  final Value<String?> activeMissionIds;
  const PlayersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.email = const Value.absent(),
    this.password = const Value.absent(),
    this.level = const Value.absent(),
    this.xp = const Value.absent(),
    this.streak = const Value.absent(),
    this.selectedHabits = const Value.absent(),
    this.totalMissions = const Value.absent(),
    this.maxStreak = const Value.absent(),
    this.hasSelectedHabits = const Value.absent(),
    this.lastMissionDate = const Value.absent(),
    this.activeMissionIds = const Value.absent(),
  });
  PlayersCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String email,
    required String password,
    this.level = const Value.absent(),
    this.xp = const Value.absent(),
    this.streak = const Value.absent(),
    this.selectedHabits = const Value.absent(),
    this.totalMissions = const Value.absent(),
    this.maxStreak = const Value.absent(),
    this.hasSelectedHabits = const Value.absent(),
    this.lastMissionDate = const Value.absent(),
    this.activeMissionIds = const Value.absent(),
  })  : name = Value(name),
        email = Value(email),
        password = Value(password);
  static Insertable<Player> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? email,
    Expression<String>? password,
    Expression<int>? level,
    Expression<int>? xp,
    Expression<int>? streak,
    Expression<String>? selectedHabits,
    Expression<int>? totalMissions,
    Expression<int>? maxStreak,
    Expression<bool>? hasSelectedHabits,
    Expression<String>? lastMissionDate,
    Expression<String>? activeMissionIds,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (email != null) 'email': email,
      if (password != null) 'password': password,
      if (level != null) 'level': level,
      if (xp != null) 'xp': xp,
      if (streak != null) 'streak': streak,
      if (selectedHabits != null) 'selected_habits': selectedHabits,
      if (totalMissions != null) 'total_missions': totalMissions,
      if (maxStreak != null) 'max_streak': maxStreak,
      if (hasSelectedHabits != null) 'has_selected_habits': hasSelectedHabits,
      if (lastMissionDate != null) 'last_mission_date': lastMissionDate,
      if (activeMissionIds != null) 'active_mission_ids': activeMissionIds,
    });
  }

  PlayersCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String>? email,
      Value<String>? password,
      Value<int>? level,
      Value<int>? xp,
      Value<int>? streak,
      Value<String?>? selectedHabits,
      Value<int>? totalMissions,
      Value<int>? maxStreak,
      Value<bool>? hasSelectedHabits,
      Value<String?>? lastMissionDate,
      Value<String?>? activeMissionIds}) {
    return PlayersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      level: level ?? this.level,
      xp: xp ?? this.xp,
      streak: streak ?? this.streak,
      selectedHabits: selectedHabits ?? this.selectedHabits,
      totalMissions: totalMissions ?? this.totalMissions,
      maxStreak: maxStreak ?? this.maxStreak,
      hasSelectedHabits: hasSelectedHabits ?? this.hasSelectedHabits,
      lastMissionDate: lastMissionDate ?? this.lastMissionDate,
      activeMissionIds: activeMissionIds ?? this.activeMissionIds,
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
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (password.present) {
      map['password'] = Variable<String>(password.value);
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
    if (totalMissions.present) {
      map['total_missions'] = Variable<int>(totalMissions.value);
    }
    if (maxStreak.present) {
      map['max_streak'] = Variable<int>(maxStreak.value);
    }
    if (hasSelectedHabits.present) {
      map['has_selected_habits'] = Variable<bool>(hasSelectedHabits.value);
    }
    if (lastMissionDate.present) {
      map['last_mission_date'] = Variable<String>(lastMissionDate.value);
    }
    if (activeMissionIds.present) {
      map['active_mission_ids'] = Variable<String>(activeMissionIds.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlayersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('password: $password, ')
          ..write('level: $level, ')
          ..write('xp: $xp, ')
          ..write('streak: $streak, ')
          ..write('selectedHabits: $selectedHabits, ')
          ..write('totalMissions: $totalMissions, ')
          ..write('maxStreak: $maxStreak, ')
          ..write('hasSelectedHabits: $hasSelectedHabits, ')
          ..write('lastMissionDate: $lastMissionDate, ')
          ..write('activeMissionIds: $activeMissionIds')
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
  required String email,
  required String password,
  Value<int> level,
  Value<int> xp,
  Value<int> streak,
  Value<String?> selectedHabits,
  Value<int> totalMissions,
  Value<int> maxStreak,
  Value<bool> hasSelectedHabits,
  Value<String?> lastMissionDate,
  Value<String?> activeMissionIds,
});
typedef $$PlayersTableUpdateCompanionBuilder = PlayersCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String> email,
  Value<String> password,
  Value<int> level,
  Value<int> xp,
  Value<int> streak,
  Value<String?> selectedHabits,
  Value<int> totalMissions,
  Value<int> maxStreak,
  Value<bool> hasSelectedHabits,
  Value<String?> lastMissionDate,
  Value<String?> activeMissionIds,
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

  ColumnFilters<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get password => $composableBuilder(
      column: $table.password, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get level => $composableBuilder(
      column: $table.level, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get xp => $composableBuilder(
      column: $table.xp, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get streak => $composableBuilder(
      column: $table.streak, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get selectedHabits => $composableBuilder(
      column: $table.selectedHabits,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get totalMissions => $composableBuilder(
      column: $table.totalMissions, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get maxStreak => $composableBuilder(
      column: $table.maxStreak, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get hasSelectedHabits => $composableBuilder(
      column: $table.hasSelectedHabits,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get lastMissionDate => $composableBuilder(
      column: $table.lastMissionDate,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get activeMissionIds => $composableBuilder(
      column: $table.activeMissionIds,
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

  ColumnOrderings<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get password => $composableBuilder(
      column: $table.password, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get level => $composableBuilder(
      column: $table.level, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get xp => $composableBuilder(
      column: $table.xp, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get streak => $composableBuilder(
      column: $table.streak, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get selectedHabits => $composableBuilder(
      column: $table.selectedHabits,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get totalMissions => $composableBuilder(
      column: $table.totalMissions,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get maxStreak => $composableBuilder(
      column: $table.maxStreak, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get hasSelectedHabits => $composableBuilder(
      column: $table.hasSelectedHabits,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get lastMissionDate => $composableBuilder(
      column: $table.lastMissionDate,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get activeMissionIds => $composableBuilder(
      column: $table.activeMissionIds,
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

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get password =>
      $composableBuilder(column: $table.password, builder: (column) => column);

  GeneratedColumn<int> get level =>
      $composableBuilder(column: $table.level, builder: (column) => column);

  GeneratedColumn<int> get xp =>
      $composableBuilder(column: $table.xp, builder: (column) => column);

  GeneratedColumn<int> get streak =>
      $composableBuilder(column: $table.streak, builder: (column) => column);

  GeneratedColumn<String> get selectedHabits => $composableBuilder(
      column: $table.selectedHabits, builder: (column) => column);

  GeneratedColumn<int> get totalMissions => $composableBuilder(
      column: $table.totalMissions, builder: (column) => column);

  GeneratedColumn<int> get maxStreak =>
      $composableBuilder(column: $table.maxStreak, builder: (column) => column);

  GeneratedColumn<bool> get hasSelectedHabits => $composableBuilder(
      column: $table.hasSelectedHabits, builder: (column) => column);

  GeneratedColumn<String> get lastMissionDate => $composableBuilder(
      column: $table.lastMissionDate, builder: (column) => column);

  GeneratedColumn<String> get activeMissionIds => $composableBuilder(
      column: $table.activeMissionIds, builder: (column) => column);
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
            Value<String> email = const Value.absent(),
            Value<String> password = const Value.absent(),
            Value<int> level = const Value.absent(),
            Value<int> xp = const Value.absent(),
            Value<int> streak = const Value.absent(),
            Value<String?> selectedHabits = const Value.absent(),
            Value<int> totalMissions = const Value.absent(),
            Value<int> maxStreak = const Value.absent(),
            Value<bool> hasSelectedHabits = const Value.absent(),
            Value<String?> lastMissionDate = const Value.absent(),
            Value<String?> activeMissionIds = const Value.absent(),
          }) =>
              PlayersCompanion(
            id: id,
            name: name,
            email: email,
            password: password,
            level: level,
            xp: xp,
            streak: streak,
            selectedHabits: selectedHabits,
            totalMissions: totalMissions,
            maxStreak: maxStreak,
            hasSelectedHabits: hasSelectedHabits,
            lastMissionDate: lastMissionDate,
            activeMissionIds: activeMissionIds,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            required String email,
            required String password,
            Value<int> level = const Value.absent(),
            Value<int> xp = const Value.absent(),
            Value<int> streak = const Value.absent(),
            Value<String?> selectedHabits = const Value.absent(),
            Value<int> totalMissions = const Value.absent(),
            Value<int> maxStreak = const Value.absent(),
            Value<bool> hasSelectedHabits = const Value.absent(),
            Value<String?> lastMissionDate = const Value.absent(),
            Value<String?> activeMissionIds = const Value.absent(),
          }) =>
              PlayersCompanion.insert(
            id: id,
            name: name,
            email: email,
            password: password,
            level: level,
            xp: xp,
            streak: streak,
            selectedHabits: selectedHabits,
            totalMissions: totalMissions,
            maxStreak: maxStreak,
            hasSelectedHabits: hasSelectedHabits,
            lastMissionDate: lastMissionDate,
            activeMissionIds: activeMissionIds,
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

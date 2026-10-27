import 'package:drift/drift.dart';

import '../domain/enums.dart';

/// Senkron-hazır ortak kolonlar. Her tabloda aynı üçlü + version bulunur:
/// backend geldiğinde last-write-wins / çakışma tespiti için kullanılır.
mixin SyncColumns on Table {
  TextColumn get id => text()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  DateTimeColumn get deletedAt => dateTime().nullable()();
  IntColumn get version => integer().withDefault(const Constant(1))();
}

@DataClassName('PersonRow')
@TableIndex(name: 'idx_persons_email', columns: {#email})
class Persons extends Table with SyncColumns {
  TextColumn get name => text()();
  TextColumn get email => text().nullable()();
  TextColumn get role => text().nullable()();
  TextColumn get colorHex => text().nullable()();
  BoolColumn get isMe => boolean().withDefault(const Constant(false))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('ProjectRow')
@TableIndex(name: 'idx_projects_status_position', columns: {#status, #position})
@TableIndex(name: 'idx_projects_responsible', columns: {#responsiblePersonId})
@TableIndex(name: 'idx_projects_due', columns: {#dueDate})
class Projects extends Table with SyncColumns {
  TextColumn get title => text()();
  TextColumn get description => text().nullable()();
  TextColumn get priority => textEnum<Priority>()();
  TextColumn get status => textEnum<ProjectStatus>()();
  DateTimeColumn get startDate => dateTime().nullable()();
  DateTimeColumn get dueDate => dateTime().nullable()();
  TextColumn get responsiblePersonId => text()
      .nullable()
      .references(Persons, #id, onDelete: KeyAction.setNull)();
  TextColumn get details => text().nullable()();
  RealColumn get position => real()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('ProjectRequesterRow')
@TableIndex(name: 'idx_requesters_person', columns: {#personId})
class ProjectRequesters extends Table with SyncColumns {
  TextColumn get projectId =>
      text().references(Projects, #id, onDelete: KeyAction.cascade)();
  TextColumn get personId =>
      text().references(Persons, #id, onDelete: KeyAction.cascade)();

  @override
  Set<Column<Object>> get primaryKey => {id};

  @override
  List<Set<Column<Object>>> get uniqueKeys => [
    {projectId, personId},
  ];
}

@DataClassName('BoardColumnRow')
@TableIndex(name: 'idx_columns_project_position', columns: {#projectId, #position})
class BoardColumns extends Table with SyncColumns {
  TextColumn get projectId =>
      text().references(Projects, #id, onDelete: KeyAction.cascade)();
  TextColumn get name => text()();
  RealColumn get position => real()();
  TextColumn get colorHex => text().nullable()();
  IntColumn get wipLimit => integer().nullable()();
  BoolColumn get isDoneColumn => boolean().withDefault(const Constant(false))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('CardRow')
@TableIndex(name: 'idx_cards_column_position', columns: {#columnId, #position})
@TableIndex(name: 'idx_cards_project', columns: {#projectId})
@TableIndex(name: 'idx_cards_due', columns: {#dueDate})
class Cards extends Table with SyncColumns {
  TextColumn get columnId =>
      text().references(BoardColumns, #id, onDelete: KeyAction.cascade)();

  /// Denormalize: board ve proje geneli sorguları için. Repository,
  /// kartın sütunuyla aynı projede olmasını garanti eder.
  TextColumn get projectId =>
      text().references(Projects, #id, onDelete: KeyAction.cascade)();
  TextColumn get title => text()();
  TextColumn get description => text().nullable()();
  TextColumn get priority => textEnum<Priority>()();
  DateTimeColumn get dueDate => dateTime().nullable()();
  RealColumn get position => real()();
  DateTimeColumn get completedAt => dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('ChecklistItemRow')
@TableIndex(name: 'idx_checklist_card_position', columns: {#cardId, #position})
class ChecklistItems extends Table with SyncColumns {
  TextColumn get cardId =>
      text().references(Cards, #id, onDelete: KeyAction.cascade)();
  TextColumn get title => text()();
  BoolColumn get isDone => boolean().withDefault(const Constant(false))();
  RealColumn get position => real()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('LabelRow')
@TableIndex(name: 'idx_labels_project', columns: {#projectId})
class Labels extends Table with SyncColumns {
  TextColumn get projectId =>
      text().references(Projects, #id, onDelete: KeyAction.cascade)();
  TextColumn get name => text()();
  TextColumn get colorHex => text()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('CardLabelRow')
@TableIndex(name: 'idx_card_labels_label', columns: {#labelId})
class CardLabels extends Table with SyncColumns {
  TextColumn get cardId =>
      text().references(Cards, #id, onDelete: KeyAction.cascade)();
  TextColumn get labelId =>
      text().references(Labels, #id, onDelete: KeyAction.cascade)();

  @override
  Set<Column<Object>> get primaryKey => {id};

  @override
  List<Set<Column<Object>>> get uniqueKeys => [
    {cardId, labelId},
  ];
}

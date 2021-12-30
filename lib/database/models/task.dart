
import 'package:moor/moor.dart';

@DataClassName('Task')
class Tasks extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get taskName => text()();
  TextColumn get description => text()();
  DateTimeColumn get startDateTime => dateTime()();
  DateTimeColumn get endDateTime => dateTime()();
  BoolColumn get taskStatus => boolean()();
}

part of 'table_cubit.dart';

@immutable
abstract class TableCubitState {
  const TableCubitState();
}

class ConfirmationInfoInitial extends TableCubitState {
  const ConfirmationInfoInitial();
}

class TableCubitReload extends TableCubitState {
  const TableCubitReload();
}

class TableCubitSpotReload extends TableCubitState {
  const TableCubitSpotReload();
}

class TableCubitFutureReload extends TableCubitState {
  const TableCubitFutureReload();
}

class TableCubitSortDescend extends TableCubitState {
  const TableCubitSortDescend();
}

class TableCubitSortAscend extends TableCubitState {
  const TableCubitSortAscend();
}

class TableCubitChangeSortAscend extends TableCubitState {
  const TableCubitChangeSortAscend();
}

class TableCubitChangeSortDescend extends TableCubitState {
  const TableCubitChangeSortDescend();
}

class TableCubitSpotDescend extends TableCubitState {
  const TableCubitSpotDescend();
}

class TableCubitChangeSpotDescend extends TableCubitState {
  const TableCubitChangeSpotDescend();
}

class TableCubitChangeSpotAscend extends TableCubitState {
  const TableCubitChangeSpotAscend();
}

class TableCubitSpotLast extends TableCubitState {
  const TableCubitSpotLast();
}

class TableCubitChangeFutureDescend extends TableCubitState {
  const TableCubitChangeFutureDescend();
}

class TableCubitChangeFutureAscend extends TableCubitState {
  const TableCubitChangeFutureAscend();
}

class TableCubitFutureLast extends TableCubitState {
  const TableCubitFutureLast();
}

class TableCubitFutureDescend extends TableCubitState {
  const TableCubitFutureDescend();
}

class TableCubitIsLoad extends TableCubitState {
  const TableCubitIsLoad();
}

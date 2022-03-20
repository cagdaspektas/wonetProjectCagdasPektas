import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/base_list.dart';

part 'table_state.dart';

class TableCubit extends Cubit<TableCubitState> {
  TableCubit() : super(const ConfirmationInfoInitial()) {
    _init();
  }
  final TextEditingController searchEditingController = TextEditingController();
  List<Map<String, dynamic>> items = [];
  List<Map<String, dynamic>> itemsFuture = [];
  List<Map<String, dynamic>> itemsSpot = [];

  List<dynamic> justSpotData = [];
  List<dynamic> justFutureData = [];
  List<dynamic> searchDatas = [];
  List<String> dummyListData = [];
  bool sortOtherAsc = true;
  bool sortAsc = false;
  bool isSort = false;
  bool isSortFuture = false;
  bool isSortSpot = false;

  bool isActual = true;
  int? colorForColumnSort;

  int? sortColumnIndex;

  bool isLoading = false;
  void changeLoading() {
    isLoading = !isLoading;
    emit(TableCubitIsLoad());
  }

  Future<void> _init() async {
    changeLoading();
    await justSpot();
    await justFuture();
    searchDatas = listStaticData;

    changeLoading();
  }

  void name(columnIndex, sortAscending) {
    if (columnIndex == sortColumnIndex) {
      sortAsc = sortOtherAsc = sortAscending;
      emit(const TableCubitChangeSortAscend());
    } else {
      sortAsc = sortOtherAsc;
      sortColumnIndex = columnIndex;
      emit(const TableCubitChangeSortDescend());
    }
    sortDescending();

    if (!sortAscending) {
      listData = listData.reversed.toList();
      colorForColumnSort = 2;

      emit(TableCubitSortAscend());
    }
  }

  void sortJustSpots(columnIndex, sortAscending) {
    if (columnIndex == sortColumnIndex) {
      sortAsc = sortOtherAsc = sortAscending;
      emit(TableCubitChangeSpotDescend());
    } else {
      sortAsc = sortOtherAsc;
      sortColumnIndex = columnIndex;
      emit(TableCubitChangeSpotAscend());
    }
    sortSpotDescending();

    if (!sortAscending) {
      justSpotData = justSpotData.reversed.toList();
      colorForColumnSort = 2;

      emit(TableCubitSpotLast());
    }
  }

  void sortJustFutures(columnIndex, sortAscending) {
    if (columnIndex == sortColumnIndex) {
      sortAsc = sortOtherAsc = sortAscending;
      emit(TableCubitChangeFutureDescend());
    } else {
      sortAsc = sortOtherAsc;
      sortColumnIndex = columnIndex;
      emit(TableCubitChangeFutureAscend());
    }
    sortFutureDescending();

    if (!sortAscending) {
      justFutureData = justFutureData.reversed.toList();
      colorForColumnSort = 2;

      emit(TableCubitFutureLast());
    }
  }

  void reloadData() {
    items = List.from(listStaticData);
    isActual = true;
    colorForColumnSort = 0;

    emit(TableCubitReload());
  }

  void reloadSpotData() {
    itemsSpot = List.from(justSpotData);
    isSortSpot = true;
    colorForColumnSort = 0;

    emit(TableCubitSpotReload());
  }

  void reloadFuturesData() {
    itemsFuture = List.from(justFutureData);
    isSortFuture = true;
    colorForColumnSort = 0;

    emit(TableCubitFutureReload());
  }

  Future<void> sortDescending() async {
    listData.sort((a, b) => a['base'].toString().compareTo(b['base'].toString()));
    isActual = false;
    colorForColumnSort = 1;
    emit(TableCubitSortDescend());
  }

  Future<void> sortSpotDescending() async {
    justSpotData.sort((a, b) => a['base'].toString().compareTo(b['base'].toString()));
    isActual = false;
    colorForColumnSort = 1;
    emit(TableCubitSpotDescend());
  }

  Future<void> sortFutureDescending() async {
    justFutureData.sort((a, b) => a['base'].toString().compareTo(b['base'].toString()));
    isActual = false;
    colorForColumnSort = 1;
    emit(TableCubitFutureDescend());
  }

  Future<void> justSpot() async {
    for (var i = 0; i < listData.length; i++) {
      if (listData[i]["type"] == 'SPOT') {
        justSpotData.add(listData[i]);
      }
    }
  }

  Future<void> justFuture() async {
    for (var i = 0; i < listData.length; i++) {
      if (listData[i]["type"] == 'FUTURES') {
        justFutureData.add(listData[i]);
      }
    }
  }

  void filterSearch(String enteredKeyword) {
    List<dynamic> results = [];

    if (enteredKeyword.isEmpty) {
      results = listStaticData;
    } else {
      isActual = true;
      results = listStaticData
          .where((user) =>
              user["base"].toLowerCase().contains(enteredKeyword.toLowerCase()) ||
              user["quote"].toLowerCase().contains(enteredKeyword.toLowerCase()) ||
              user["type"].toLowerCase().contains(enteredKeyword.toLowerCase()) ||
              user["lastPrice"].toString().contains(enteredKeyword.toString()) ||
              user["volume"].toString().contains(enteredKeyword.toString()))
          .toList();
      emit(TableCubitReload());
    }

    searchDatas = results;
    emit(TableCubitReload());
  }
}

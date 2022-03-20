import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wonet_project_cagdas_pektas/feature/table/model/base_list.dart';

import '../viewModel/cubit/table_cubit.dart';

class TableView extends StatelessWidget {
  const TableView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => TableCubit(),
        child: BlocConsumer<TableCubit, TableCubitState>(
          listener: (context, state) {},
          builder: (context, state) {
            var reader = context.read<TableCubit>();
            return DefaultTabController(
              length: 3,
              child: Scaffold(
                  appBar: AppBar(
                    bottom: const TabBar(
                      tabs: [
                        Tab(
                          text: 'All',
                        ),
                        Tab(
                          text: 'Spot',
                        ),
                        Tab(
                          text: 'Futures',
                        ),
                      ],
                    ),
                    title: const Text('Woo Network Project'),
                    centerTitle: true,
                  ),
                  body: reader.isLoading
                      ? CircularProgressIndicator()
                      : TabBarView(
                          children: [_allData(reader), _justSpot(reader), _justFuture(reader)],
                        )),
            );
          },
        ));
  }

  Column _justFuture(TableCubit reader) {
    return Column(
      children: [
        Expanded(
            child: SingleChildScrollView(
          child: DataTable(
            horizontalMargin: 0,
            sortColumnIndex: reader.sortColumnIndex,
            sortAscending: reader.sortAsc,
            columnSpacing: 20.0,
            headingRowColor: MaterialStateColor.resolveWith((states) {
              if (reader.colorForColumnSort == 1) {
                return Colors.blue;
              } else if (reader.colorForColumnSort == 2) {
                return Colors.teal;
              } else {
                return Colors.white;
              }
            }),
            columns: <DataColumn>[
              DataColumn(
                onSort: (columnIndex, ascending) {
                  reader.sortJustFutures(columnIndex, ascending);
                },
                label: Row(
                  children: [
                    Text('symbol'),
                    IconButton(
                        onPressed: (() {
                          reader.reloadFuturesData();
                        }),
                        icon: const Icon(Icons.replay_outlined, size: 17))
                  ],
                ),
              ),
              DataColumn(
                onSort: (columnIndex, ascending) {
                  reader.sortJustFutures(columnIndex, ascending);
                },
                label: Row(
                  children: [
                    Text('LastPrice'),
                    IconButton(
                        onPressed: (() {
                          reader.reloadFuturesData();
                        }),
                        icon: const Icon(Icons.replay_outlined, size: 17))
                  ],
                ),
              ),
              DataColumn(
                onSort: (columnIndex, ascending) {
                  reader.sortJustFutures(columnIndex, ascending);
                },
                label: Row(
                  children: [
                    Text('volume'),
                    IconButton(
                        onPressed: (() {
                          reader.reloadFuturesData();
                        }),
                        icon: const Icon(Icons.replay_outlined, size: 17))
                  ],
                ),
              ),
            ],
            rows: reader.isSortFuture
                ? reader.itemsFuture
                    .map(
                      ((element) => DataRow(
                            cells: <DataCell>[
                              DataCell(element['type'] == 'SPOT'
                                  ? Text('${element['base']} / ${element['quote']}')
                                  : Text('${element['base']} / PERP')),
                              DataCell(Text('\$${element["lastPrice"].toString()}')),
                              DataCell(Text('\$${element["volume"].toString()}')),
                            ],
                          )),
                    )
                    .toList()
                : reader.justFutureData
                    .map(
                      ((element) => DataRow(
                            cells: <DataCell>[
                              DataCell(element['type'] == 'SPOT'
                                  ? Text('${element['base']} / ${element['quote']}')
                                  : Text('${element['base']} / PERP')),
                              DataCell(Text('\$${element["lastPrice"].toString()}')),
                              DataCell(Text('\$${element["volume"].toString()}')),
                            ],
                          )),
                    )
                    .toList(),
          ),
        ))
      ],
    );
  }

  Column _justSpot(TableCubit reader) {
    return Column(
      children: [
        Expanded(
            child: SingleChildScrollView(
          child: DataTable(
            horizontalMargin: 0,
            sortColumnIndex: reader.sortColumnIndex,
            sortAscending: reader.sortAsc,
            columnSpacing: 2.0,
            headingRowColor: MaterialStateColor.resolveWith((states) {
              if (reader.colorForColumnSort == 1) {
                return Colors.blue;
              } else if (reader.colorForColumnSort == 2) {
                return Colors.teal;
              } else {
                return Colors.white;
              }
            }),
            columns: <DataColumn>[
              DataColumn(
                onSort: (columnIndex, ascending) {
                  reader.sortJustSpots(columnIndex, ascending);
                },
                label: Row(
                  children: [
                    Text('symbol'),
                    IconButton(
                        onPressed: (() {
                          reader.reloadSpotData();
                        }),
                        icon: const Icon(Icons.replay_outlined, size: 17))
                  ],
                ),
              ),
              DataColumn(
                onSort: (columnIndex, ascending) {
                  reader.sortJustSpots(columnIndex, ascending);
                },
                label: Row(
                  children: [
                    Text('LastPrice'),
                    IconButton(
                        onPressed: (() {
                          reader.reloadSpotData();
                        }),
                        icon: const Icon(Icons.replay_outlined, size: 17))
                  ],
                ),
              ),
              DataColumn(
                onSort: (columnIndex, ascending) {
                  reader.sortJustSpots(columnIndex, ascending);
                },
                label: Row(
                  children: [
                    Text('volume'),
                    IconButton(
                        onPressed: (() {
                          reader.reloadSpotData();
                        }),
                        icon: const Icon(Icons.replay_outlined, size: 17))
                  ],
                ),
              ),
            ],
            rows: reader.isSortSpot
                ? reader.itemsSpot
                    .map(
                      ((element) => DataRow(
                            cells: <DataCell>[
                              DataCell(element['type'] == 'SPOT'
                                  ? Text('${element['base']} / ${element['quote']}')
                                  : Text('${element['base']} / PERP')),
                              DataCell(Text('\$${element["lastPrice"].toString()}')),
                              DataCell(Text('\$${element["volume"].toString()}')),
                            ],
                          )),
                    )
                    .toList()
                : reader.justSpotData
                    .map(
                      ((element) => DataRow(
                            cells: <DataCell>[
                              DataCell(element['type'] == 'SPOT'
                                  ? Text('${element['base']} / ${element['quote']}')
                                  : Text('${element['base']} / PERP')),
                              DataCell(Text('\$${element["lastPrice"].toString()}')),
                              DataCell(Text('\$${element["volume"].toString()}')),
                            ],
                          )),
                    )
                    .toList(),
          ),
        ))
      ],
    );
  }

  Column _allData(TableCubit reader) {
    return Column(
      children: [
        _searchBar(reader),
        Expanded(
            child: SingleChildScrollView(
          child: DataTable(
              horizontalMargin: 0,
              sortColumnIndex: reader.sortColumnIndex,
              sortAscending: reader.sortAsc,
              columnSpacing: 2.0,
              headingRowColor: MaterialStateColor.resolveWith((states) {
                if (reader.colorForColumnSort == 1) {
                  return Colors.blue;
                } else if (reader.colorForColumnSort == 2) {
                  return Colors.teal;
                } else {
                  return Colors.white;
                }
              }),
              columns: <DataColumn>[
                DataColumn(
                  onSort: (columnIndex, sortAscending) {
                    reader.name(columnIndex, sortAscending);
                  },
                  label: Row(
                    children: [
                      Text('symbol'),
                      IconButton(
                          onPressed: (() {
                            reader.reloadData();
                          }),
                          icon: const Icon(Icons.replay_outlined, size: 17))
                    ],
                  ),
                ),
                DataColumn(
                  onSort: (columnIndex, sortAscending) {
                    reader.name(columnIndex, sortAscending);
                  },
                  label: Row(
                    children: [
                      Text('LastPrice'),
                      IconButton(
                          onPressed: (() {
                            reader.reloadData();
                          }),
                          icon: const Icon(Icons.replay_outlined, size: 17))
                    ],
                  ),
                ),
                DataColumn(
                  onSort: (columnIndex, sortAscending) {
                    reader.name(columnIndex, sortAscending);
                  },
                  label: Row(
                    children: [
                      Text('volume'),
                      IconButton(
                          onPressed: (() {
                            reader.reloadData();
                          }),
                          icon: const Icon(Icons.replay_outlined, size: 17))
                    ],
                  ),
                ),
              ],
              rows: reader.isActual
                  ? reader.searchDatas
                      .map(
                        ((element) => DataRow(
                              cells: <DataCell>[
                                DataCell(element['type'] == 'SPOT'
                                    ? Text("${element['base']} / ${element['quote']}")
                                    : Text('${element['base']} / PERP')),
                                DataCell(Text('\$${element["lastPrice"].toString()}')),
                                DataCell(Text('\$${element["volume"].toString()}')),
                              ],
                            )),
                      )
                      .toList()
                  : listData
                      .map(
                        ((element) => DataRow(
                              cells: <DataCell>[
                                DataCell(element['type'] == 'SPOT'
                                    ? Text("${element['base']} / ${element['quote']}")
                                    : Text('${element['base']} / PERP')), //Extracting from Map element the value
                                DataCell(Text('\$${element["lastPrice"].toString()}')),
                                DataCell(Text(
                                  '\$${element["volume"].toString()}',
                                )),
                              ],
                            )),
                      )
                      .toList()),
        ))
      ],
    );
  }

  Padding _searchBar(TableCubit reader) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: reader.searchEditingController,
        onChanged: (value) {
          reader.filterSearch(value);
        },
        decoration: const InputDecoration(
            labelText: "Search",
            hintText: "Search",
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(25.0)))),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:sticky_headers_table/StickyHeadersTable.dart';
import 'package:sticky_headers_table/StickyTableCell.dart';

void main() {
  final columns = 10;
  final rows = 20;

  List<List<String>> _makeData() {
    final List<List<String>> output = [];
    for (int i = 0; i < columns; i++) {
      final List<String> row = [];
      for (int j = 0; j < rows; j++) {
        row.add('T$i : L$j');
      }
      output.add(row);
    }
    return output;
  }

  /// Simple generator for column title
  List<String> _makeTitleColumn() => List.generate(columns, (i) => 'Top $i');

  /// Simple generator for row title
  List<String> _makeTitleRow() => List.generate(rows, (i) => 'Left $i');

  runApp(
    TableTapHandlerHighlightSelectedCell(
      titleColumn: _makeTitleColumn(),
      titleRow: _makeTitleRow(),
      data: _makeData(),
    ),
  );
}

class TableTapHandlerHighlightSelectedCell extends StatefulWidget {
  TableTapHandlerHighlightSelectedCell(
      {@required this.data,
      @required this.titleColumn,
      @required this.titleRow});

  final List<List<String>> data;
  final List<String> titleColumn;
  final List<String> titleRow;

  @override
  _TableTapHandlerHighlightSelectedCellState createState() =>
      _TableTapHandlerHighlightSelectedCellState();
}

class _TableTapHandlerHighlightSelectedCellState
    extends State<TableTapHandlerHighlightSelectedCell> {
  int selectedRow;
  int selectedColumn;

  Color getContentColor(int i, int j) {
    if (i == selectedRow && j == selectedColumn) {
      return Colors.amberAccent;
    }
    // else if (i == selectedRow || j == selectedColumn) {
    //   return Colors.amberAccent;
    // }
    else {
      return Colors.transparent;
    }
  }

  void clearState() => setState(() {
        selectedRow = null;
        selectedColumn = null;
      });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Sticky Table',
            maxLines: 2,
          ),
          backgroundColor: Colors.amber,
        ),
        body: Column(
          children: <Widget>[
            Container(
              width: 100,
              height: 100,
              // margin: EdgeInsets.all(20),
              color: Colors.red,
              child: Text(
                'big boom',
                style: TextStyle(color: Colors.blue, fontSize: 20),
              ),
            ),
            Expanded(
              child: StickyHeadersTable(
                columnsLength: widget.titleColumn.length,
                rowsLength: widget.titleRow.length,
                isStickyColumn: true,
                isStickyRow: true,
                legendCell: StickyTableCell.legend(
                  'Charts',
                  bgColor: Colors.amberAccent,
                  textStyle: textTheme.button
                      .copyWith(fontSize: 15.0, color: Colors.white),
                  onTap: clearState,
                ),
                columnsTitleBuilder: (i) {
                  return StickyTableCell.stickyRow(
                    widget.titleColumn[i],
                    bgColor: Colors.blueAccent,
                    textStyle: textTheme.button
                        .copyWith(fontSize: 15.0, color: Colors.white),
                    onTap: clearState,
                  );
                },
                rowsTitleBuilder: (i) {
                  return StickyTableCell.stickyColumn(
                    widget.titleRow[i],
                    bgColor: Colors.blueAccent,
                    textStyle: textTheme.button
                        .copyWith(fontSize: 15.0, color: Colors.white),
                    onTap: clearState,
                  );
                },
                contentCellBuilder: (i, j) {
                  TextStyle mainStyle =
                      textTheme.body2.copyWith(fontSize: 12.0);
                  if (i == 2) {
                    mainStyle = TextStyle(color: Colors.red, fontSize: 14);
                  }
                  return StickyTableCell.content(
                    widget.data[i][j],
                    textStyle: mainStyle,
                    bgColor: getContentColor(i, j),
                    onTap: () {
                      print('您点击了${widget.data[i][j]}');
                      setState(() {
                        selectedColumn = j;
                        selectedRow = i;
                      });
                    },
                  );
                },
              ),
            ),
            Container(
              width: 100,
              height: 100,
              // margin: EdgeInsets.all(20),
              color: Colors.red,
              child: Text(
                'big boom',
                style: TextStyle(color: Colors.blue, fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

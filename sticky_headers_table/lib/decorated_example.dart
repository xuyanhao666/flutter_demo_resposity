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
    TableDecorated(
      titleColumn: _makeTitleColumn(),
      titleRow: _makeTitleRow(),
      data: _makeData(),
    ),
  );
}

class TableDecorated extends StatelessWidget {
  TableDecorated(
      {@required this.data,
      @required this.titleColumn,
      @required this.titleRow});

  final List<List<String>> data;
  final List<String> titleColumn;
  final List<String> titleRow;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text(
              'Sticky Headers Two-Dimension  Table decorated',
              maxLines: 2,
            ),
            backgroundColor: Colors.blue,
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
                  isStickyColumn: true,
                  isStickyRow: true,
                  columnsLength: titleColumn.length,
                  rowsLength: titleRow.length,
                  columnsTitleBuilder: (i) => StickyTableCell.stickyRow(
                    titleColumn[i],
                    textStyle: textTheme.button.copyWith(fontSize: 15.0),
                  ),
                  rowsTitleBuilder: (i) => StickyTableCell.stickyColumn(
                    titleRow[i],
                    textStyle: textTheme.button.copyWith(fontSize: 15.0),
                  ),
                  contentCellBuilder: (i, j) {
                    TextStyle mainStyle =
                        textTheme.body2.copyWith(fontSize: 12.0);
                    if (i == 2) {
                      mainStyle = TextStyle(color: Colors.red, fontSize: 14);
                    }
                    return StickyTableCell.content(
                      data[i][j],
                      textStyle: mainStyle,
                      onTap: () {
                        print('您点击了${data[i][j]}');
                      },
                    );
                  },
                  legendCell: StickyTableCell.legend(
                    'Sticky Legend',
                    textStyle: textTheme.button.copyWith(fontSize: 16.5),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}

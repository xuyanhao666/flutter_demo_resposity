//cell的自定义
import 'package:flutter/material.dart';
import 'package:sticky_headers_table/StickyHeadersTable.dart';

class StickyTableCell extends StatelessWidget {
  StickyTableCell.content(
    this.text, {
    this.textStyle,
    this.cellDimensions = CellDimensions.base,
    this.bgColor = Colors.white,
    this.borderColor = Colors.blue,
    this.onTap,
  })  : cellWidth = cellDimensions.contentCellWidth,
        cellHeight = cellDimensions.contentCellHeight,
        _textAlign = TextAlign.center,
        _padding = EdgeInsets.zero;

  StickyTableCell.legend(
    this.text, {
    this.textStyle,
    this.cellDimensions = CellDimensions.base,
    this.bgColor = Colors.white,
    this.borderColor = Colors.blue,
    this.onTap,
  })  : cellWidth = cellDimensions.stickyLegendWidth,
        cellHeight = cellDimensions.stickyLegendHeight,
        _textAlign = TextAlign.center,
        _padding = EdgeInsets.zero;

  StickyTableCell.stickyRow(
    this.text, {
    this.textStyle,
    this.cellDimensions = CellDimensions.base,
    this.bgColor = Colors.white,
    this.borderColor = Colors.blue,
    this.onTap,
  })  : cellWidth = cellDimensions.contentCellWidth,
        cellHeight = cellDimensions.stickyLegendHeight,
        _textAlign = TextAlign.center,
        _padding = EdgeInsets.zero;

  StickyTableCell.stickyColumn(
    this.text, {
    this.textStyle,
    this.cellDimensions = CellDimensions.base,
    this.bgColor = Colors.white,
    this.borderColor = Colors.blue,
    this.onTap,
  })  : cellWidth = cellDimensions.stickyLegendWidth,
        cellHeight = cellDimensions.contentCellHeight,
        _textAlign = TextAlign.center,
        _padding = EdgeInsets.zero;

  final CellDimensions cellDimensions;

  final String text;
  final Function onTap;

  final double cellWidth;
  final double cellHeight;

  final Color bgColor;
  final Color borderColor;

  final TextAlign _textAlign;
  final EdgeInsets _padding;

  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: cellWidth,
        height: cellHeight,
        padding: _padding,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 2.0),
                child: Text(
                  text,
                  style: textStyle,
                  maxLines: 2,
                  textAlign: _textAlign,
                ),
              ),
            ),
            // Container(
            //   width: double.infinity,
            //   height: 1.1,
            //   color: _colorVerticalBorder,
            // ),
          ],
        ),
        decoration: BoxDecoration(
            border: Border.all(
              color: borderColor,
            ),
            color: bgColor),
      ),
    );
  }
}

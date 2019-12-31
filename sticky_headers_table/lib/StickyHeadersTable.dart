import 'package:flutter/material.dart';

class StickyHeadersTable extends StatefulWidget {
  StickyHeadersTable({
    Key key,
    //列数
    @required this.columnsLength,

    //行数
    @required this.rowsLength,

    //是否固定行
    @required this.isStickyRow,

    //是否固定列
    @required this.isStickyColumn,

    //左上角title
    this.legendCell = const Text(' '),

    //列头生成器
    @required this.columnsTitleBuilder,

    //行头生成器
    @required this.rowsTitleBuilder,

    //内容content生成器
    @required this.contentCellBuilder,

    //tableCell的默认设置
    this.cellDimensions = CellDimensions.base,

    //cell的fit类型
    this.cellFit = BoxFit.scaleDown,
  }) : super(key: key) {
    assert(columnsLength != null);
    assert(rowsLength != null);
    assert(columnsTitleBuilder != null);
    assert(rowsTitleBuilder != null);
    assert(contentCellBuilder != null);
  }

  final int rowsLength;
  final int columnsLength;
  final bool isStickyRow;
  final bool isStickyColumn;
  final Widget legendCell;
  final Widget Function(int colulmnIndex) columnsTitleBuilder;
  final Widget Function(int rowIndex) rowsTitleBuilder;
  final Widget Function(int columnIndex, int rowIndex) contentCellBuilder;
  final CellDimensions cellDimensions;
  final BoxFit cellFit;

  @override
  _StickyHeadersTableState createState() => _StickyHeadersTableState();
}

class _StickyHeadersTableState extends State<StickyHeadersTable> {
  final ScrollController _verticalTitleController = ScrollController();
  final ScrollController _verticalBodyController = ScrollController();

  final ScrollController _horizontalBodyController = ScrollController();
  final ScrollController _horizontalTitleController = ScrollController();

  _SyncScrollController _verticalSyncController;
  _SyncScrollController _horizontalSyncController;

  @override
  void initState() {
    super.initState();
    _verticalSyncController = _SyncScrollController(
        [_verticalTitleController, _verticalBodyController]);
    _horizontalSyncController = _SyncScrollController(
        [_horizontalTitleController, _horizontalBodyController]);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            // STICKY LEGEND
            Container(
              width: widget.isStickyColumn && widget.isStickyRow
                  ? widget.cellDimensions.stickyLegendWidth
                  : 0,
              height: widget.isStickyColumn && widget.isStickyRow
                  ? widget.cellDimensions.stickyLegendHeight
                  : 0,
              child: FittedBox(
                fit: widget.cellFit,
                child: widget.legendCell,
              ),
            ),
            // STICKY ROW
            Expanded(
              child: NotificationListener<ScrollNotification>(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                      widget.columnsLength,
                      (i) => Container(
                        width: widget.cellDimensions.contentCellWidth,
                        height: widget.isStickyRow
                            ? widget.cellDimensions.stickyLegendHeight
                            : 0,
                        child: FittedBox(
                          fit: widget.cellFit,
                          child: widget.columnsTitleBuilder(i),
                        ),
                      ),
                    ),
                  ),
                  controller: _horizontalTitleController,
                ),
                onNotification: (ScrollNotification notification) {
                  _horizontalSyncController.processNotification(
                      notification, _horizontalTitleController);
                  return true;
                },
              ),
            )
          ],
        ),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // STICKY COLUMN
              NotificationListener<ScrollNotification>(
                child: SingleChildScrollView(
                  child: Column(
                    children: List.generate(
                      widget.rowsLength,
                      (i) => Container(
                        width: widget.isStickyColumn
                            ? widget.cellDimensions.stickyLegendWidth
                            : 0,
                        height: widget.cellDimensions.contentCellHeight,
                        child: FittedBox(
                          fit: widget.cellFit,
                          child: widget.rowsTitleBuilder(i),
                        ),
                      ),
                    ),
                  ),
                  controller: _verticalTitleController,
                ),
                onNotification: (ScrollNotification notification) {
                  _verticalSyncController.processNotification(
                      notification, _verticalTitleController);
                  return true;
                },
              ),
              // CONTENT
              Expanded(
                child: NotificationListener<ScrollNotification>(
                  onNotification: (ScrollNotification notification) {
                    _horizontalSyncController.processNotification(
                        notification, _horizontalBodyController);
                    return true;
                  },
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    controller: _horizontalBodyController,
                    child: NotificationListener<ScrollNotification>(
                      child: SingleChildScrollView(
                          controller: _verticalBodyController,
                          child: Column(
                            children: List.generate(
                              widget.rowsLength,
                              (int i) => Row(
                                children: List.generate(
                                  widget.columnsLength,
                                  (int j) => Container(
                                    width:
                                        widget.cellDimensions.contentCellWidth,
                                    height:
                                        widget.cellDimensions.contentCellHeight,
                                    child: FittedBox(
                                      fit: widget.cellFit,
                                      child: widget.contentCellBuilder(j, i),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )),
                      onNotification: (ScrollNotification notification) {
                        _verticalSyncController.processNotification(
                            notification, _verticalBodyController);
                        return true;
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CellDimensions {
  const CellDimensions({
    @required this.contentCellWidth,
    @required this.contentCellHeight,
    @required this.stickyLegendWidth,
    @required this.stickyLegendHeight,
  });

  final double contentCellWidth;
  final double contentCellHeight;
  final double stickyLegendWidth;
  final double stickyLegendHeight;

  static const CellDimensions base = CellDimensions(
    contentCellWidth: 70.0,
    contentCellHeight: 50.0,
    stickyLegendWidth: 70.0,
    stickyLegendHeight: 50.0,
  );
}

class _SyncScrollController {
  _SyncScrollController(List<ScrollController> controllers) {
    controllers
        .forEach((controller) => _registeredScrollControllers.add(controller));
  }

  final List<ScrollController> _registeredScrollControllers = [];

  ScrollController _scrollingController;
  bool _scrollingActive = false;

  processNotification(
      ScrollNotification notification, ScrollController sender) {
    if (notification is ScrollStartNotification && !_scrollingActive) {
      _scrollingController = sender;
      _scrollingActive = true;
      return;
    }

    if (identical(sender, _scrollingController) && _scrollingActive) {
      if (notification is ScrollEndNotification) {
        _scrollingController = null;
        _scrollingActive = false;
        return;
      }

      if (notification is ScrollUpdateNotification) {
        for (ScrollController controller in _registeredScrollControllers) {
          if (identical(_scrollingController, controller)) continue;
          controller.jumpTo(_scrollingController.offset);
        }
      }
    }
  }
}

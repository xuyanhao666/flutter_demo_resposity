import 'package:flutter/material.dart';

enum AnimationType { fromRight, fromLeft, fromTop, fromBottom, grow, shrink }

class PopCalender {
  final BuildContext context;
  final Widget customWidget;
  final List<Widget> buttons;
  final AnimationType animationType;
  final Color backgroundColor;

  PopCalender(
      {@required this.context,
      this.customWidget,
      this.buttons,
      this.animationType = AnimationType.grow,
      this.backgroundColor = Colors.white});

  /// Displays defined alert window
  Future<bool> show() async {
    return await showGeneralDialog(
      context: context,
      pageBuilder: (BuildContext buildContext, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return _buildDialog();
      },
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black87,
      transitionDuration: const Duration(milliseconds: 200),
      transitionBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
      ) =>
          _showAnimation(animation, secondaryAnimation, child),
    );
  }

  Widget _buildDialog() {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints.expand(
            width: double.infinity, height: double.infinity),
        child: Center(
          child: SingleChildScrollView(
            child: AlertDialog(
                backgroundColor: backgroundColor,
                shape: _defaultShape(),
                titlePadding: EdgeInsets.all(0.0),
                title: Container(),
                contentPadding: const EdgeInsets.all(10.0),
                // content: Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: _getButtons(),
                // ),
                content: Column(
                  children: <Widget>[
                    customWidget,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: _getButtons(),
                    )
                  ],
                )),
          ),
        ),
      ),
    );
  }

  // Returns defined buttons. Default: Cancel Button
  List<Widget> _getButtons() {
    List<Widget> expandedButtons = [];
    if (buttons != null) {
      buttons.forEach(
        (button) {
          var buttonWidget = Container(
            color: Colors.white,
            padding: const EdgeInsets.only(left: 2, right: 2),
            child: button,
          );
          if (buttons.length == 1) {
            expandedButtons.add(buttonWidget);
          } else {
            expandedButtons.add(Expanded(
              child: buttonWidget,
            ));
          }
        },
      );
    }
    return expandedButtons;
  }

  // Returns alert default border style
  ShapeBorder _defaultShape() {
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
      side: BorderSide(
        color: Colors.blueGrey,
      ),
    );
  }

  // Shows alert with selected animation
  _showAnimation(animation, secondaryAnimation, child) {
    if (animationType == AnimationType.fromRight) {
      return AnimationTransition.fromRight(
          animation, secondaryAnimation, child);
    } else if (animationType == AnimationType.fromLeft) {
      return AnimationTransition.fromLeft(animation, secondaryAnimation, child);
    } else if (animationType == AnimationType.fromBottom) {
      return AnimationTransition.fromBottom(
          animation, secondaryAnimation, child);
    } else if (animationType == AnimationType.grow) {
      return AnimationTransition.grow(animation, secondaryAnimation, child);
    } else if (animationType == AnimationType.shrink) {
      return AnimationTransition.shrink(animation, secondaryAnimation, child);
    } else {
      return AnimationTransition.fromTop(animation, secondaryAnimation, child);
    }
  }
}

class AnimationTransition {
  /// Slide animation, from right to left (SlideTransition)
  static fromRight(Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(1.0, 0.0),
        end: Offset.zero,
      ).animate(animation),
      child: child,
    );
  }

  /// Slide animation, from left to right (SlideTransition)
  static fromLeft(Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(-1.0, 0.0),
        end: Offset.zero,
      ).animate(animation),
      child: child,
    );
  }

  /// Slide animation, from top to bottom (SlideTransition)
  static fromTop(Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0.0, -1.0),
        end: Offset.zero,
      ).animate(animation),
      child: child,
    );
  }

  /// Slide animation, from top to bottom (SlideTransition)
  static fromBottom(Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0.0, 1.0),
        end: Offset.zero,
      ).animate(animation),
      child: child,
    );
  }

  /// Scale animation, from in to out (ScaleTransition)
  //缩放效果
  static grow(Animation<double> animation, Animation<double> secondaryAnimation,
      Widget child) {
    return ScaleTransition(
        scale: Tween(begin: 0.0, end: 1.0)
            .animate(CurvedAnimation(parent: animation, curve: Curves.linear)),
        child: child);
  }

  /// Scale animation, from out to in (ScaleTransition)
  static shrink(Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return ScaleTransition(
      scale: Tween<double>(
        begin: 1.2,
        end: 1.0,
      ).animate(
        CurvedAnimation(
          parent: animation,
          curve: Interval(
            0.50,
            1.00,
            curve: Curves.linear,
          ),
        ),
      ),
      child: child,
    );
  }
}

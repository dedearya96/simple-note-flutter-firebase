import 'package:flutter/material.dart';

class FadeRouteBuilder<T> extends PageRouteBuilder<T> {
  final Widget page;
  FadeRouteBuilder({@required this.page})
      : super(
            pageBuilder: (context, animation1, animation2) => page,
            transitionsBuilder: (context, animation1, animation2, child) {
              return FadeTransition(opacity: animation1, child: child);
            });
}

class SlideRightRoute<T> extends PageRouteBuilder<T> {
  final Widget page;
  SlideRightRoute({this.page})
      : super(
            pageBuilder: (BuildContext context, Animation<double> animation,
                    Animation<double> secondaryAnimation) =>
                page,
            transitionsBuilder: (BuildContext context,
                    Animation<double> animation,
                    Animation<double> secondaryAnimation,
                    Widget child) =>
                SlideTransition(
                  position: Tween<Offset>(
                          begin: const Offset(-1, 0), end: Offset.zero)
                      .animate(animation),
                  child: child,
                ));
}

class SlideLeftRoute<T> extends PageRouteBuilder<T> {
  final Widget page;
  SlideLeftRoute({this.page})
      : super(
            pageBuilder: (BuildContext context, Animation<double> animation,
                    Animation<double> secondaryAnimation) =>
                page,
            transitionsBuilder: (BuildContext context,
                    Animation<double> animation,
                    Animation<double> secondaryAnimation,
                    Widget child) =>
                SlideTransition(
                  position: Tween<Offset>(
                          begin:  const Offset(1.0,0.0), end:Offset.zero)
                      .animate(animation),
                  child: child,
                ));
}

class ScaleRoute<T> extends PageRouteBuilder<T> {
  final Widget page;
  ScaleRoute({this.page})
      : super(
            pageBuilder: (BuildContext context, Animation<double> animation,
                    Animation<double> secondaryAnimation) =>
                page,
            transitionsBuilder: (BuildContext context,
                    Animation<double> animation,
                    Animation<double> secondaryAnimation,
                    Widget child) =>
                ScaleTransition(
                  scale: Tween<double>(begin: 0.0, end: 1.0).animate(
                      CurvedAnimation(
                          curve: Curves.fastOutSlowIn, parent: animation)),
                  child: child,
                ));
}

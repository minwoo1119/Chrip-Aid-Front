import 'package:flutter/material.dart';
import 'package:chrip_aid/common/styles/styles.dart';

class DefaultLayout extends StatelessWidget {
  final String? title;
  final Widget? leading;
  final double? leadingWidth;
  final double? appbarHeight;
  final Color appbarColor;
  final Widget? drawer;
  final Color backgroundColor;
  final Widget? bottomNavigationBar;
  final Widget child;
  final Widget? floatingActionButton;

  const DefaultLayout({
    Key? key,
    this.title,
    this.leading,
    this.leadingWidth,
    this.appbarHeight,
    this.appbarColor = Colors.transparent,
    this.drawer,
    this.backgroundColor = Colors.white,
    this.bottomNavigationBar,
    required this.child,
    this.floatingActionButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      backgroundColor: backgroundColor,
      drawer: drawer,
      floatingActionButton: floatingActionButton,
      body: child,
      bottomNavigationBar: bottomNavigationBar,
    );
  }

  AppBar? _appBar() => title == null
      ? null
      : AppBar(
          toolbarHeight: appbarHeight,
          centerTitle: true,
          backgroundColor: appbarColor,
          leading: leading,
          leadingWidth: leadingWidth,
          elevation: 0,
          title: Text(title!, style: kTextReverseStyleLarge),
          foregroundColor: Colors.black,
        );
}

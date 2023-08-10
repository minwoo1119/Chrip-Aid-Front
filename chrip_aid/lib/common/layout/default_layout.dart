import 'package:flutter/material.dart';
import 'package:chrip_aid/common/styles/styles.dart';
import 'package:flutter/services.dart';

class DefaultLayout extends StatelessWidget {
  final String? title;
  final Widget? leading;
  final double? leadingWidth;
  final double? appbarHeight;
  final Color? appbarColor;
  final Widget? drawer;
  final Color backgroundColor;
  final Widget? bottomNavigationBar;
  final Widget child;

  const DefaultLayout({
    Key? key,
    this.title,
    this.leading,
    this.leadingWidth,
    this.appbarHeight,
    this.appbarColor,
    this.drawer,
    this.backgroundColor = Colors.white,
    this.bottomNavigationBar,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: appbarColor ?? CustomColor.mainColor,
    ));

    return Scaffold(
      appBar: _appBar(),
      backgroundColor: backgroundColor,
      drawer: drawer,
      body: SafeArea(child: child),
      bottomNavigationBar: bottomNavigationBar,
    );
  }

  AppBar? _appBar() => title == null
      ? null
      : AppBar(
          toolbarHeight: appbarHeight,
          centerTitle: true,
          backgroundColor: appbarColor ?? CustomColor.mainColor,
          leading: leading,
          leadingWidth: leadingWidth,
          elevation: 0,
          title: Text(title!, style: kTextReverseStyleLarge),
          foregroundColor: Colors.black,
        );
}

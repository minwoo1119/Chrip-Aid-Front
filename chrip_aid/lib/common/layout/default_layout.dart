import 'package:flutter/material.dart';
import 'package:chrip_aid/common/styles/styles.dart';

class DefaultLayout extends StatelessWidget {
  final String? title;
  final TextStyle? titleStyle;
  final Widget? leading;
  final List<Widget>? actions;
  final double? leadingWidth;
  final double? appbarHeight;
  final Color appbarColor;
  final Widget? drawer;
  final Color backgroundColor;
  final Widget? bottomNavigationBar;
  final Widget child;
  final Widget? floatingActionButton;
  final bool extendBodyBehindAppBar;

  const DefaultLayout({
    Key? key,
    this.title,
    this.leading,
    this.leadingWidth,
    this.appbarHeight,
    this.appbarColor = Colors.transparent,
    this.drawer,
    this.titleStyle,
    this.backgroundColor = Colors.white,
    this.bottomNavigationBar,
    required this.child,
    this.floatingActionButton,
    this.extendBodyBehindAppBar = false, this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: extendBodyBehindAppBar,
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
          actions: actions,
          elevation: 0,
          title: Text(
            title!,
            style: titleStyle ??
                kTextReverseStyleLarge.copyWith(fontWeight: FontWeight.bold),
          ),
          foregroundColor: Colors.black,
        );
}
